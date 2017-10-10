PHONY: setup update vim/dein vim/vim

setup:
	git submodule init
	git submodule update
	cd ./antigen;sudo make install

update:
	git pull origin master
	git submodule update

user/shell:
	chsh -s /bin/zsh


vim/dein:
	mkdir -p ./vendor/dein
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./vendor/dein/installer.sh
	sh ./vendor/dein/installer.sh ./vendor/dein

vim/vim:
	git clone https://github.com/vim/vim
	cd vendor/vim; ./configure --prefix=/usr/local --enable-luainterp --enable-fontset --with-features=huge  --enable-cscope --enable-python3interp --with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu --enable-fail-if-missing --enable-multibyte
	cd vendor/vim; make
