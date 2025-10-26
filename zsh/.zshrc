# --- PATHs ---
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# --- Autocompletado insensible a mayúsculas ---
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$(go env GOPATH)/bin"
ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
)

zstyle ':omz:update' frequency 13
source $ZSH/oh-my-zsh.sh

# --- Zoxide ---
eval "$(zoxide init zsh)"

# -- Vim Motions --
source ${ZDOTDIR:-$HOME}/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
export ZVM_MODE_INITIAL=vicmd

# --- Alias y funciones ---
alias ls='exa --icons --color=auto --grid'
alias ll='exa -l --icons --color=auto --group-directories-first --header'
alias lt='exa -lT --icons --color=auto --header --git'

alias welcome='random_cowsay | lolcat'
alias daily="fortune | random_cowsay | lolcat"
alias acuarium="asciiquarium"
alias ff="fastfetch"

alias cat='bat --style=plain'
alias grep='rg'

alias lg='lazygit'

random_cowsay() {
  local cow="${1:-$(cowsay -l | tail -n +2 | tr ' ' '\n' | shuf -n1)}"
  if [ -t 0 ]; then
    local message="${2:-¡Bienvenido a la terminal!}"
  else
    local message=$(cat)
  fi
  cowsay -f "$cow" "$message"
}

# --- Prompt ---
eval "$(oh-my-posh init zsh)"
