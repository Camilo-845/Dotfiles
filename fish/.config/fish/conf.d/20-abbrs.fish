# Equivalente a /usr/share/omarchy/default/bash/aliases.
#
# Los alias de un solo comando se hacen con `abbr`: se expanden al pulsar
# espacio, como los alias de bash, y no afectan a scripts ni a funciones.

status is-interactive; or return

# --- Sistema de archivos ---
if type -q eza
    abbr -a -- ls 'eza -lh --group-directories-first --icons=auto'
    abbr -a -- lsa 'eza -lha --group-directories-first --icons=auto'
    abbr -a -- lt 'eza --tree --level=2 --long --icons --git'
    abbr -a -- lta 'eza --tree --level=2 --long --icons --git -a'
end

# --- Directorios ---
abbr -a -- .. 'cd ..'
abbr -a -- ... 'cd ../..'
abbr -a -- .... 'cd ../../..'

# --- Herramientas ---
abbr -a -- a 'omarchy-agent --inline'
abbr -a -- c 'opencode --auto'
abbr -a -- cx 'printf "\033[2J\033[3J\033[H"; and claude --permission-mode auto'
abbr -a -- cy 'codex --approve-for-me'
abbr -a -- d 'docker'
abbr -a -- r 'rails'
abbr -a -- t 'tmux attach; or tmux new -s Work'
abbr -a -- h 'herdr'
abbr -a -- ic 'tdl c'
abbr -a -- ix 'tdl cx'
abbr -a -- icx 'tdl c cx'
abbr -a -- mup 'env MISE_MINIMUM_RELEASE_AGE=0 mise up'
abbr -a -- decompress 'tar -xzf'

# --- Git ---
abbr -a -- g 'git'
abbr -a -- gcm 'git commit -m'
abbr -a -- gcam 'git commit -a -m'
abbr -a -- gcad 'git commit -a --amend'

# --- zoxide ---
# En bash `cd` es un alias a `zd`; el equivalente literal es un abbr, para no
# redefinir `cd` en scripts y funciones que también usan fish.
abbr -a -- cd zd
