# INFO: use "make private_zsh" if you want to add private aliases and functions
source ~/.zshrc_private

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# INFO: Start tmux only if not inside tmux already.
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# INFO: Aliases
alias activate='conda activate'
alias deactivate='conda deactivate'
# alias nvim='nvim --listen localhost:12345'
#
# Doing all the possible typos
alias v='nvim'
alias vim='nvim'
alias vnim='nvim'
alias nvmi='nvim'
alias vmi='nvim'
alias n='nvim'

alias nc='rm -rf ~/.local/state/nvim/swap && mkdir ~/.local/state/nvim/swap'
alias lg='lazygit'

# windows commands
alias wsl='wsl.exe'
alias explorer='explorer.exe .'
alias pws='powershell.exe'

# INFO: Edit and source config
alias ezshrc='nvim ~/.zshrc && source ~/.zshrc'
alias estarship='nvim ~/.config/starship.toml && source ~/.zshrc'
alias envim='(cd ~/.config/nvim && nvim)'
alias etmux='nvim ~/.config/tmux/tmux.conf && tmux source ~/.config/tmux/tmux.conf'

# INFO: Plugins
plugins=(git zsh-autosuggestions sudo)

autoload -Uz compinit && compinit
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
bindkey '^A' autosuggest-execute
source $ZSH/oh-my-zsh.sh


# INFO: Theme
ZSH_THEME="gnzh"

# INFO: Conda setup
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
# INFO: Activate conda environment if it exists
current_directory_name="${PWD##*/}"

envs=$(conda env list | awk '{print $1}' | grep -v '^#')

if [[ $envs == *"$current_directory_name"* ]]; then
    conda activate "$current_directory_name"
fi

# Created by `pipx` on 2023-11-15 12:54:02
export PATH="$PATH:$HOME/.local/bin"
eval "$(starship init zsh)"
