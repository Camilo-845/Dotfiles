# Configuración de fish derivada de los defaults de Omarchy para bash
# (/usr/share/omarchy/default/bash).
#
# El orden de carga replica la cadena bash rc -> envs -> shell -> aliases ->
# functions -> init -> inputrc, repartido en conf.d/ y functions/:
#
#   conf.d/00-omarchy-env.fish  OMARCHY_PATH + PATH      (env-bootstrap)
#   conf.d/10-envs.fish         EDITOR, BROWSER, locale  (envs)
#   conf.d/20-abbrs.fish        alias de fs, tools y git (aliases)
#   conf.d/30-init.fish         mise, starship, zoxide,
#                               try, fzf                 (init)
#   functions/*.fish            fns/* y helpers de aliases
#   completions/omarchy.fish    _omarchy_complete (nivel 1)
#
# Notas sobre lo que no se porta:
#   * inputrc es de readline; fish ya usa búsqueda por prefijo en ↑/↓,
#     autocompletado case-insensitive y "skip completed text" por defecto.
#   * El historial de fish no necesita histappend/HISTSIZE ni `set +h`.
#   * `complete -I -A command -X 'omarchy-*'` (ocultar binarios del
#     autocompletado de comandos) no tiene equivalente limpio en fish.

if status is-interactive
    set -g fish_greeting ""
end
