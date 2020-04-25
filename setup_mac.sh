#!/bin/bash

# Install homebrew
# ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew tap caskroom/versions
brew cask install java8
brew install scala
brew install sbt

brew install zsh
brew install git
brew install python3
brew install vim
brew install wget
brew install tree
brew install pstree
brew install automake
brew install rlwrap
brew install autojump
brew install tig
brew install the_silver_searcher
brew install bvi
brew install tmux
brew install yajl
brew install reattach-to-user-namespace
brew install gpg2
brew install pinentry-mac

pip3 install virtualenv --user
pip3 install ipython --user
pip3 install httpie --user
pip3 install requests --user
pip3 install percol --user
pip3 install awslogs --user
pip3 install awscli --user

