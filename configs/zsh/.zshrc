# Hyprland Setup - zsh configuration
# Integración con herramientas CLI modernas

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

# Starship prompt
eval "$(starship init zsh)"
