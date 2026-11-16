# Equivalente a /usr/share/omarchy/default/bash/init. Sólo tiene sentido en
# sesiones interactivas.

status is-interactive; or return

if type -q mise
    mise activate fish | source
end

if test "$TERM" != dumb; and type -q starship
    starship init fish | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q try
    # `try init` de esta versión emite una función de bash aunque el --help
    # mencione fish, así que se escribe el equivalente: la función sólo evita
    # el salto a `command try` en cada llamada.
    function try --description 'Selector de workspaces efímeros (try)'
        set -l out (command try exec --path $HOME/Work/tries $argv 2>/dev/tty)
        if test $status -eq 0
            eval (string collect $out)
        else
            echo $out
        end
    end
end

# Sólo los atajos (Ctrl-R, Ctrl-T, Alt-C): fzf --fish no vuelve a envolver los
# completados de ~76 comandos en cada arranque como hacía completion.bash.
if type -q fzf
    fzf --fish | source
end
