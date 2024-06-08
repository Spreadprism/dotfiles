# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

export OSH=$HOME/.oh-my-bash

if [ ! -d $OSH ]; then
  git clone --depth=1 https://github.com/ohmybash/oh-my-bash.git $OSH
  clear
fi

completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)
source "$OSH"/oh-my-bash.sh
# ------------------------------------------------------------
# Binaries
# ------------------------------------------------------------
BIN_DIR=$HOME/bin
export PATH="$PATH:$BIN_DIR"
EGET_PATH=$BIN_DIR/eget
if [ ! -f $EGET_PATH ]; then
  LAST_PWD=$PWD
  cd $BIN_DIR
  curl -sS https://zyedidia.github.io/eget.sh | sh
  cd $LAST_PWD
fi

if ! command -v starship &> /dev/null; then
  eget starship/starship --to=~/bin -a="starship-x86_64-unknown-linux-gnu.tar.gz"
fi

if ! command -v bob &> /dev/null; then
  eget MordechaiHadad/bob --to=~/bin -a="bob-linux-x86_64.zip"
fi

if ! command -v rg &> /dev/null; then
  eget BurntSushi/ripgrep --to=~/bin
fi

if ! command -v fzf &> /dev/null; then
  eget junegunn/fzf --to=~/bin
fi

if ! command -v jq &> /dev/null; then
  eget jqlang/jq --to=~/bin -a="jq-linux64"
fi

eval "$(starship init bash)"
