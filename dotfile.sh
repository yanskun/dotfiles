echo 'declare the variable'
DOT_DIR=$PWD

echo 'Run app install on homeberw'
# brew bundle

echo 'Paste symbolic link to home directory'
ln -s ${DOT_DIR}/vim/vimrc ${HOME}/.vimrc
ln -s ${DOT_DIR}/zsh/.zshenv ${HOME}/.zshenv
ln -s ${DOT_DIR}/.gitconfig ${HOME}/.gitconfig
ln -s ${DOT_DIR}/.gitignore_global ${HOME}/.gitignore_global

if [[ ! -d ${HOME}/.config/peco ]]; then
  mkdir ${HOME}/.config/peco
fi
ln -s ${DOT_DIR}/peco/config.json ${HOME}/.config/peco/config.json

nvim_path=$XDG_CONFIG_HOME/nvim

if [ ! -e $XDG_CONFIG_HOME/nvim ]; then
  mkdir -p $nvim_path
fi

if [[ ! -e $HOME/.vimrc ]]; then
  ln -s $DOT_DIR/vim/vimrc $HOME/.vimrc
fi

if [[ ! -e $nvim_path/init.vim ]]; then
  ln -s $DOT_DIR/vim/vimrc $nvim_path/init.vim
fi

if [ ! -e ${HOME}/Library/Application\ Support/Code/User ]; then
  echo 'vscode'
  rm -f ${HOME}/Library/Application\ Support/Code/User/settings.json

  ln -s ${DOT_DIR}/settings.json $HOME/Library/Application\ Support/Code/User
fi

echo 'wallpaper'
wallpaper set ${DOT_DIR}/images/wallpaper.jpeg

echo '🎉Finish'
echo 'Please restart the terminal'
