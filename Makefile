PHONY: setup
setup:
	git submodule init
	git submodule update

PHONY: update
update:
	git pull origin master
	git submodule update
