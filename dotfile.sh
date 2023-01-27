#!/bin/bash
echo 'Run app install on homeberw'
# brew bundle

config_path="$DOTDIR"/.config

echo 'Paste symbolic link to home directory'
ln -f -s "${PWD}"/zsh/.zshenv "${HOME}"/.zshenv
ln -f -s "${PWD}"/.gitconfig "${HOME}"/.gitconfig
ln -f -s "${PWD}"/.gitignore_global "${HOME}"/.gitignore_global
ln -f -s "${PWD}"/asdf/.asdfrc "${HOME}"/.asdfrc
ln -f -s "$config_path"/neofetch/config.conf "$XDG_CONFIG_HOME"/neofetch/config.conf
ln -f -s "${DOTDIR}"/.tool-versions "${HOME}"/.tool-versions

echo 'peco'
if [[ ! -d "${HOME}"/.config/peco ]]; then
  mkdir "$XDG_CONFIG_HOME"/peco
fi
ln -f -s "$PWD"/.config/peco/config.json "$XDG_CONFIG_HOME"/peco/config.json

echo 'starship'
ln -f -s "$PWD"/.config/starship.toml "$XDG_CONFIG_HOME"/starship.toml

echo 'vim'
if [[ ! -e "$XDG_CONFIG_HOME"/nvim ]]; then
  mkdir -p "$XDG_CONFIG_HOME"/nvim
fi
ln -f -s "$config_path"/vim/init.lua "$XDG_CONFIG_HOME"/nvim/init.lua
ln -f -s "$config_path"/vim/lua "$XDG_CONFIG_HOME"/nvim/lua
ln -f -s "$config_path"/vim/lazy-lock.json "$XDG_CONFIG_HOME"/nvim/lazy-lock.json

echo 'tmux'
ln -f -s "$PWD"/tmux/tmux.conf "$HOME"/.tmux.conf
sh tmux/installer.sh

echo 'hammerspoon'
if [[ ! -d "$HOME"/.hammerspoon ]]; then
  mkdir "$HOME"/.hammerspoon
fi
ln -f -s "$PWD"/hammerspoon/init.lua "$HOME"/.hammerspoon/init.lua
ln -f -s "$PWD"/hammerspoon/alacritty.lua "$HOME"/.hammerspoon/alacritty.lua

echo 'sheldon'
if [[ ! -d "$XDG_CONFIG_HOME"/sheldon ]]; then
  mkdir -p "$XDG_CONFIG_HOME"/sheldon
fi
ln -f -s "$config_path"/sheldon/plugins.toml "$XDG_CONFIG_HOME"/sheldon/plugins.toml

echo 'alacritty'
if [[ ! -e "$XDG_CONFIG_HOME"/alacritty ]]; then
  mkdir -p "$XDG_CONFIG_HOME"/alacritty
fi
chmod +x .config/alacritty/bin/toggle_opacity
ln -f -s "$config_path"/alacritty/alacritty.yml "$XDG_CONFIG_HOME"/alacritty/alacritty.yml

echo 'vscode'
rm -f "${HOME}"/Library/Application\ Support/Code/User/settings.json
ln -f -s "${PWD}"/settings.json "$HOME"/Library/Application\ Support/Code/User

echo 'wallpaper'
wallpaper set "${PWD}"/images/wallpaper.jpeg

echo 'screenshot'
if [[ ! -e "$HOME"/Pictures/screenshot ]]; then
  mkdir -p "$HOME"/Pictures/screenshot
fi
defaults write com.apple.screencapture location "$HOME"/Pictures/screenshot

yes | rm .config/vim/lua/lua

echo '🎉Finish'
echo 'Please restart the terminal'
