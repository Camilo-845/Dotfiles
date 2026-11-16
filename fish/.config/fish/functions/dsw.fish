function dsw --description 'Detener los watchers de rsync activos'
    set -l found 0

    for pid in (pgrep -f 'rsw-watch ')
        if command kill -- -$pid 2>/dev/null
            echo "Stopped watch (pid $pid)"
            set found 1
        end
    end

    test $found -eq 1; or echo "No active watches"
end
