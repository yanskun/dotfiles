########################################
# env
export PATH=~/.local/bin:$PATH
export NODE_OPTIONS=--max_old_space_size=4096
export GIT_EDITOR=nvim

source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh

# history
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
# plugins
eval "$(sheldon source)"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#008080'

########################################
# start-up
neofetch

########################################

# enable ^ notation
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

# enable colors
autoload -Uz colors
colors

# ls color
export LSCOLORS=dxbx
alias ls="ls -GF"

# less command color
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'

########################################
# completion

# enable completion
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1

# completion ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# completion ignore current directory
zstyle ':completion:*' ignore-parents parent pwd ..

setopt list_packed

########################################
# cd

setopt auto_cd
function chpwd() { ls }

autoload -Uz select-word-style
select-word-style default

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# options
# ref https://www.csse.uwa.edu.au/programming/linux/zsh-doc/zsh_17.html

setopt auto_cd
setopt auto_pushd
setopt correct
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt ignore_eof
setopt interactive_comments
setopt no_beep
setopt no_flow_control
setopt nonomatch
setopt print_eight_bit
setopt pushd_ignore_dups
setopt share_history

########################################
# alias

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias sudo='sudo '

alias -g L='| less'
alias -g G='| grep'

# vim
if type nvim > /dev/null; then
  alias vim='nvim'
fi

# docker
alias d='docker'
alias dc='docker-compose'

# color
alias grep='grep --color=auto'

# upstairs
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

########################################
# import
. $ZDOTDIR/.zshrc_secret

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

# copilot CLI
eval "$(github-copilot-cli alias -- "$0")"
