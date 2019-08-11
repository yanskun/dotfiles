echo 'declare the variable'
DOT_DIR=${HOME}/dotfiles

echo 'Run app install on homeberw'
# brew bundle

echo 'Paste symbolic link to home directory'
ln -s ${DOT_DIR}/vim/.vimrc ${HOME}/.vimrc
ln -s ${DOT_DIR}/zsh/.zshenv ${HOME}/.zshenv
ln -s ${DOT_DIR}/.gitconfig ${HOME}/.gitconfig
ln -s ${DOT_DIR}/.gitignore_global ${HOME}/.gitignore_global

if [ -e ${HOME}/Library/Application\ Support/Code/User ]; then
  echo 'vscode'
  rm -f ${HOME}/Library/Application\ Support/Code/User/settings.json

  ln -s ${DOT_DIR}/settings.json $HOME/Library/Application\ Support/Code/User
fi

echo '🎉Finish'
echo 'Please restart the terminal'
