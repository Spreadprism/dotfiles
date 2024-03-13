zmodload zsh/zprof
alias zperf='zprof'

CONFIG_DIR="$HOME/.dotfiles/shell"

# INFO: Importing our utilities before everything else
export PATH="$PATH:$HOME/.dotfiles/bin"

# INFO: Sourcing our shell files
# echo "Sourcing tmux"
source "$CONFIG_DIR/tmux.zsh"
# echo "Sourcing aliases"
source "$CONFIG_DIR/aliases.zsh"
# echo "Sourcing oh-my-zsh"
source "$CONFIG_DIR/oh-my-zsh.zsh"
# echo "Sourcing nvim"
source "$CONFIG_DIR/nvim.zsh"

# INFO: source wsl only if we are in wsl
if [[ $(grep -i Microsoft /proc/version) ]]; then
  export IN_WSL="true"
  source "$CONFIG_DIR/wsl.zsh"
else
  export IN_WSL="false"
fi

new-notebook() {
    echo "{
 \"cells\": [],
 \"metadata\": {},
 \"nbformat\": 4,
 \"nbformat_minor\": 2
}" > $(pwd)/$1
}

# INFO: Conda
lazyload conda -- 'source $HOME/.dotfiles/shell/conda.zsh'

env_dir="$HOME/miniconda3/envs"
current_directory_name="${PWD##*/}"

# if $env or $env + "_env" exists, activate it
if [ -d "$env_dir/$current_directory_name"_env ]; then
    conda activate "$current_directory_name"_env
elif [ -d "$env_dir/$current_directory_name" ]; then
    conda activate "$current_directory_name"
fi


# Created by `pipx` on 2023-11-15 12:54:02
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin/"

# echo "Sourcing private"
# INFO: Sourcing our private shell (We must do this at the end if we want to override anything)
source "$CONFIG_DIR/private.zsh"

# Needs eza
alias ls='eza'
alias ll='eza --tree'

# Needs eza
alias ls='eza'
alias ll='eza --tree'
# echo "Initializing prompt"
export _ZO_ECHO=0
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
# INFO: FZF-tab
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# pnpm
export PNPM_HOME="/home/avalon/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
