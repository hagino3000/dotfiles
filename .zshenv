if [ -d "$HOME/perl5/perlbrew" ]; then
  source $HOME/perl5/perlbrew/etc/bashrc
fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
