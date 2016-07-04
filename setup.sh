#!/bin/bash

# need to document
HERE=$(pwd)
echo 'Setting up dotfiles...'

BASHRC=~/.bashrc
ALIASES=~/.bash_aliases
PROFILE=~/.bash_profile
LIQUIDPROMPT=~/.liquidpromptrc
GITCONFIG=~/.gitconfig
GITMESSAGE=~/.gitmessage
GITIGNOREGLOBAL=~/.gitignore_global
WITHFORCE=''

if [[ $* == *--force* ]]; then
  WITHFORCE='-f'
fi

if [ -f "$BASHRC" ] || [ -f "$ALIASES" ] || [ -f "$PROFILE" ] || [ -f "$LIQUIDPROMPT" ] || [ -f "$GITCONFIG" ] ||
[ -f "$GITMESSAGE" ] || [ -f "$GITIGNOREGLOBAL" ] && [[ $* != *--force* ]]
then
  echo "Symlinked file(s) already exists"
  echo "Run this script with --force if you are feeling brave.."
  exit -1
fi

ln -s $WITHFORCE $HERE/bashrc $BASHRC
ln -s $WITHFORCE $HERE/aliases $ALIASES
ln -s $WITHFORCE $HERE/profile $PROFILE
ln -s $WITHFORCE $HERE/liquidpromptrc $LIQUIDPROMPT
ln -s $WITHFORCE $HERE/gitconfig $GITCONFIG
ln -s $WITHFORCE $HERE/gitmessage $GITMESSAGE
ln -s $WITHFORCE $HERE/gitignore_global $GITIGNOREGLOBAL
ln -s $WITHFORCE $HERE/gitconfig ~/nowhere
echo 'Done'
