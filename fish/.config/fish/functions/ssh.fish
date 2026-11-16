function ssh --description 'ssh que limpia el terminal y reconecta si la conexión cae'
    set -l started (date +%s)

    command ssh $argv
    set -l rc $status

    isatty stdout; or return $rc
    _ssh_disarm

    # Reconectar sólo cuando cae una sesión interactiva: ssh sale con 255 en
    # fallos de transporte, pero un 255 rápido sin sesión establecida es un
    # fallo de conexión/autenticación, el 255 de un comando remoto pasa
    # indistinguible y no debe repetir sus efectos, y un stdin redirigido
    # alimentaría la entrada restante a un shell remoto nuevo.
    test $rc -eq 255; or return $rc
    isatty stdin; or return $rc
    _ssh_interactive $argv; or return $rc
    if test (math (date +%s) - $started) -lt 30
        return $rc
    end

    # Reintentar en la misma función: Ctrl-C alcanza a todo el grupo de
    # procesos en primer plano, así que cancela el intento en curso y el bucle.
    # Se reintentan los fallos rápidos, ya que un servidor reiniciándose también
    # rechaza conexiones.
    while true
        echo "Connection lost. Reconnecting (Ctrl-C to stop)..."
        sleep 2
        command ssh $argv
        set rc $status
        _ssh_disarm
        test $rc -eq 255; or return $rc
    end
end
