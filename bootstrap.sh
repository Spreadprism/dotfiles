#! /bin/sh

GIT_REPO="https://github.com/Spreadprism/dotfiles.git"
DOTFILES_LOCATION="$HOME/.dotfiles"
USR_BIN="$HOME/bin"

# Interupt if error
set -e

# Install dotfiles
if [ ! -d $DOTFILES_LOCATION ]; then
  git clone $GIT_REPO $DOTFILES_LOCATION
  clear
fi

cd $DOTFILES_LOCATION

# Only bootstrap base configs + shell configs
stow base --adopt
stow shell --adopt

# We force our config files
git clean -df
git checkout -- .

# Install bash_it
BASH_IT_PATH=$HOME/.bash_it
if [ ! -d $BASH_IT_PATH ]; then
  git clone --depth=1 https://github.com/Bash-it/bash-it.git $BASH_IT_PATH
  ~/.bash_it/install.sh --no-modify-config
  clear
fi

# Install eget
cd $USR_BIN
EGET_PATH=$USR_BIN/eget
if [ ! -f $EGET_PATH ]; then
  curl -sS https://zyedidia.github.io/eget.sh | sh
  clear
fi

cd

exec bash
