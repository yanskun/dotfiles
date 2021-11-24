echo 'Run app install on homeberw'
brew bundle

echo 'Paste symbolic link to home directory'
ln -s ${PWD}/zsh/.zshenv ${HOME}/.zshenv
ln -s ${PWD}/.gitconfig ${HOME}/.gitconfig
ln -s ${PWD}/.gitignore_global ${HOME}/.gitignore_global

if [[ ! -d ${HOME}/.config/peco ]]; then
  mkdir ${HOME}/.config/peco
fi
ln -s $PWD/peco/config.json $HOME/.config/peco/config.json

echo 'vim'
nvim_path=$XDG_CONFIG_HOME/nvim

if [ ! -e $XDG_CONFIG_HOME/nvim ]; then
  mkdir -p $nvim_path
fi

if [[ ! -e $HOME/.vimrc ]]; then
  ln -s $PWD/vim/.vimrc $HOME/.vimrc
fi

if [[ ! -e $nvim_path/init.vim ]]; then
  ln -s $PWD/vim/.vimrc $nvim_path/init.vim
fi

echo 'tmux'
if [[ ! -e $HOME/.tmux.conf ]]; then
  ln -s $PWD/tmux/tmux.conf $HOME/.tmux.conf
fi

echo 'terminal'
if [[ ! -e $HOME/.hammerspoon/init.lua ]]; then
  ln -s $PWD/hammerspoon/init.lua $HOME/.hammerspoon/init.lua
fi
if [[ ! -e $XDG_CONFIG_HOME/alacritty ]]; then
  mkdir -p $XDG_CONFIG_HOME/alacritty
fi
if [[ ! -e $XDG_CONFIG_HOME/alacritty/alacritty.yml ]]; then
  ln -s $PWD/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
fi

if [ ! -e ${HOME}/Library/Application\ Support/Code/User ]; then
  echo 'vscode'
  rm -f ${HOME}/Library/Application\ Support/Code/User/settings.json

  ln -s ${PWD}/settings.json $HOME/Library/Application\ Support/Code/User
fi

echo 'wallpaper'
wallpaper set ${PWD}/images/wallpaper.jpeg

echo '🎉Finish'
echo 'Please restart the terminal'
