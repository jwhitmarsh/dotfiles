# .bashrc is sourced for an interactive shell.

#echo .bashrc

# For some reason, openssh invokes bash as an interactive shell even if we
# are only using scp. Therefore check that we have a terminal before processing
# this file
if test -n "$SSH_CONNECTION"; then
    tty -s || return
fi

# disable XON/XOFF so that we can use readline's forward-search-history command
# by pressing C-s
command -v stty &>/dev/null && stty ixon

shopt -s cdspell
#shopt -s failglob
shopt -s histverify
shopt -s no_empty_cmd_completion
shopt -s extglob

export DJANGO_COLORS="light"

export GREP_OPTIONS='--color=auto'

if test -n "$DISPLAY"
then
	BROWSER=gnome-open
else
	BROWSER=w3m
fi
export BROWSER

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
fi

# django bash completion
if test -f /$HOME/.django_bash_completion.sh; then
	source $HOME/.django_bash_completion.sh
fi

# best prompt ever!
#
function smile {
	if test $? = 0; then
		printf "${csi_green}:)"
	else
		printf "${csi_red}:("
	fi
}
function user_colour {
	if test "$UID" = 0; then
		printf "${csi_red}"
	else
		printf "${csi_green}"
	fi
}
#curl with username, url
cgt(){
	echo "curl -OLv --user '$1' $2"
	curl -OLv --user $1 $2
}
# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

csi='\033['
csi_default=${csi}0m
csi_cyan=${csi}36m
csi_green=${csi}32m
csi_red=${csi}31m
csi_gold=${csi}33m
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose
PS1="\n\$(smile) ${csi_cyan}\A $(user_colour)\u@\h ${csi_gold}\w${csi_default} \$(type -t __git_ps1 >/dev/null && __git_ps1 '(%s)')\n\\$ "

HISTCONTROL=ignoreboth
HISTSIZE=5000

# xterm/screen title
#
case "$TERM" in
xterm*|rxvt*|screen)
	# http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
	PROMPT_COMMAND='printf "\033]0;${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
	;;
esac

function gvimcpp {
	gvim $1.cpp "+new $1.h"
}

function physize {
	echo $(( $(stat -c '%B * %b' "$1") / 1024 )) "$1"
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

# settings for mono
# export LD_LIBRARY_PATH=/opt/mono/lib
# export PKG_CONFIG_PATH=/opt/mono/lib/pkgconfig:/usr/lib64/pkgconfi
# export GOPATH=~/src
# export PATH=$PATH:$GOPATH/bin
# export PATH="/Users/jwhitmarsh/Library/Android/sdk/platform-tools/":$PATH

LTS="$(n --lts)"
CURRENT="$(node -v)"
GREEN='\033[01;32m'
RED='\033[01;31m'
NONE='\033[00m'
TODAY=$(date '+%y-%m-%d')

if [ ! -f /tmp/${TODAY} ]; then
	if [ $LTS = ${CURRENT/v/} ]; then
		echo -e "${GREEN}node is up to date with LTS: $LTS. go team!"
	else
		echo -e "${RED}node is behind LTS. please update to $LTS"
		echo ""
		echo -e "   ${NONE}sudo n $LTS"
	fi
	touch /tmp/${TODAY}
fi

export ABACUS_DEPLOYMENT_KEY=~/.ssh/drg-euw1-abacus-team.pem
export LAMP_DEPLOYMENT_KEY=~/.ssh/drg-euw1-cider-development.pem
export CIRCLE_TEST_REPORTS=/tmp/

eval "$(fasd --init auto)"

if [ -f ~/src/bash-sensible/sensible.bash ]; then
	source ~/src/bash-sensible/sensible.bash
fi
export _FASD_SINK="$HOME/.fasd.log"

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
