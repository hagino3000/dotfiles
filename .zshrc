# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
autoload colors
colors

if [ -s "$HOME/dev/dotfiles/antigen/antigen.zsh" ]; then
  source $HOME/dev/dotfiles/antigen/antigen.zsh
  antigen-use oh-my-zsh
  antigen-bundle autojump
  antigen-bundle screen
  antigen-apply
fi

# VCS version and branch info in RPROMPT
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' formats '(%s:%b)'
zstyle ':vcs_info:*' actionformats '(%s:%b|%a)'
zstyle ':vcs_info:(svn):*' branchformat '%b:r%r'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    
  zstyle ':vcs_info:git:*' unstagedstr "-"  
  zstyle ':vcs_info:git:*' formats '(%s:%b) %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s:%b|%a) %c%u'
fi

local _pre=''
preexec() {
    _pre="$1"
}

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

setopt pushd_ignore_dups

## Keybind configuration
#
# vi like keybind
#
bindkey -v

# same to emacs mode
bindkey '^F' history-incremental-search-backward
bindkey '^R' history-incremental-pattern-search-backward

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

autoload -Uz history-beginning-search-menu
zle -N history-beginning-search-menu
bindkey '^X^X' history-beginning-search-menu

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups  # ignore duplication command history list
setopt share_history     # share command history data
setopt extended_history  # save history with time
setopt hist_ignore_space # ignore space started command

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # filter commands before add history
    [[ ${#line} -ge 4
        && ${cmd} != (l|l[sal])
        && ${cmd} != (u)
        && ${cmd} != (c|cd)
        && ${cmd} != (m|man)
    ]]
}


## Completion configuration
#
autoload -U compinit
compinit -u

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases # aliased ls needs if file/dir completions work

alias where="command -v"
alias jo="jobs -l"
alias -g HIS='history | grep'

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

alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g J='| python -mjson.tool'

alias pyserver='python -m SimpleHTTPServer'

####################################################
# grep options
#if type ggrep > /dev/null 2>&1; then
#    alias grep=ggrep
#fi

export GREP_OPTIONS
## Don't match binary files
GREP_OPTIONS="--binary-files=without-match"
## Recursive grep if directory specified to target
#GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
## ignore tmp files
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
## ignore directories
GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
## Add colors
GREP_OPTIONS="--color=auto $GREP_OPTIONS"

export EDITOR="vim"

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}


# Bindkeys
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -s
        echo
        echo
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

## load user .zshrc configuration file
#
[ -f ~/.zshrc.osx ]    && source ~/.zshrc.osx
[ -f ~/.zshrc.aws ]    && source ~/.zshrc.aws
[ -f ~/.zshrc.ubuntu ] && source ~/.zshrc.ubuntu
[ -f ~/.zshrc.perl ]   && source ~/.zshrc.perl

#### python settings

# For pyenv
if [ -s "$HOME/.pyenv" ]; then
  eval "$(pyenv init -)"
fi

function workon() {
  source ./bin/activate
  update_venv_prompt
}

function update_prompt_when_deactivate() {
  if [ "${_pre}" = "deactivate" ]; then
    update_venv_prompt
  fi
}
add-zsh-hook precmd update_prompt_when_deactivate


function update_venv_prompt()
{
  # virtualenvの情報取得
  if [ -n "$VIRTUAL_ENV" ]; then
  RPROMPT=" %{${fg_bold[white]}%} (env: %{${fg[green]}%}`basename \"$VIRTUAL_ENV\"`%{${fg_bold[white]}%})%{${reset_color}%} ${RPROMPT}"
  else
  RPROMPT="%1(v|%F{green}%1v%f|)"
  fi
}

autoload -U promptinit
promptinit
prompt adam2

if [ "$TERM" = "screen" ]; then
    echo "You are on the" `hostname`
    echo "In the screen/tmux sesson"
else
    echo "You are on the" `hostname`
    if which screen &> /dev/null
      then
      echo "Check screen session..."
      screen -list
    fi

    if which tmux &> /dev/null
      then
      echo "Check tmux session...."
      tmux list-sessions
    fi
fi
