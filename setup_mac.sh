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
brew install -f vim --with-lua --with-python3
brew install wget
brew install tree
brew install pstree
brew install automake
brew install rlwrap
brew install --use-llvm gauche
brew install autojump
brew install tig
brew install the_silver_searcher
brew install bvi
brew install tmux
brew install yajl

# install to system python
pip install virtualenv
pip install ipython
pip install httpie
pip install requests
pip install percol

