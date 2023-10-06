#!/bin/bash

MIKTEX_UID=${MIKTEX_UID:-1000}
MIKTEX_GID=${MIKTEX_GID:-${MIKTEX_UID}}
if [ "$(id -u miktex)" != 1000 ]; then
    usermod -u ${MIKTEX_UID} miktex >/dev/null
    groupmod -g ${MIKTEX_GID} miktex
    chown -R miktex:miktex /var/lib/miktex
fi
exec gosu miktex "$@"
