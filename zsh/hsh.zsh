# Home Sweet Home
alias c="clear"
alias q="exit"

# utilities
alias la="ls -alh"
alias da="direnv allow"
alias ls="ls -AG1"
alias lc="colorls -l -a"
alias pg="pgcli"
function pgd() {
	if [[ "$DB_NAME" ]]; then
		pgcli $DB_NAME
	elif [[ "$DBNAME" ]]; then
		pgcli $DBNAME
	else
		echo "no $DB_NAME or $DBNAME"
	fi
}
alias cat="bat" # cat is better than bat


alias sl="storm list"
alias t="top"
alias top="htop"
alias j="fasd_cd -d"
alias jj="fasd_cd -d -i"
alias i='itermocil --here'
alias v='f -e vim' # quick opening files with vim
alias ad='d -e code'
alias af='f -e code'
alias fm="mv -v"
alias tk='task'
alias tkl='task list'
alias tka='task add'
alias typora="open -a typora"
alias typ="open -a typora"

# npm
alias ni="yarn i"
alias ns="yarn start"
alias nsd="yarn start:dev" #nest js specific
alias nr="yarn run"
alias nu="yarn upgrade-interactive --latest"
alias nrb="yarn run build"

# yarn
alias yi="yarn install"
alias ya="yarn add"
alias ys="yarn start"
alias ysd="yarn start:dev" #nest js specific
alias yr="yarn run"
alias yu="yarn upgrade-interactive --latest"

# bower
# alias bi="bower install"
# alias bis="bower install --save"
# alias bu="bower uninstall"

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
alias gl="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gla="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"


alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'

alias gp='git push'
alias gpd='git push --dry-run'
alias gptags='git push && git push --tags'

alias gr='git rebase'
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
alias glt="git describe --abbrev=0 --tags"
alias grh='git reset HEAD'

alias gcp="git cherry-pick"
alias ghb='hub browse'

# fasd
alias fls='fasd -d -e "ls -AG1"'
alias tim='/usr/bin/time -p'

alias flushdns='sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache'

alias google-chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
