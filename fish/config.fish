set -gx PAGER "/usr/bin/less -S"
set -x PATH $PATH /Library/Frameworks/Python.framework/Versions/3.7/bin (npm config get prefix)/bin (yarn global dir) /usr/local/opt/postgresql@9.6/bin

source ~/.config/fish/aliases.fish

eval (direnv hook fish)
