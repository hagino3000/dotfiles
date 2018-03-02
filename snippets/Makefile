.PHONY: setup_dev setup_prod wheels index import_rss update_state test watch

all: help

target_file:=xxx

do:
	# With commandline parameter
	hoge $(target_file)

# run parallel with -j option
# $ make run -j 2
# > python ./aaaa.py --hoge_id 2
# > python ./aaaa.py --hoge_id 1055
hoge_ids := 2 1055 5335 6311 7442
run: $(hoge_ids:%=call/%)
call/%:
	@echo python ./aaaa.py --hoge_id $(@F)


############################################################################
# Dev Commands 
############################################################################
help:
	@echo Use [make setup_dev] or [make setup_prod] to setup

clean:
	rm -rf bin include lib lib64 man

lint:
	./bin/flake8 census tests

test:
	./bin/nosetests tests

test_with_pdb:
	./bin/nosetests tests --pdb-failures

test_with_lock:
	@if [ ! -f .testing.lock ]; then \
		touch .testing.lock; \
		./bin/nosetests tests;\
		rm .testing.lock;\
	fi

watch:
	# VIM + MacOSXだと *.py ファイル編集時にトリガーしないので.vimrcで
	# set noswapfile
	# set nowritebackup
	# しておく
	@echo Watch file changes and run test
	watchmedo shell-command --interval=5 --patterns="*.py" -R -D --command='make test_with_lock' census tests

