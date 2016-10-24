export GREP_OPTIONS='--color=auto'

# load antigen
source $(brew --prefix)/share/antigen/antigen.zsh

# powerlevel setup
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$(tput setaf 5)❯ "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status node_version time)
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash git-tagname)
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'

# antigen bundles osx aws capistrano z bower brew
antigen bundle osx
antigen bundle aws
antigen bundle capistrano
antigen bundle brew
antigen bundle bower

# load theme
antigen theme bhilburn/powerlevel9k powerlevel9k

antigen apply

# fasd set up
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
	  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# load npm completions
source /usr/local/etc/bash_completion.d/npm

# load aliases
source ~/.zshaliases.zsh

# some env vars
export CIRCLE_TEST_REPORTS=/tmp

# run `postgres service=db-alias`
# requires connection aliases saved in ~/.pg_service.conf
# example: `pgs db-alias-name`
# bonus: tab completion :)
function pgs {
  if [[ -z "$1" ]]; then
    echo "A connection alias is required!"
    return 1
  fi

  if [[ -z `command -v pgcli >/dev/null` ]]; then
    CLI=pgcli
  elif [[ -z `command -v psql >/dev/null` ]]; then
    CLI=psql
  else
    echo "No postgres CLI tool found. Try pgcli or psql"
  fi

  $CLI service=$1
}

_pgs()
{
  filename="$HOME/.pg_service.conf"
  CONNECTIONS=""
  while read -r line
  do
      if [[ $line == [* ]]; then
        CONNECTIONS+=$(echo $line | sed 's/[][]//g')
        CONNECTIONS+=' '
      fi
  done < "$filename"

  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${CONNECTIONS}" -- ${cur}) )

  return 0
}
complete -F _pgs pgs
#
# END OF PGS
#
