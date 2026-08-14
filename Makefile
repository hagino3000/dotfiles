PHONY: setup
setup:
	git submodule init
	git submodule update

PHONY: update
update:
	git pull origin master
	git submodule update

PHONY: skk*
skk/create_dictionary_from_cache:
	yaskkserv2_make_dictionary --cache-filename=/tmp/yaskkserv2.cache --utf8 --output-jisyo-filename=/tmp/SKK-JISYO.utf8
