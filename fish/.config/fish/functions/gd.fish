function gd --description 'Eliminar el worktree activo y su rama'
    if not gum confirm "Remove worktree and branch?"
        return
    end

    set -l cwd (pwd)
    set -l worktree (basename $cwd)

    # Partir en el primer `--`: <root>--<branch>
    set -l parts (string split -m1 -- '--' $worktree)
    if test (count $parts) -lt 2
        return
    end

    set -l root $parts[1]
    set -l branch $parts[2]

    # Protección contra borrar por accidente un directorio que no es un worktree
    cd "../$root"; or return 1
    git worktree remove $cwd --force; or return 1
    git branch -D $branch
end
