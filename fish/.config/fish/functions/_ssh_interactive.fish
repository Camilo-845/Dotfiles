function _ssh_interactive --description '¿Es una sesión ssh interactiva (destino sin comando remoto)?'
    # Las letras son las opciones de ssh(1) que consumen un valor, para no
    # confundir su argumento con el destino.
    set -l value_opts BbcDEeFIiJLlmOoPpQRSWw
    set -l rest $argv
    set -l dest ''
    set -l opts_done ''

    while test (count $rest) -gt 0
        set -l arg $rest[1]
        set -e rest[1]

        if test -z "$opts_done"; and test "$arg" = --
            set opts_done 1
        else if test -z "$opts_done"; and string match -qr '^-.' -- $arg
            set -l letters (string replace -r '^-' '' -- $arg)
            for i in (seq (string length -- $letters))
                if string match -q -- "*"(string sub -s $i -l 1 -- $letters)"*" $value_opts
                    # El valor va pegado a la letra (-p2222) salvo que la letra
                    # termine el argumento, en cuyo caso consume el siguiente
                    # (-p 2222).
                    test $i -eq (string length -- $letters); and set -e rest[1]
                    break
                end
            end
        else if test -z "$dest"
            set dest $arg
        else
            return 1
        end
    end

    test -n "$dest"; or return 1

    # Un RemoteCommand de ssh_config o de -o se repite al reconectar igual que
    # un comando posicional; ssh -G resuelve la configuración efectiva de esta
    # invocación exacta sin conectar. Si no se puede resolver, se falla cerrado:
    # un RemoteCommand no detectado nunca debe repetirse. El "none" explícito
    # cancela un comando configurado, y algunas versiones lo emiten cuando no
    # hay ninguno.
    set -l resolved (command ssh -G $argv 2>/dev/null)
    if test (count $resolved) -eq 0
        return 1
    end

    for line in (string match -ri '^remotecommand ' -- $resolved)
        string match -qi '^remotecommand none$' -- $line; or return 1
    end

    return 0
end
