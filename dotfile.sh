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

echo 'zellij'
if [[ ! -d "$XDG_CONFIG_HOME"/zellij ]]; then
  mkdir -p "$XDG_CONFIG_HOME"/zellij
fi
ln -f -s "$config_path"/zellij/config.kdl "$XDG_CONFIG_HOME"/zellij/config.kdl

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

if [[ ! -d "$XDG_CONFIG_HOME"/zsh-abbr ]]; then
  mkdir -p "$XDG_CONFIG_HOME"/zsh-abbr
fi
ln -f -s "$config_path"/zsh-abbr/user-abbreviations "$XDG_CONFIG_HOME"/zsh-abbr/user-abbreviations

echo 'alacritty'
if [[ ! -e "$XDG_CONFIG_HOME"/alacritty ]]; then
  mkdir -p "$XDG_CONFIG_HOME"/alacritty
fi
chmod +x .config/alacritty/bin/toggle_opacity
ln -f -s "$config_path"/alacritty/alacritty.toml "$XDG_CONFIG_HOME"/alacritty/alacritty.toml

echo "karabiner"
if [[ ! -e "$XDG_CONFIG_HOME"/karabiner ]]; then
  mkdir -p "$XDG_CONFIG_HOME"/karabiner
fi
ln -f -s "$config_path"/karabiner/karabiner.json "$XDG_CONFIG_HOME"/karabiner/karabiner.json

echo 'yabai'
if [[ ! -e "$XDG_CONFIG_HOME"/yabai ]]; then
  mkdir -p "$XDG_CONFIG_HOME"/yabai
fi
ln -f -s "$config_path"/yabai/yabairc "$XDG_CONFIG_HOME"/yabai/yabairc

echo 'vscode'
rm -f "${HOME}"/Library/Application\ Support/Code/User/settings.json
ln -f -s "${PWD}"/vscode/settings.json "$HOME"/Library/Application\ Support/Code/User
rm -f "${HOME}"/Library/Application\ Support/Code/User/keybindings.json
ln -f -s "${PWD}"/vscode/keybindings.json "$HOME"/Library/Application\ Support/Code/User

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
