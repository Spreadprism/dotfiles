#!/bin/zsh

# INFO: General
alias lg='lazygit'
alias ld='lazydocker'
# Needs eza
alias ls='eza'
alias ll='eza --tree'
# Needs entr
alias watch='entr'
# Needs zoxide
alias cd='z'
alias zz='z -'

# INFO: Nvim
alias nclear='rm -rf ~/.local/state/nvim/swap && mkdir ~/.local/state/nvim/swap'
alias nc='nclear'
alias v='nvim'
alias vim='nvim'
alias vnim='nvim'
alias nvmi='nvim'
alias vmi='nvim'
alias n='nvim'
alias nivm='nvim'

# INFO: Conda
alias deactivate='conda deactivate'
alias activate='source ~/miniconda3/bin/activate $(basename $(pwd))'

# INFO: Edit and source config
alias ezshrc='nvim ~/.zshrc && source ~/.zshrc'
alias estarship='nvim ~/.config/starship.toml && source ~/.zshrc'
alias envim='(cd ~/.config/nvim && nvim)'
alias etmux='nvim ~/.config/tmux/tmux.conf && tmux source ~/.config/tmux/tmux.conf'


