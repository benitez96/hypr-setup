export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

setopt inc_append_history
HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# zoxide (cd inteligente)
eval "$(zoxide init zsh)"

# fzf (fuzzy finder)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh



# Aliases útiles
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias cat='bat'
alias grep='rg'
alias find='fd'
alias top='btop'
alias df='df -h'
alias du='du -h'
alias dc='docker compose'
alias d='docker'

# Starship prompt
eval "$(starship init zsh)"



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
