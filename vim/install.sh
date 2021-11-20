#!/bin/bash
path=~/.vim
nvim_path=$XDG_CONFIG_HOME/nvim

if [ ! -e $path ]; then
  mkdir -p $path
fi

if [ ! -e $XDG_CONFIG_HOME/nvim ]; then
  mkdir -p $nvim_path
fi

echo $PWD

if [[ ! -e $HOME/.vimrc ]]; then
  ln -s $PWD/vimrc $HOME/.vimrc
fi

if [[ ! -e $nvim_path/init.vim ]]; then
  ln -s $PWD/vimrc $nvim_path/init.vim
fi
