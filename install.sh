echo 'Paste symbolic link to home directory'
ln -s dotfiles/zsh/.zshenv ${HOME}/.zshenv
echo 'Please restart the terminal'

echo 'Run install Homebrew'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'Run app install on homeberw'
brew bundle
echo 'Finish!!!!!'
