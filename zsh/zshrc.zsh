# global npm modules
export PATH="$HOME/.npm-packages/bin:$PATH"

# key bindings
bindkey "^[[3~" delete-char
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# autocd
setopt autocd

export GREP_OPTIONS='--color=auto'

# load antigen
source $(brew --prefix)/share/antigen/antigen.zsh

# powerlevel setup
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%F{magenta}❯ %f"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status node_version time)
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash git-tagname)
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
# POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='white'
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'

# antigen bundles osx aws capistrano z bower brew
antigen bundle osx
antigen bundle aws
antigen bundle capistrano
antigen bundle brew
antigen bundle brew-cask
antigen bundle bower
antigen bundle sudo
antigen bundle robertzk/send.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle vasyharan/zsh-brew-services

# plugins worth investigation... later
# https://github.com/unixorn/tumult.plugin.zsh

# load theme
# antigen theme bhilburn/powerlevel9k powerlevel9k
source  ~/powerlevel9k/powerlevel9k.zsh-theme

antigen apply

# fasd set up
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
	  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# load npm completions
# source ~/.npm-completion.sh

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
      if [[ $line == \[* ]]; then
        compadd $(echo $line | sed 's/[][]//g')
      fi
  done < "$filename"

  return 0
}
compdef _pgs pgs
#
# END OF PGS
#

eval "$(direnv hook zsh)"

# has to go last!
# antigen bundle zsh-users/zsh-syntax-highlighting
