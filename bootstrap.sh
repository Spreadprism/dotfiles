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
stow base
stow shell

cd $USR_BIN

# Install eget
if [ ! -f $USR_BIN/eget ]; then
  curl -sS https://zyedidia.github.io/eget.sh | sh
  clear
fi

if [ ! -d $HOME/.oh-my-bash ]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
  clear
fi

cd $DOTFILES_LOCATION
