---
name: four-keys
description: DORA Four Keys メトリクスを GitHub CLI で取得・表示
allowed-tools: Bash(gh release list:*), Bash(gh pr list:*), Bash(gh api:*), Bash(date:*), Bash(jq:*), Bash(awk:*)
---

# Four Keys メトリクス取得

現在のリポジトリの DORA Four Keys メトリクスを GitHub CLI で取得し、レポートを出力する。

## 引数

`$ARGUMENTS` をパースして以下のオプションを認識する。

| 引数 | 説明 | 例 |
|------|------|-----|
| 数値のみ | 計測期間（日数） | `/four-keys 90` |
| `--by-user` | ユーザーごとの内訳を表示 | `/four-keys --by-user` |
| 組み合わせ | 両方指定可能 | `/four-keys 90 --by-user` |

- 日数の指定がなければデフォルト **30日**
- `--by-user` 指定時は、リポジトリ全体のメトリクスに加えて、ユーザーごとの Lead Time と Review Speed の内訳テーブルを追加表示する
- Deployment Frequency / Change Failure Rate / Time to Restore はリポジトリ全体でのみ意味があるため、ユーザー内訳には含めない

## 実行手順

以下の手順を順番に実行し、最後にレポートを出力すること。

### Step 1: 引数の解析

- `$ARGUMENTS` から数値（日数）と `--by-user` フラグを抽出する
- 数値がなければ 30 をデフォルトとする
- 計測開始日を `date` コマンドで算出する（ISO 8601 形式）

### Step 2: データ収集

以下の `gh` コマンドを実行してデータを取得する。

#### 2a. リリース一覧

```bash
gh release list --json tagName,publishedAt,isPrerelease --limit 100
```

- `publishedAt` が計測期間内のリリースのみを対象とする
- `isPrerelease: true` のものは除外する

#### 2b. マージ済み PR 一覧

```bash
gh pr list --state merged --json number,title,createdAt,mergedAt,headRefName,labels,author --limit 300 --search "merged:>={開始日}"
```

- `mergedAt` が計測期間内の PR のみを対象とする

#### 2c. PR レビューデータ

```bash
gh pr list --state merged --json number,createdAt,mergedAt --limit 300 --search "merged:>={開始日} review:approved"
```

各 PR のレビュー詳細を取得する（期間内の PR から最大50件サンプリング）：

```bash
gh api graphql -f query='
query($owner: String!, $repo: String!, $number: Int!) {
  repository(owner: $owner, name: $repo) {
    pullRequest(number: $number) {
      createdAt
      reviews(first: 10, states: [APPROVED, CHANGES_REQUESTED, COMMENTED]) {
        nodes {
          submittedAt
          author {
            login
            ... on Bot { id }
          }
        }
      }
    }
  }
}' -f owner='{owner}' -f repo='{repo}' -F number={number}
```

**レビューの bot 除外**: 以下の条件に該当するレビューは除外し、残ったレビューの中で最も早い `submittedAt` を「最初の人間レビュー」とする：

- `author` が Bot 型である（GraphQL の `... on Bot` でマッチ）
- `author.login` が以下のいずれかに該当する（大文字小文字不問、部分一致）：
  - `bot`, `[bot]`
  - `devin-ai`, `devin`
  - `greptile`
  - `codex`
  - `copilot`
  - `github-actions`
  - `dependabot`
  - `renovate`
  - `codecov`
  - `sonarcloud`, `sonarqube`
  - `linear`
  - `vercel`
  - `netlify`
  - `changeset`

- 人間のレビューが 0 件の PR はレビュー速度の集計から除外する
- `createdAt` から最初の人間レビューの `submittedAt` までの時間差を「レビュー待ち時間」とする

### Step 3: メトリクス計算

取得データから以下の 4 指標を計算する。

#### 3a. Deployment Frequency（デプロイ頻度）

- 期間内のリリース数を算出
- リリース数 / 週数（期間日数 / 7）で「回/週」を計算

#### 3b. Lead Time for Changes（変更リードタイム）

- 各マージ済み PR について `mergedAt - createdAt` の時間差を算出
- 全 PR の中央値を「リードタイム」とする（外れ値の影響を減らすため中央値を使用）

#### 3c. Change Failure Rate（変更失敗率）

以下の条件に一つでも該当するリリースを「失敗起因の変更」とカウントする：

