# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G -w"
  alias pst='ptree'
  ;;
linux*)
  alias ls="ls --color"
  alias pst='ps axfo "%U %p %C %z %t (%x) %c : " o args=ARGS'
  ;;
esac

alias l="ls -lh"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -lhA"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias u="cd ../"
alias uu="cd ../../"
alias uuu="cd ../../../"
alias less="less -M"
alias screen='screen -U'
alias eixt='exit'
alias sc='screen -D -RR'
alias tm='tmux attach-session -t'
alias cp='cp -Riva'
alias mv='mv -iv'
alias wl='wc -l'
alias psa='ps aux'
alias ag="ag --pager 'less -R'"

alias listen='netstat -na | grep tcp | grep LISTEN'

alias gl="git log --graph --all --pretty=format:'%x09%Cred%h%Creset %cn %x09%s %C(yellow)%d%Creset' --abbrev-commit --date=relative"
alias gs="git status"
alias gd="git diff"
alias gremove_all='git status -s | awk '\''/^ D/{print "git rm "$2}'\'''

alias pyserver='python -m SimpleHTTPServer'

export PERL5OPT="-Mlib=extlib/lib/perl5 -Ilib"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[ -f ~/.bashrc.local ]    && source ~/.bashrc.local

# User specific aliases and functions
if [[ $PS1 ]]; then
  screen -list
fi
