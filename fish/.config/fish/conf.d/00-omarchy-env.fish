# Equivalente a /usr/share/omarchy/default/bash/env-bootstrap.
#
# fish no puede sourcear archivos bash, así que de /etc/omarchy.conf (escrito
# por omarchy-dev-link y reseteado por omarchy-dev-unlink) sólo se extrae
# OMARCHY_PATH. Cuando el archivo no existe se fuerza el valor empaquetado en
# vez de conservar uno heredado obsoleto.

set -gx OMARCHY_PATH /usr/share/omarchy

if test -f /etc/omarchy.conf
    for line in (string replace -r '#.*$' '' < /etc/omarchy.conf | string trim)
        test -n "$line"; or continue
        string match -qr '^(?:export\s+)?OMARCHY_PATH=' -- $line; or continue

        set -l value (string replace -r '^(?:export\s+)?OMARCHY_PATH=' '' -- $line)
        set value (string trim --chars='"\'' -- $value)
        test -n "$value"; and set -gx OMARCHY_PATH $value
        break
    end
end

# Sólo se antepone en modo dev-link. En una instalación de producción los
# binarios ya están en /usr/bin/omarchy-* vía el paquete omarchy; anteponer
# /usr/share/omarchy/bin sería sólo ruido.
if test "$OMARCHY_PATH" != /usr/share/omarchy
    contains -- $OMARCHY_PATH/bin $PATH
    or set -gx PATH $OMARCHY_PATH/bin $PATH
end

# Los wrappers de mise deben preceder a los directorios reales de herramientas
# heredados de un shell padre, para que los scripts sigan los cambios de cuenta
# sin funciones. `mise activate` también mantiene este directorio delante de
# sus binarios gestionados.
set -l data_dir $XDG_DATA_HOME
test -n "$data_dir"; or set data_dir $HOME/.local/share
set -l wrapper_dir $data_dir/mise/command-wrappers/bin
test -n "$MISE_DATA_DIR"; and set wrapper_dir $MISE_DATA_DIR/command-wrappers/bin

contains -- $wrapper_dir $PATH
or set -gx PATH $wrapper_dir $PATH

# Rutas de herramientas de usuario al final, para que los binarios del sistema
# mantengan la precedencia. Esto es lo que permite que los shells de login
# (ssh, fish -lc) y la sesión de uwsm encuentren las herramientas de mise sin un
# rc interactivo. Mantener en sincronía con la línea de PATH de PAM de
# install/config/ssh-command-path.sh, que cubre comandos SSH que no ejecutan
# ningún setup de shell.
for dir in $HOME/.local/share/mise/shims $HOME/.local/bin
    contains -- $dir $PATH
    or set -gx PATH $PATH $dir
end
