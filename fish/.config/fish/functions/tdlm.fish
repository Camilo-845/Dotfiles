function tdlm --description 'Una ventana tdl por cada subdirectorio del directorio actual'
    if test -z "$argv[1]"
        echo "Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end
    if test -z "$TMUX"
        echo "You must start tmux to use tdlm."
        return 1
    end

    set -l ai $argv[1]
    set -l ai2 $argv[2]
    set -l base_dir $PWD
    set -l first true

    set -l ai_args (string escape --style=script -- $ai)
    test -n "$ai2"; and set ai_args "$ai_args "(string escape --style=script -- $ai2)

    # Renombrar la sesión como el directorio actual (tmux no admite puntos ni
    # dos puntos en el nombre)
    tmux rename-session (basename $base_dir | tr '.:' '--')

    for dir in $base_dir/*/
        test -d $dir; or continue
        set -l dirpath (string replace -r '/$' '' -- $dir)

        if $first
            # Reutilizar la ventana actual para el primer proyecto
            tmux send-keys -t $TMUX_PANE "cd "(string escape --style=script -- $dirpath)" && tdl $ai_args" C-m
            set first false
        else
            set -l pane_id (tmux new-window -c $dirpath -P -F '#{pane_id}')
            tmux send-keys -t $pane_id "tdl $ai_args" C-m
        end
    end
end