- リリースの `tagName` に `hotfix` を含む（大文字小文字不問）
- リリースタグ間のマージ済み PR のうち、以下のいずれかに該当するものが存在する：
  - PR タイトルが `revert` で始まる（大文字小文字不問）
  - PR タイトルが `hotfix` を含む（大文字小文字不問）
  - PR の `headRefName` が `hotfix/` で始まる

計算式: `失敗起因リリース数 / 全リリース数 * 100`（%）

#### 3d. Review Speed（レビュー速度）

- 各 PR について `最初のレビュー submittedAt - createdAt` の時間差を算出
- 中央値を「レビュー待ち時間（Time to First Review）」とする
- `mergedAt - 最初のレビュー submittedAt` の中央値を「レビュー後マージ時間」とする
- レビューデータがない場合は「N/A」と表示

#### 3e. Time to Restore Service（サービス復旧時間）

- 失敗起因リリースを特定（上記 3c の判定ロジック）
- 各失敗リリースの `publishedAt` から、次のリリースの `publishedAt` までの時間差を算出
- 全失敗リリースの平均値を「復旧時間」とする
- 失敗リリースがない場合は「N/A」と表示

### Step 4: DORA レベル判定

各指標を以下の基準でレベル判定する。

| 指標 | Elite | High | Medium | Low |
|------|-------|------|--------|-----|
| Deployment Frequency | 1日1回以上（7回/週〜） | 週1〜日1（1〜7回/週） | 月1〜週1（0.25〜1回/週） | 月1未満（< 0.25回/週） |
| Lead Time for Changes | < 1時間 | < 24時間 | < 168時間（1週間） | >= 168時間 |
| Change Failure Rate | < 5% | < 10% | < 15% | >= 15% |
| Time to Restore Service | < 1時間 | < 24時間 | < 168時間（1週間） | >= 168時間 |
| Review Speed (Time to First Review) | < 1時間 | < 4時間 | < 24時間 | >= 24時間 |

総合レベルは Four Keys の 4 指標（Review Speed を除く）の中で最も多いレベルとする（同数の場合は低い方を採用）。
Review Speed は補助指標として別途表示する。

### Step 5: レポート出力

以下のフォーマットで結果を出力すること。時間の表示は人間が読みやすい単位に変換する（例: 1.5時間、3.2日）。

```
## Four Keys Metrics（過去 {N} 日間）

| 指標 | 値 | レベル |
|------|-----|--------|
| Deployment Frequency | {X}回/週 | {level} |
| Lead Time for Changes | {X}時間 | {level} |
| Change Failure Rate | {X}% | {level} |
| Time to Restore Service | {X}時間 | {level} |

**総合レベル: {level}**

### Review Metrics（補助指標）

| 指標 | 値 | レベル |
|------|-----|--------|
| Time to First Review | {X}時間 | {level} |
| Review to Merge Time | {X}時間 | - |

### 詳細データ
- 計測期間: {開始日} 〜 {終了日}
- リリース数: {N}（うち失敗起因: {N}）
- マージ済みPR数: {N}
- レビューサンプル数: {N}
```

### `--by-user` 指定時の追加出力

リポジトリ全体のレポートの後に、以下のユーザー別内訳テーブルを追加する。
PR の `author.login` でグルーピングし、PR数が多い順にソートして表示する。

```
### User Breakdown

| ユーザー | PR数 | Lead Time (中央値) | Time to First Review (中央値) | Review to Merge (中央値) |
|----------|------|-------------------|------------------------------|--------------------------|
| @user-a  | 15   | 3.2時間            | 1.1時間                       | 0.8時間                   |
| @user-b  | 12   | 8.5時間            | 2.3時間                       | 4.2時間                   |
| @user-c  | 8    | 22.1時間           | 5.7時間                       | 12.0時間                  |
```

- 各ユーザーの PR のみを対象に Lead Time / Review Speed を個別計算する
- bot ユーザー（login に `[bot]` を含む、または `dependabot`, `renovate` など）は除外する
- PR数が 1 件のユーザーも表示する（中央値 = その1件の値）

## 注意事項

- リリースが 0 件の場合、Deployment Frequency は 0、Change Failure Rate は N/A、Time to Restore は N/A と表示する
- マージ済み PR が 0 件の場合、Lead Time は N/A と表示する
- `gh` コマンドがエラーを返した場合は、リポジトリが GitHub にホストされているか確認を促すメッセージを表示する
- 全ての計算は UTC 基準で行う
