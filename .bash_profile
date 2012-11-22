export PATH=/usr/local/mysql/bin:/usr/local/bin:/usr/local/sbin/:$PATH
export MANPATH=/opt/local/man:$MANPATH

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

test -r /sw/bin/init.sh && . /sw/bin/init.sh
