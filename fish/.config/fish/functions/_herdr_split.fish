function _herdr_split --description 'Dividir un panel de herdr y emitir el id del nuevo panel' --argument-names pane direction ratio cwd
    herdr pane split $pane --direction $direction --ratio $ratio --cwd $cwd --no-focus |
        jq -r '.result.pane.pane_id'
end
