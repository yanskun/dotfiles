########################################
# 環境変数
export PATH=~/.local/bin:$PATH
export NODE_OPTIONS=--max_old_space_size=4096
export GIT_EDITOR=nvim

source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

setopt nonomatch
setopt interactivecomments
# ヒストリの設定
HISTFILE=${HOME}/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

########################################
# PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:/usr/sbin/

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export PATH=$PATH:$DOTDIR/.config/alacritty/bin

########################################
# start-up
neofetch

########################################

# zsh で ^ ハットを使えるようにする
autoload -Uz git-escape-magic

########################################
# env

. /opt/homebrew/opt/asdf/libexec/asdf.sh
eval "$(pyenv init -)"

########################################
# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

########################################
# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

########################################
# go
GOENV_DISABLE_GOPATH=1
export PATH=$GOPATH/bin:$PATH

########################################
# zig
export PATH=$PATH:$HOME/zls/zig-out/bin

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
%{${fg[magenta]}%}% ==> %# %{${reset_color}%}"

# less command color
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'

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

# vim
if type nvim > /dev/null; then
  alias vim='nvim'
fi

# docker
alias d='docker'
alias dc='docker-compose'

# color 系
alias grep='grep --color=auto'

# 上の階層
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

########################################
# import
. $ZDOTDIR/.zshrc_secret

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

########################################
# plugins

source ${ZDOTDIR}/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#008080'

########################################
# functions

function command_not_found_handler() {
  cowsay "command not found: $1"
}

## fzf
### ghq
function fzf-src () {
  local selected_dir=$(ghq list | fzf --height 40% --reverse --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
  fi
  zle accept-line
}
zle -N fzf-src
bindkey '^]' fzf-src

### open github
function fzf-open () {
  local selected_dir=$(ghq list | fzf --height 40% --reverse --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$selected_dir" ]; then
    BUFFER="open https://${selected_dir}"
  fi
  zle accept-line
}
zle -N fzf-open
bindkey '^o' fzf-open

### history
function fzf-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | fzf --reverse --height 40%`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N fzf-history-selection
bindkey '^H' fzf-history-selection

## gcloud project swhich
function gcloud_prj_switch () {
    project="$(gcloud projects list | fzf --height 40% --reverse)"
    project_name="$(echo $project | awk '{print $1}')"
    project_id="$(echo $project | awk '{print $3}')"
    gcloud config set project ${project_id}
    export GOOGLE_PROJECT=${project_id}
    echo "Switched to project: ${project_name}(${project_id})"
}
zle -N gcloud_prj_switch
bindkey '^g' gcloud_prj_switch


########################################
# starship

eval "$(starship init zsh)"
