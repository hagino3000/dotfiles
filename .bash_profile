export PATH=/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin/:$PATH
export MANPATH=/opt/local/man:$MANPATH
export LINODE=64.62.228.189
export FUKUBINGO_SERVER=s113.coreserver.jp
export FUKUBINGO_PASS=nWM44yPVvAe4
export YUKIHO=192.168.1.34

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

test -r /sw/bin/init.sh && . /sw/bin/init.sh
