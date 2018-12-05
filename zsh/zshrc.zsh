# zmodload zsh/zprof

# zmodload -i zsh/complist

# completion options
setopt autocd
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

zstyle ':completion:*' verbose yes
# zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
# zstyle ':completion:::clap:*' use-cache on
# zstyle ':completion:::npm:*:' use-cache on
# zstyle ':completion:::scripts:*:*' file-patterns use-cache on
# zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
# zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use
# zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"


# # load npm completions
# # source ~/.npm-completion

# # # history options
HISTFILE="$HOME/.zsh_history"
# HISTSIZE=10_000
# SAVEHIST=10000
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

# global npm modules & whatever is in sbin
export PATH="$HOME/.npm-packages/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)
export LIQUIBASE_HOME=/usr/local/opt/liquibase/libexec

# global gem files
# export GEM_HOME=~/.gem
# export GEM_PATH=~/.gem

# # some env vars
export CIRCLE_TEST_REPORTS=/tmp
export ZSH_CUSTOM=~/.zsh_custom

# # key bindings
bindkey "^[[3~" delete-char
bindkey  "^[[H"   beginning-of-line # page up
bindkey  "^[[F"   end-of-line # page down

# # pretty grep
export GREP_OPTIONS='--color=auto'

fpath=(~/.zsh/functions $fpath)
autoload -Uz pgs

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# zplug "plugins/capistrano",   from:oh-my-zsh
# zplug "plugins/osx", from:oh-my-zsh
# zplug "plugins/brew", from:oh-my-zsh
# zplug "plugins/brew-cask", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme

# spaceship
SPACESHIP_TIME_SHOW=true
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_PROMPT_ORDER=(
  time
  user
  host
  dir
  git
  package
  node
  # ruby
  # xcode
  # swift
  # golang
  # php
  # rust
  # julia
  # docker
  # venv
  # pyenv
  line_sep
  vi_mode
  char
)

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# fasd set up
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# load aliases
source ~/.zshaliases.zsh

# init direnv
eval "$(direnv hook zsh)";

# # show total load time
# duration=$((($SECONDS - $START_TIME) * 1000))
# echo "\033[1;30m($(printf '%.2f' $duration)ms)\033[0m"

# # date_now="`date +%Y%m%d%H%M%S`";
# # time_now="`date +%Y%m%d%H%M%S`";

# function unix_ts { LBUFFER="${LBUFFER}$(date '+%Y%m%d%H%M%S')" }
# zle -N unix_ts
# bindkey "^t" unix_ts

# function git_commit_message {
#   BUFFER="git commit -m \"\""
#   zle end-of-line
#   end=$CURSOR
#   CURSOR=$(($end - 1))
# }

# zle -N git_commit_message
# bindkey "^G" git_commit_message

# if [ $ITERM_SESSION_ID ]; then
#   DISABLE_AUTO_TITLE="true"
#   echo -ne "\033];${PWD##*/}\007"
# fi

# precmd() {
#   echo -ne "\033];${PWD##*/}\007"
# }

# Then, source plugins and add commands to $PATH
zplug load

autoload -Uz compinit

for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C
