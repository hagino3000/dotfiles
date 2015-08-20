#!/bin/bash

# Install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew install zsh
brew install git
brew install mercurial
brew install -f vim
brew install python
brew install wget
brew install tree
brew install pstree
brew install automake
brew install ack
brew install rlwrap
brew install --use-llvm gauche
brew install autojump
brew install phantomjs
brew install tig
brew install mongo
brew install mysql
brew install the_silver_searcher
brew install bvi
brew install ruby
brew install pyenv
brew install pyenv-virtualenv
brew install tmux
brew install yajl

# install to system python
pip install virtualenv
pip install sphinx
pip install nose
pip install numpy
pip install pygments
pip install ipython
pip install bpython
pip install pylint
pip install httpie
pip install requests
pip install percol


#nodebrew
curl -L git.io/nodebrew | perl - setup

#perlbrew
#curl -kL http://xrl.us/perlbrewinstall | bash

brew install gfortran
brew install gnuplot
brew install swig

#sudo gem install chef
#sudo gem install knife-solo
#sudo gem install librarian-chef

# virtualbox
# vagrant
# vagrant plugin install sahara

# python
#CONFIGURE_OPTS=--enable-unicode=ucs4 pyenv install 2.7.4
