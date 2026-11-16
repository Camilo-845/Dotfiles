function tdl --description 'Layout de desarrollo en tmux con editor, ai y terminal'
    if test -z "$argv[1]"
        echo "Usage: tdl <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end
    if test -z "$TMUX"
        echo "You must start tmux to use tdl."
        return 1
    end

    set -l current_dir $PWD
    set -l ai $argv[1]
    set -l ai2 $argv[2]

    # TMUX_PANE es estable aunque la ventana activa cambie
    set -l editor_pane $TMUX_PANE

    # Nombrar la ventana actual como el directorio base
    tmux rename-window -t $editor_pane (basename $current_dir)

    # Dividir la ventana verticalmente: arriba 85%, abajo 15%
    tmux split-window -v -p 15 -t $editor_pane -c $current_dir

    # Dividir el panel del editor horizontalmente: la IA a la derecha al 30%
    set -l ai_pane (tmux split-window -h -p 30 -t $editor_pane -c $current_dir -P -F '#{pane_id}')

    # Si hay una segunda IA, dividir el panel de la IA verticalmente
    if test -n "$ai2"
        set -l ai2_pane (tmux split-window -v -t $ai_pane -c $current_dir -P -F '#{pane_id}')
        tmux send-keys -t $ai2_pane $ai2 C-m
    end

    tmux send-keys -t $ai_pane $ai C-m
    tmux send-keys -t $editor_pane (string join ' ' $EDITOR .) C-m

    # El bash original apuntaba a $opencode_pane (sin definir en esta función);
    # aquí se selecciona el panel del editor, que es la intención del comentario.
    tmux select-pane -t $editor_pane
end
