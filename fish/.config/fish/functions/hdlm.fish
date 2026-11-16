function hdlm --description 'Un tab hdl por cada subdirectorio del directorio actual'
    if test -z "$argv[1]"
        echo "Usage: hdlm <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end
    if test -z "$HERDR_PANE_ID"
        echo "You must start herdr to use hdlm."
        return 1
    end

    set -l ai $argv[1]
    set -l ai2 $argv[2]
    set -l base_dir $PWD
    set -l first true

    set -l hdl_command "hdl "(string escape --style=script -- $ai)
    test -n "$ai2"; and set hdl_command "$hdl_command "(string escape --style=script -- $ai2)

    # Renombrar el workspace como el directorio actual
    herdr workspace rename $HERDR_WORKSPACE_ID (basename $base_dir) >/dev/null

    for dir in $base_dir/*/
        test -d $dir; or continue
        set -l dirpath (string replace -r '/$' '' -- $dir)

        if $first
            # Reutilizar el tab actual para el primer proyecto
            herdr pane run $HERDR_PANE_ID "cd "(string escape --style=script -- $dirpath)" && $hdl_command" >/dev/null
            set first false
        else
            set -l pane_id (herdr tab create --workspace $HERDR_WORKSPACE_ID --cwd $dirpath --no-focus |
                jq -r '.result.root_pane.pane_id')
            herdr pane run $pane_id $hdl_command >/dev/null
        end
    end
end
