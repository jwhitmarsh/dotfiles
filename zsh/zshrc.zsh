# global npm modules
export PATH="$HOME/.npm-packages/bin:$PATH"

# global gem files
export GEM_HOME=~/.gem
export GEM_PATH=~/.gem
export ZSH_CUSTOM=~/.zsh_custom

# key bindings
bindkey "^[[3~" delete-char
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# autocd
setopt autocd

# pretty grep
export GREP_OPTIONS='--color=auto'

# history options
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# load antigen
source $(brew --prefix)/share/antigen/antigen.zsh

# spaceship
SPACESHIP_TIME_SHOW=true
SPACESHIP_DOCKER_SHOW=false

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
# antigen bundle jwhitmarsh/zsh-tab-title
# antigen bundle /Users/jwhitmarsh/src/zsh-tab-title --no-local-clone
# antigen bundle lukechilds/zsh-better-npm-completion

antigen use oh-my-zsh

# plugins worth investigation... later
# https://github.com/unixorn/tumult.plugin.zsh

# load theme
# antigen theme bhilburn/powerlevel9k powerlevel9k
# source  ~/powerlevel9k/powerlevel9k.zsh-theme

antigen apply

# fasd set up
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
	  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# load npm completions
source ~/.npm-completion

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

export PATH="/usr/local/sbin:$PATH"

source "$ZSH_CUSTOM/spaceship.zsh-theme"
ZSH_THEME="spaceship"

eval "$(direnv hook zsh)"
