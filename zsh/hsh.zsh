# Home Sweet Home
alias c="clear"
alias q="exit"

# utilities
alias la="ls -al"
alias da="direnv allow"
alias ls="ls -AG1"
alias pg="pgcli"
alias sl="storm list"
alias t="top"
alias top="htop"
alias j="fasd_cd -d"
alias jj="fasd_cd -d -i"
alias i='itermocil --here'
alias v='f -e vim' # quick opening files with vim

# gulp
alias gu="gulp"
alias gub="gu build"
alias gur="gulp release "
alias guu="gulp unit-test"

# npm
alias ni="npm i"
alias ns="npm start"
alias nr="npm run"

# git
alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'

alias gb='git branch'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'

alias gk="git checkout"
alias gkb='git checkout -b'
alias gclean='git clean -fd'
alias gkm='git checkout master'
alias gcm='git commit -m'
alias gd='git diff'

gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

alias gitkb='\gitk --all --branches'
compdef _git gk='gitk'
alias gitke='\gitk --all $(git log -g --pretty=%h)'
compdef _git gke='gitk'

alias gpl='git pull'
alias gl="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"


alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'

alias gp='git push'
alias gpd='git push --dry-run'

alias grb='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase -i'
alias gro='git rebase master'
alias grs='git rebase --skip'

alias gss='git status'
alias gst='git status'
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'