#!/bin/bash
# macOSシステム設定

# スクリーンショット設定
mkdir -p "$HOME/Pictures/screenshot"
defaults write com.apple.screencapture location "$HOME/Pictures/screenshot"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "png"

# Dock設定
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 45
defaults write com.apple.dock magnification -bool false
killall Dock

echo "macOS settings applied. Some changes may require logout/restart."
