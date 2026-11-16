function rsw --description 'Vigilar cambios de un directorio y sincronizarlo con rsync'
    if test (count $argv) -ne 2
        echo "Usage: rsw <source> <destination>"
        return 1
    end

    set -l src (string replace -r '/$' '' -- $argv[1])
    set -l dest $argv[2]

    # Reutilizar una sola conexión SSH por login, para que 1Password sólo
    # pregunte una vez.
    set -l sockets $XDG_RUNTIME_DIR
    test -n "$sockets"; or set sockets $HOME/.ssh/sockets
    mkdir -p $sockets
    set -l rsh "ssh -o ControlMaster=auto -o ControlPath=$sockets/rsw-%r@%h:%p -o ControlPersist=yes"

    setsid --fork env RSYNC_RSH="$rsh" bash -c 'rsync -a "$1/" "$2"; while inotifywait -r -q -e modify,create,delete,move "$1"; do rsync -a "$1/" "$2"; done' rsw-watch $src $dest >/dev/null 2>&1

    echo "Watching $src -> $dest"
end
