echo 'Paste symbolic link to home directory'
ln -s dotfiles/zsh/.zshenv ${HOME}/.zshenv

echo 'Run app install on homeberw'
brew bundle

echo 'Finish!!!!!'
echo 'Please restart the terminal'
