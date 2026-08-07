#!/bin/bash
defaults read -g KeyRepeat
defaults write -g KeyRepeat -int 1
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
