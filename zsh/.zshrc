########################################
# 環境変数
export LANG=ja_JP.UTF-8

# ヒストリの設定
HISTFILE=${HOME}/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

########################################
# env

# rbenvのpath設定
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

########################################
# brew

# brewfile を自動で更新する
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# brewfile の場所を変更する
export HOMEBREW_BREWFILE=~/dotfiles/Brewfile

########################################
# terminal color

# 色を使用出来るようにする
autoload -Uz colors
colors

# ls でフォルダに色をつける
# フォルダを黄、シンボリックリンクを赤
export LSCOLORS=dxbx
alias ls="ls -GF"

# プロンプトのレイアウト
PROMPT="%{${fg[cyan]}%}[%*] %{${fg[yellow]}%} %~
%{${fg[magenta]}%}% ==> # %{${reset_color}%}"

########################################

# 補完

# 補完機能を有効にする
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                    /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# 補完の表示を詰める
setopt list_packed

########################################

# emacs 風キーバインドにする
bindkey -e

# タイプミス時の指摘
setopt correct

# cd後のlsの省略
setopt auto_cd
function chpwd() { ls }

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

########################################
# オプション

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# 履歴検索で *(ワイルドカード)を可能
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# docker
alias d='docker'
alias dc='docker-compose'

########################################

# C で標準出力をクリップボードにコピーする
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi
