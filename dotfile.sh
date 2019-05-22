echo 'declare the variable'
DOT_DIR=${HOME}/dotfiles

echo 'Run app install on homeberw'
brew bundle

echo 'Paste symbolic link to home directory'
ln -s ${DOT_DIR}/zsh/.zshenv ${HOME}/.zshenv
ln -s ${HOME}/dotfiles/.gitconfig ${HOME}/.gitconfig

if [ -e ${HOME}/Library/Application\ Support/Code/User ]; then
  rm -f ${HOME}/Library/Application\ Support/Code/User/settings.json

  ln -s ${DOT_DIR}/settings.json $HOME/Library/Application\ Support/Code/User
fi

echo '🎉Finish'
echo 'Please restart the terminal'
