#!/bin/bash

# Install homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
brew install gfortran
brew install gnuplot
brew install swig

# install to system python
pip3 install virtualenv
pip3 install sphinx
pip3 install nose
pip3 install numpy
pip3 install pygments
pip3 install ipython
pip3 install bpython
pip3 install pylint
pip3 install httpie
pip3 install requests
pip3 install percol


