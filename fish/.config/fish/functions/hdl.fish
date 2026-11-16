function hdl --description 'Layout de desarrollo de Herdr con editor, ai y terminal'
    if test -z "$argv[1]"
        echo "Usage: hdl <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end
    if test -z "$HERDR_PANE_ID"
        echo "You must start herdr to use hdl."
        return 1
    end

    set -l current_dir $PWD
    set -l ai $argv[1]
    set -l ai2 $argv[2]

    # HERDR_PANE_ID es estable aunque el foco se mueva
    set -l editor_pane $HERDR_PANE_ID

    # Nombrar el tab actual como el directorio base
    herdr tab rename $HERDR_TAB_ID (basename $current_dir) >/dev/null

    # Dividir el tab verticalmente: arriba 85%, abajo 15%
    _herdr_split $editor_pane down 0.85 $current_dir >/dev/null

    # Dividir el panel del editor horizontalmente: la IA a la derecha al 30%
    set -l ai_pane (_herdr_split $editor_pane right 0.7 $current_dir)

    # Si hay una segunda IA, dividir el panel de la IA verticalmente
    if test -n "$ai2"
        set -l ai2_pane (_herdr_split $ai_pane down 0.5 $current_dir)
        herdr pane run $ai2_pane $ai2 >/dev/null
    end

    herdr pane run $ai_pane $ai >/dev/null
    herdr pane run $editor_pane (string join ' ' $EDITOR .) >/dev/null
end
