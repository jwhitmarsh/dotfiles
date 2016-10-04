# .bashrc is sourced for an interactive shell.

# For some reason, openssh invokes bash as an interactive shell even if we
# are only using scp. Therefore check that we have a terminal before processing
# this file
if test -n "$SSH_CONNECTION"; then
    tty -s || return
fi

# disable XON/XOFF so that we can use readline's forward-search-history command
# by pressing C-s
command -v stty &>/dev/null && stty ixon

# shell options
shopt -s cdspell
shopt -s histverify
shopt -s no_empty_cmd_completion
shopt -s extglob

export GREP_OPTIONS='--color=auto'

if test -n "$DISPLAY"
then
	BROWSER=gnome-open
else
	BROWSER=w3m
fi

LP_PS1_POSTFIX="\n> "

export BROWSER
export EDITOR="atom -nw"
export PAGER=less

#export LESS='-icRFS'
command -v lesspipe &>/dev/null && eval "$(lesspipe)"
# see termcap(5) for an explanation of these codes
#export LESS_TERMCAP_mb='\033[01;31m' # start blink
export LESS_TERMCAP_md=$'\E[0;31m' # start bold
export LESS_TERMCAP_me=$'\E[0m' # back to normal
export LESS_TERMCAP_so=$'\E[0;44;33m' # start standout (status line)
export LESS_TERMCAP_se=$'\E[0m' # end standout
export LESS_TERMCAP_us=$'\E[0;32m' # start underline
export LESS_TERMCAP_ue=$'\E[0m' # end underline

command -v dircolors >/dev/null && eval "$(dircolors -b)"

if test -f /etc/bash_completion.d/git; then
	source /etc/bash_completion.d/git
elif test -f /opt/local/share/doc/git-core/contrib/completion/git-completion.bash; then
	source /opt/local/share/doc/git-core/contrib/completion/git-completion.bash
elif test -f /usr/local/git/contrib/completion/git-completion.bash; then
	# Darwin only?
	source /usr/local/git/contrib/completion/git-completion.bash
	source /usr/local/git/contrib/completion/git-prompt.sh
elif test -f /usr/local/etc/bash_completion.d/git-completion.bash; then
	source /usr/local/etc/bash_completion.d/git-completion.bash
	source /usr/local/etc/bash_completion.d/git-prompt.sh
  source /usr/local/etc/bash_completion.d/npm
fi

HISTCONTROL=ignoreboth
HISTSIZE=5000

# xterm/screen title
#
# case "$TERM" in
# xterm*|rxvt*|screen)
# 	# http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# 	PROMPT_COMMAND='printf "\033]0;${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
# 	;;
# esac

function gvimcpp {
	gvim $1.cpp "+new $1.h"
}

function physize {
	echo $(( $(stat -c '%B * %b' "$1") / 1024 )) "$1"
}

# run `postgres service=db-alias`
# makes use of connection aliases saved in ~/.pg_service.conf
# example: `pgs db-alias-name`
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

case $- in
*i*)
	source ~/.bash_aliases
	source ~/.alias_completions
	;;
esac

command -v gvfs-open &>/dev/null && alias open=gvfs-open

if test -z "$CLICOLOR"; then
	alias cgrep='grep --color --context=9999999'
	alias ls='ls --color=auto'
fi

# check node is up to date
LTS="$(n --latest)"
CURRENT="$(node -v)"
GREEN='\033[01;32m'
RED='\033[01;31m'
NONE='\033[00m'
TODAY=$(date '+%y-%m-%d')

if [ ! -f /tmp/${TODAY} ]; then
	if [ $LTS = ${CURRENT/v/} ]; then
		echo -e "${GREEN}node is up to date with latest: $LTS. go team!"
	else
		echo -e "${RED}node is behind latest. please update to $LTS"
		echo ""
		echo -e "   ${NONE}sudo n latest"
	fi
	touch /tmp/${TODAY}
fi
# end node check

# export dev keys & variables
export ABACUS_DEPLOYMENT_KEY=~/.ssh/drg-euw1-abacus-team.pem
export LAMP_DEPLOYMENT_KEY=~/.ssh/drg-euw1-cider-development.pem
export CIRCLE_TEST_REPORTS=/tmp/

# sensible bash
if [ -f ~/src/bash-sensible/sensible.bash ]; then
	source ~/src/bash-sensible/sensible.bash
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# direnv must come after EVERYTHING
eval "$(direnv hook bash)"
