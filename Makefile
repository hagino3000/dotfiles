setup:
	git submodule init
	git submodule update
	cd ./antigen;make install

update:
	git pull origin master
	git submodule update
