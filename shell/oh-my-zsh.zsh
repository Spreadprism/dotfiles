#!/bin/zsh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim' 'turbo')
# INFO: Plugins
#
# plugin

plugins=(zsh-nvm zsh-lazyload git zsh-autosuggestions sudo dirhistory jsontools fzf-tab poetry)
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

autoload -Uz compinit && compinit
bindkey '^A' autosuggest-execute

source $ZSH/oh-my-zsh.sh

mkdir -p $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# INFO: Theme
ZSH_THEME="gnzh"
