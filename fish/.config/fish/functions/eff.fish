function eff --description 'Abrir con $EDITOR el archivo elegido con ff'
    set -l file (ff)
    test -n "$file"; and $EDITOR $file
end
