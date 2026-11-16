function n --description 'nvim en el directorio actual si no hay argumentos'
    if test (count $argv) -eq 0
        command nvim .
    else
        command nvim $argv
    end
end
