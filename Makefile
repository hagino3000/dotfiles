setup:
	git submodule init
	git submodule update

update:
	git pull origin master
	git submodule update
