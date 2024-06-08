#! /bin/sh

GIT_REPO="https://github.com/Spreadprism/dotfiles.git"
DOTFILES_LOCATION="$HOME/.dotfiles"
USR_BIN="$HOME/bin"

# Interupt if error
set -e

if [ ! -d $DOTFILES_LOCATION ]; then
  git clone $GIT_REPO $DOTFILES_LOCATION
  clear
fi

cd $DOTFILES_LOCATION

stow base --adopt
stow shell --adopt

cd $USR_BIN

# Install bash-it
if [ ! -d $HOME/.bash_it ]; then
  git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
  ~/.bash_it/install.sh --no-modify-config
  clear
fi

# Install eget
if [ ! -f $USR_BIN/eget ]; then
  curl -sS https://zyedidia.github.io/eget.sh | sh
  clear
fi

cd $DOTFILES_LOCATION
