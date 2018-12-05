# .bash_profile is sourced for a login shell.
# my .xsessionrc sources it, so place in here 'session' type configuration.
#
# <http://lists.gnu.org/archive/html/bug-bash/2005-01/msg00263.html> is a good
# explanation of this insanity. Also <http://lkml.org/lkml/2005/4/25/205>.

export PATH=$PATH:$HOME/bin

export PATH=$PATH:$HOME/.rvm/scripts/rvm

source "$HOME/.rvm/scripts/rvm"

test -f ~/.pythonrc && export PYTHONSTARTUP=$HOME/.pythonrc

case "$(uname -s)" in
Linux)
	# Received wisdom from Cygwin's default .bashrc
	unset TMP
	unset TEMP
	# MacPorts Installer addition on 2015-03-11_at_12:26:02: adding an appropriate PATH variable for use with MacPorts.
	export PATH="/opt/local/bin:/opt/local/sbin:/home/ec2-user/src/keychain-2.8.1/:$PATH"
	# Finished adapting your PATH environment variable for use with MacPorts.

	eval `keychain --eval --agents ssh id_rsa`
	;;
Darwin)
	export CLICOLOR=1
	;;
esac

# Source .bashrc if this is an interactive shell
case $- in
*i*)
	source ~/.bashrc
	;;
esac

# sbin
export PATH="/usr/local/sbin:$PATH"

# iTerm shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Powerline
function _update_ps1() {
    PS1="$(~/powerline-shell.py $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
export ANDROID_HOME=/usr/local/share/android-sdk
export JAVA_HOME=/Library/Java/Home
