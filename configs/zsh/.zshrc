# ~/.zshrc

################################
# PATHS
################################
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"

################################
# EDITOR
################################
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

################################
# HISTORIAL
################################
HISTFILE="$HOME/.history"
HISTSIZE=10000
SAVEHIST=50000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

################################
# OPCIONES DE SHELL
################################
setopt AUTO_CD
setopt CORRECT
setopt NO_BEEP

################################
# COMPLETIONS
################################
autoload -Uz compinit
compinit

################################
# FZF
################################
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

################################
# BINDKEYS (Alt+→ / Alt+← para mover por palabra)
################################
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

################################
# NVM (Node Version Manager)
################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

################################
# ALIASES
################################
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# cat mejorado
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi

# eza como reemplazo de ls
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=auto --group-directories-first'
  alias ll='eza -lha --icons=auto --group-directories-first'
  alias tree='eza -T --icons=auto'
else
  alias ls='ls --color=auto'
  alias ll='ls -lha'
fi

# grep con ripgrep
if command -v rg >/dev/null 2>&1; then
  alias grep='rg'
fi

alias c='clear'
alias dc='docker compose'
alias d='docker'

# Info del sistema
if command -v fastfetch >/dev/null 2>&1; then
  alias sysinfo='fastfetch'
fi

# Monitor de recursos
if command -v btop >/dev/null 2>&1; then
  alias topres='btop'
fi

################################
# FUNCIONES PDF (Ghostscript)
################################

pdfcompress-low () {
  if [ $# -ne 2 ]; then
    echo "Uso: pdfcompress-low input.pdf output.pdf"
    return 1
  fi

  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
     -dNOPAUSE -dQUIET -dBATCH \
     -sOutputFile="$2" "$1"
}

pdfcompress-medium () {
  if [ $# -ne 2 ]; then
    echo "Uso: pdfcompress-medium input.pdf output.pdf"
    return 1
  fi

  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer \
     -dNOPAUSE -dQUIET -dBATCH \
     -sOutputFile="$2" "$1"
}

# pdfmerge in1.pdf in2.pdf ... salida.pdf
pdfmerge () {
  if [ $# -lt 2 ]; then
    echo "Uso: pdfmerge in1.pdf [in2.pdf ...] salida.pdf"
    return 1
  fi

  local salida="${@: -1}"
  local entradas=("${@:1:$#-1}")

  gs -dBATCH -dNOPAUSE -dQUIET -q -sDEVICE=pdfwrite \
     -sOutputFile="$salida" "${entradas[@]}"
}

################################
# zoxide (cd mejorado)
################################
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

################################
# Starship (prompt Catppuccin)
################################
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
