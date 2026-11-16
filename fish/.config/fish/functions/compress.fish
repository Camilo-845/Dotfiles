function compress --description 'Comprimir un archivo o directorio a .tar.gz'
    if test (count $argv) -ne 1
        echo "Usage: compress <file-or-directory>"
        return 1
    end

    set -l target (string replace -r '/$' '' -- $argv[1])
    tar -czf "$target.tar.gz" "$target"
end
