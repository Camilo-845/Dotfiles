function open --description 'Abrir un archivo con la aplicación por defecto' --wraps xdg-open
    xdg-open $argv >/dev/null 2>&1 &
end
