#!/bin/bash
sudo apt-get install -y zsh
sudo apt-get install -y autojump
sudo apt-get install -y curl
sudo apt-get install -y build-essential
sudo apt-get install -y libbz2-dev
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libxml2-dev
sudo apt-get install -y libxslt1-dev
sudo apt-get install -y libreadline5
sudo apt-get install -y libreadline5-dev
sudo apt-get install -y libgdbm-dev
sudo apt-get install -y libgdb-dev
sudo apt-get install -y libxml2
sudo apt-get install -y libssl-dev
sudo apt-get install -y tk-dev
sudo apt-get install -y libgdbm-dev
sudo apt-get install -y libexpat1-dev
sudo apt-get install -y libncursesw5-dev

#pythonbrew
curl -kL http://xrl.us/pythonbrewinstall | bash
pythonbrew venv init
