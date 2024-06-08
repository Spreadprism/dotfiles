# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/avalon/.oh-my-bash'

OMB_USE_SUDO=true

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

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

BIN_DIR=$HOME/bin
export PATH="$PATH:$BIN_DIR"
if ! command -v starship &> /dev/null; then
  echo "Installing"
  eget starship/starship --to=~/bin -a="starship-x86_64-unknown-linux-gnu.tar.gz"
fi
