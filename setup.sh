#!/bin/bash

# need to document
HERE=$(pwd)
echo 'Setup dotfiles'

ln -s $HERE/bashrc ~/.bashrc
ln -s $HERE/aliases ~/.bash_aliases
ln -s $HERE/profile ~/.bash_profile
