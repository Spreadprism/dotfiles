#!/bin/zsh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# INFO: Plugins
plugins=(git zsh-autosuggestions sudo dirhistory jsontools)
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

autoload -Uz compinit && compinit
bindkey '^A' autosuggest-execute

source $ZSH/oh-my-zsh.sh

# INFO: Theme
ZSH_THEME="gnzh"
