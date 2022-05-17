echo 'Run app install on homeberw'
brew bundle

echo 'Paste symbolic link to home directory'
ln -s ${PWD}/zsh/.zshenv ${HOME}/.zshenv
ln -s ${PWD}/.gitconfig ${HOME}/.gitconfig
ln -s ${PWD}/.gitignore_global ${HOME}/.gitignore_global
ln -s ${PWD}/asdf/.asdfrc ${HOME}/.asdfrc

config_path=$PWD/.config

echo 'peco'
if [[ ! -d ${HOME}/.config/peco ]]; then
  mkdir $XDG_CONFIG_HOME/peco
fi
if [[ ! -d ${HOME}/.config/peco/config.d ]]; then
  ln -s $PWD/.config/peco/config.json $XDG_CONFIG_HOME/peco/config.json
fi

echo 'starship'
if [ ! -e $XDG_CONFIG_HOME/starship.toml ]; then
  ln -s $PWD/.config/starship.toml $XDG_CONFIG_HOME/starship.toml
fi

echo 'vim'
if [[ ! -e $XDG_CONFIG_HOME/nvim ]]; then
  mkdir -p $XDG_CONFIG_HOME/nvim
fi
if [[ ! -e $XDG_CONFIG_HOME/nvim/init.lua ]]; then
  ln -s $config_path/vim/init.lua $XDG_CONFIG_HOME/nvim/init.lua
fi
if [[ ! -d $XDG_CONFIG_HOME/nvim/lua ]]; then
  ln -s $config_path/vim/lua $XDG_CONFIG_HOME/nvim/lua
fi

echo 'tmux'
if [[ ! -e $HOME/.tmux.conf ]]; then
  ln -s $PWD/tmux/tmux.conf $HOME/.tmux.conf
fi

echo 'hammerspoon'
if [[ ! -e $HOME/.hammerspoon/init.lua ]]; then
  ln -s $PWD/hammerspoon/init.lua $HOME/.hammerspoon/init.lua
fi
if [[ ! -e $HOME/.hammerspoon/ctrlDoublePress.lua ]]; then
  ln -s $PWD/hammerspoon/ctrlDoublePress.lua $HOME/.hammerspoon/ctrlDoublePress.lua
fi

echo 'alacritty'
if [[ ! -e $XDG_CONFIG_HOME/alacritty ]]; then
  mkdir -p $XDG_CONFIG_HOME/alacritty
fi
if [[ ! -e $XDG_CONFIG_HOME/alacritty/alacritty.yml ]]; then
  ln -s $config_path/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
fi

echo 'vscode'
if [ ! -e ${HOME}/Library/Application\ Support/Code/User ]; then
  echo 'vscode'
  rm -f ${HOME}/Library/Application\ Support/Code/User/settings.json

  ln -s ${PWD}/settings.json $HOME/Library/Application\ Support/Code/User
fi

echo 'wallpaper'
wallpaper set ${PWD}/images/wallpaper.jpeg

echo '🎉Finish'
echo 'Please restart the terminal'
