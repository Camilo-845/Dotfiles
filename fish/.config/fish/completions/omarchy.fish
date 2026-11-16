# Autocompletado de nivel 1 para el dispatcher `omarchy`.
#
# Omarchy expone cada subcomando como un binario omarchy-<cmd>-<sub>..., así que
# los candidatos se derivan listando ese directorio, igual que
# _omarchy_complete en bash. Sólo se completan subcomandos de primer nivel; el
# parseo de `# omarchy:args=` de cada binario queda fuera de alcance.
#
# El bash además oculta omarchy-* del autocompletado de comandos con
# `complete -I -A command -X`; fish no ofrece un equivalente limpio, así que se
# omite.

function __omarchy_candidates --description 'Subcomandos de primer nivel de omarchy'
    # Sólo en la posición del primer argumento: se descarta el comando y, si se
    # está escribiendo, el token en curso.
    set -l args (commandline -opc)[2..-1]
    set -l current (commandline -ct)
    if test -n "$current"
        set -e args[-1]
    end
    test (count $args) -eq 0; or return

    type -q omarchy; or return
    set -l omarchy_path (command -v omarchy)
    set -l bin_dir (dirname (realpath $omarchy_path 2>/dev/null; or echo $omarchy_path))
    test -d $bin_dir; or return

    set -l seen
    for file in $bin_dir/omarchy-*
        test -f $file; and test -x $file; or continue

        set -l rest (string replace -r '^omarchy-' '' -- (basename $file))
        set -l next (string split -m1 -- '-' $rest)[1]
        test -n "$next"; or continue
        contains -- $next $seen; and continue

        set -a seen $next
        echo $next
    end
end

complete -c omarchy -f -a '(__omarchy_candidates)'
complete -c omarchy -n '__fish_seen_subcommand_from commands' -a '--all --json --markdown --check'
