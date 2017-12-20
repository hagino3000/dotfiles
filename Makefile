PHONY: setup update vim/download vim/make

setup:
	git submodule init
	git submodule update
	cd ./antigen;sudo make install

update:
	git pull origin master
	git submodule update

user/shell:
	chsh -s /bin/zsh


vendor/dein:
	mkdir -p ./vendor/dein
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./vendor/dein/installer.sh
	sh ./vendor/dein/installer.sh ./vendor/dein

vendor/vim:
	cd vendor; git clone https://github.com/vim/vim

vim/download: vendor/vim

vim/make: vim/download
	cd vendor/vim; ./configure --prefix=/usr/local --enable-luainterp --enable-fontset --with-features=huge  --enable-cscope --enable-python3interp --with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu --enable-fail-if-missing --enable-multibyte
	cd vendor/vim; make
