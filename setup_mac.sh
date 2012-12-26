#!/bin/bash
brew install zsh
brew install git
brew install mercurial
brew install -f vim
brew install python
brew install wget
brew install tree
brew install automake
brew install ack
brew install rlwrap
brew install --use-llvm gauche

pip install virtualenv
pip install sphinx


#nodebrew
curl https://raw.github.com/hokaccha/nodebrew/master/nodebrew | perl - setup

#pythonbrew
curl -kL http://xrl.us/pythonbrewinstall | bash

#perlbrew
curl -kL http://xrl.us/perlbrewinstall | bash

brew install gfortran
brew install octave
