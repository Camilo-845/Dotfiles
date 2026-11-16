function zd --description 'cd con zoxide, con fallback al cd de fish'
    if test (count $argv) -eq 0
        builtin cd ~
        return
    end

    if test -d $argv[1]
        builtin cd $argv[1]
        return
    end

    if not z $argv
        echo "Error: Directory not found" >&2
        return 1
    end

    printf '\U000F17A9 '
    pwd
end
