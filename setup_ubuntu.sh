#!/bin/bash
sudo apt-get install -y zsh
sudo apt-get install -y autojump
sudo apt-get install -y curl

#For ipython (pip install ipython)
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

#For scipy (pip install scypi)
sudo apt-get install -y liblapack3gf 
sudo apt-get install -y liblapack-dev 
sudo apt-get install -y libblas3gf
sudo apt-get install -y libblas-dev
sudo apt-get install -y gfortran
sudo apt-get install -y libqtcore4
sudo apt-get install -y libqt4-dev

#For matplotlib (pip install matplotlib)
sudo apt-get install -y libpng12-dev 
sudo apt-get install -y libjpeg8-dev
sudo apt-get install -y libfreetype6-dev

#For ipython extension
sudo apt-get install -y r-base-core ruby

#pythonbrew
curl -kL http://xrl.us/pythonbrewinstall | bash
pythonbrew venv init

#http://www.riverbankcomputing.co.uk/software/sip/download
#http://www.riverbankcomputing.co.uk/software/pyqt/download 
#wget http://sourceforge.net/projects/pyqt/files/sip/sip-4.14.4/sip-4.14.4.tar.gz
#wget http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.10/PyQt-x11-gpl-4.10.tar.gz

