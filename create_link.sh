#!/bin/bash
#
#set -x

ln -s ~/dev/dotfiles/.zshrc ~/.zshrc
os=`uname`

if [ $os = "Darwin" ]; then
    ln -s ~/dev/dotfiles/.zshrc.osx ~/.zshrc.osx
    mkdir -p ~/.gnupg
    ln -s ~/dev/dotfiles/.gnupg/mac-gpg-agent.conf ~/.gnupg/gpg-agent.conf
    mkdir -p ~/.hammerspoon
    ln -s ~/dev/dotfiles/.hammerspoon/init.lua ~/.hammerspoon/init.lua
fi

if [ $os = "Linux" ]; then
    ln -s ~/dev/dotfiles/.zshrc.ubuntu ~/.zshrc.ubuntu
fi


ln -s ~/dev/dotfiles/.zshenv ~/.zshenv
ln -s ~/dev/dotfiles/.vimrc ~/.vimrc
ln -s ~/dev/dotfiles/.vim ~/.vim
ln -s ~/dev/dotfiles/.hgrc ~/.hgrc
ln -s ~/dev/dotfiles/.hgignore_global ~/.hgignore_global
ln -s ~/dev/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dev/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dev/dotfiles/.screenrc ~/.screenrc
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
cp -n ~/dev/dotfiles/.zshrc.local.template ~/.zshrc.local
