# Equivalente a /usr/share/omarchy/default/bash/envs.

# Editor usado por la CLI. Es una lista de dos elementos a propósito:
# $EDITOR expande a "omarchy-launch-editor --inline".
if not set -q EDITOR
    set -gx EDITOR omarchy-launch-editor --inline
end
set -gx SUDO_EDITOR $EDITOR

# Usado por programas de terminal (como gh) para abrir URLs desacopladas del
# árbol de procesos. Deliberadamente por sesión: exportar BROWSER a toda la
# sesión hace que xdg-settings se niegue a cambiar el navegador por defecto.
if not set -q BROWSER
    set -gx BROWSER omarchy-launch-browser
end
set -gx BAT_THEME ansi

# Páginas de manual coloreadas con bat
set -gx MANROFFOPT -c
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# /etc/profile.d/locale.sh es lo que mete /etc/locale.conf en el entorno, y
# sólo corre para shells de login. Un fish lanzado por SSH o por el puente
# remoto de herdr se pierde ese archivo y acaba en el locale C, donde printf
# emite \u/\U literalmente en vez del carácter. Replicamos locale.sh para esas
# sesiones.
if not set -q LANG; or test -z "$LANG"
    if test -r /etc/locale.conf
        for line in (string replace -r '#.*$' '' < /etc/locale.conf | string trim)
            set -l kv (string split -m1 = -- $line)
            test (count $kv) -eq 2; or continue
            string match -qr '^[A-Z][A-Z0-9_]*$' -- $kv[1]; or continue
            set -gx $kv[1] $kv[2]
        end
    end

    set -q LANG; or set -gx LANG C.UTF-8
end
