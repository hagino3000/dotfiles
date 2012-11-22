#!/bin/bash
echo "-- start copy from working files --"
cp ~/.vimrc ~/dev/dotfiles/.vimrc
cp ~/.gvimrc ~/dev/dotfiles/.gvimrc
cp -r ~/src ~/dev/dotfiles/
cp ~/.screenrc ~/dev/dotfiles/.screenrc
cp ~/.zshrc ~/dev/dotfiles/.zshrc
cp ~/.zshrc.mine ~/dev/dotfiles/.zshrc.mine
cp ~/.hgrc ~/dev/dotfiles/.hgrc
cp ~/.gitconfig ~/dev/dotfiles/.gitconfig
echo "------ done --------"

