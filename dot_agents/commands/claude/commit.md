---
allowed-tools:
  - Bash(git commit:*)
  - Bash(git diff:*)
  - Bash(git add:*)
  - Bash(gh pr view)
  - Bash(fetch:*)
description: Run `git commit` with the inference from the diff
---

Read all the difference files, create a commit message from the changes, and execute git commit.

If there are multiple contexts or they don't fit on a single line, you can split them onto multiple lines.

## Commit Targets

If there is already at least one staged file, it will only be targeted and new `git add` commands to add more files will not be allowed.

## Commit message role

The following link is the absolute rule for commit messages.

https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional
