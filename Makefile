PHONY: setup update vim/dein

setup:
	git submodule init
	git submodule update
	cd ./antigen;sudo make install

update:
	git pull origin master
	git submodule update

vim/dein:
	mkdir -p ./vendor/dein
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./vendor/dein/installer.sh
	sh ./vendor/dein/installer.sh ./vendor/dein
