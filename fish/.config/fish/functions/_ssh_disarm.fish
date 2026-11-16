function _ssh_disarm --description 'Desarmar los modos de terminal que deja un ssh que cae'
    # Mouse tracking (1000/1002/1003, codificación 1006), focus reporting
    # (1004) y pantalla alternativa (1049), y volver a mostrar el cursor.
    printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1004l\e[?1049l\e[?25h'
end
