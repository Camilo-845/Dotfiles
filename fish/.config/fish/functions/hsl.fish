function hsl --description 'Layout swarm: el mismo comando en cada panel (ideal para IA)'
    if test -z "$argv[1]"; or test -z "$argv[2]"
        echo "Usage: hsl <pane_count> <command>"
        return 1
    end
    if test -z "$HERDR_PANE_ID"
        echo "You must start herdr to use hsl."
        return 1
    end

    set -l count $argv[1]
    set -l cmd $argv[2]
    set -l current_dir $PWD

    herdr tab rename $HERDR_TAB_ID (basename $current_dir) >/dev/null

    # Distribuir en una rejilla: ceil(sqrt(count)) columnas, filas repartidas
    set -l cols 1
    while test (math "$cols * $cols") -lt $count
        set cols (math "$cols + 1")
    end

    # Las columnas pares salen de partir la más a la derecha en 1/(n-k+1) cada
    # vez, lo que mantiene el array ordenado de izquierda a derecha.
    set -l columns $HERDR_PANE_ID
    for k in (seq 1 (math "$cols - 1"))
        set -a columns (_herdr_split $columns[-1] right (_herdr_ratio 1 (math "$cols - $k + 1")) $current_dir)
    end

    # Partir cada columna en su cuota de filas, también de forma uniforme y de
    # arriba a abajo.
    set -l panes
    for index in (seq 0 (math "$cols - 1"))
        set -l col $columns[(math "$index + 1")]
        set -l rows (math "floor($count / $cols)")
        if test $index -lt (math "$count % $cols")
            set rows (math "$rows + 1")
        end

        set -a panes $col
        set -l last $col
        for j in (seq 1 (math "$rows - 1"))
            set last (_herdr_split $last down (_herdr_ratio 1 (math "$rows - $j + 1")) $current_dir)
            set -a panes $last
        end
    end

    for pane in $panes
        herdr pane run $pane $cmd >/dev/null
    end
end
