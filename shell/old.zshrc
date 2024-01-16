# INFO: Importing our utilities before everything else
export PATH="$PATH:$HOME/.dotfiles/bin"

# INFO: use "make private_zsh" if you want to add private aliases and functions
source ~/.zshrc_private

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# INFO: Start tmux only if not inside tmux already.
if [ -z "$TMUX" ]; then
  if tmux run 2>/dev/null; then
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      #TMUX is not running
      FOUND_SESSION=false
      SESSION_ID=""
      SESSION_N=0
      #Find session to attach to
      for line in $(tmux ls -F "#{session_id}:#{?session_attached,attached,not-attached}"); do
        SESSION_ATTACHED=$(echo "$line" | cut -d':' -f2)
        if [ "$SESSION_ATTACHED" = "not-attached" ]; then
          SESSION_ID=$(echo "$line" | cut -d':' -f1)
          echo $SESSION_ID
          FOUND_SESSION=true
          break
        fi
        SESSION_N=$((SESSION_N+1))
      done

      if [ "$FOUND_SESSION" = true ]; then
        tmux attach-session -t "$SESSION_ID"
        exit
      else
        exec tmux new -s "$SESSION_N" -c "$PWD"
      fi
    fi
  else
    exec tmux new -s 0 -c "$PWD"
  fi

fi


# INFO: Aliases
# Doing all the possible typos
alias v='nvim'
alias vim='nvim'
alias vnim='nvim'
alias nvmi='nvim'
alias vmi='nvim'
alias n='nvim'
alias nivm='nvim'
export NVIM_LISTEN_ADDRESS='/tmp/nvim.socket'

alias nclear='rm -rf ~/.local/state/nvim/swap && mkdir ~/.local/state/nvim/swap'
alias nc='nclear'
alias lg='lazygit'
alias ld='lazydocker'

source ./wsl_configs.sh

# INFO: Edit and source config
alias ezshrc='nvim ~/.zshrc && source ~/.zshrc'
alias estarship='nvim ~/.config/starship.toml && source ~/.zshrc'
alias envim='(cd ~/.config/nvim && nvim)'
alias etmux='nvim ~/.config/tmux/tmux.conf && tmux source ~/.config/tmux/tmux.conf'

# INFO: Plugins
plugins=(git zsh-autosuggestions sudo dirhistory jsontools)
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

autoload -Uz compinit && compinit
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

conda config --set auto_activate_base false
current_directory_name="${PWD##*/}" 

alias deactivate='conda deactivate'
alias activate='source ~/miniconda3/bin/activate $(basename $(pwd))'

# INFO: Activate conda environment if it exists
envs=$(conda env list | awk '{print $1}' | grep -v '^#')
if [[ $envs == *"$current_directory_name"* ]]; then
    conda activate "$current_directory_name"
fi

# Created by `pipx` on 2023-11-15 12:54:02
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin/"

# Needs eza
alias ls='eza'
alias ll='eza --tree'

# Needs entr
alias watch='entr'

# Needs zoxide
alias cd='z'
alias zz='z -'
export _ZO_ECHO=0

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
