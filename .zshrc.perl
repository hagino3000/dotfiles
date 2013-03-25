if [ -s "$HOME/perl5/perlbrew/bin/perlbrew" ]; then

  alias re.pl='rlwrap ~/perl5/perlbrew/perls/perl-5.10.1/bin/re.pl'

  export PERLBREW_BASHRC_VERSION=0.54


  __perlbrew_reinit() {
      if [[ ! -d "$PERLBREW_HOME" ]]; then
          mkdir -p "$PERLBREW_HOME"
      fi

      echo '# DO NOT EDIT THIS FILE' > "$PERLBREW_HOME/init"
      command perlbrew env $1 | grep PERLBREW_ >> "$PERLBREW_HOME/init"
      . "$PERLBREW_HOME/init"
      __perlbrew_set_path
  }

  __perlbrew_set_path () {
      MANPATH_WITHOUT_PERLBREW=`perl -e 'print join ":", grep { index($_, $ENV{PERLBREW_HOME}) < 0 } grep { index($_, $ENV{PERLBREW_ROOT}) < 0 } split/:/,qx(manpath 2> /dev/null);'`
      if [ -n "$PERLBREW_MANPATH" ]; then
          export MANPATH="$PERLBREW_MANPATH:$MANPATH_WITHOUT_PERLBREW"
      else
          export MANPATH="$MANPATH_WITHOUT_PERLBREW"
      fi
      unset MANPATH_WITHOUT_PERLBREW

      PATH_WITHOUT_PERLBREW=`$perlbrew_command display-pristine-path`
      if [ -n "$PERLBREW_PATH" ]; then
          export PATH=${PERLBREW_PATH}:${PATH_WITHOUT_PERLBREW}
      else
          export PATH=${PERLBREW_ROOT}/bin:${PATH_WITHOUT_PERLBREW}
      fi
      unset PATH_WITHOUT_PERLBREW

      hash -r
  }

  __perlbrew_activate() {
      [[ -n $(alias perl 2>/dev/null) ]] && unalias perl 2>/dev/null

      if [[ -n "$PERLBREW_PERL" ]]; then
          if [[ -z "$PERLBREW_LIB" ]]; then
              eval "$($perlbrew_command env $PERLBREW_PERL)"
          else
              eval "$(${perlbrew_command} env $PERLBREW_PERL@$PERLBREW_LIB)"
          fi
      fi

      __perlbrew_set_path
  }

  __perlbrew_deactivate() {
      eval "$($perlbrew_command env)"
      unset PERLBREW_PERL
      unset PERLBREW_LIB
      __perlbrew_set_path
  }

  perlbrew () {
      local exit_status
      local short_option
      export SHELL

      if [[ $1 == -* ]]; then
          short_option=$1
          shift
      else
          short_option=""
      fi

      case $1 in
          (use)
              if [[ -z "$2" ]] ; then
                  if [[ -z "$PERLBREW_PERL" ]] ; then
                      echo "Currently using system perl"
                  else
                      echo "Currently using $PERLBREW_PERL"
                  fi
              else
                  code="$(command perlbrew env $2);"
                  if [ -z "$code" ]; then
                      exit_status=1
                  else
                      eval $code
                      __perlbrew_set_path
                  fi
              fi
              ;;

          (switch)
                if [[ -z "$2" ]] ; then
                    command perlbrew switch
                else
                    perlbrew use $2 && __perlbrew_reinit $2
                fi
                ;;

          (off)
              __perlbrew_deactivate
              echo "perlbrew is turned off."
              ;;

          (switch-off)
              __perlbrew_deactivate
              __perlbrew_reinit
              echo "perlbrew is switched off."
              ;;

          (*)
              command perlbrew $short_option "$@"
              exit_status=$?
              ;;
      esac
      hash -r
      return ${exit_status:-0}
  }

  [[ -z "$PERLBREW_ROOT" ]] && export PERLBREW_ROOT="$HOME/perl5/perlbrew"
  [[ -z "$PERLBREW_HOME" ]] && export PERLBREW_HOME="$HOME/.perlbrew"

  if [[ ! -n "$PERLBREW_SKIP_INIT" ]]; then
      if [[ -f "$PERLBREW_HOME/init" ]]; then
          . "$PERLBREW_HOME/init"
      fi
  fi

  perlbrew_bin_path="${PERLBREW_ROOT}/bin"
  if [[ -f $perlbrew_bin_path/perlbrew ]]; then
      perlbrew_command="$perlbrew_bin_path/perlbrew"
  else
      perlbrew_command="command perlbrew"
  fi
  unset perlbrew_bin_path

  __perlbrew_activate
fi

