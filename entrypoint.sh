#!/bin/sh

if [ -z "${MIKTEX_UID}" ]; then
    exec "$@"
else
    MIKTEX_GID=${MIKTEX_GID:-${MIKTEX_UID}}
    groupadd -g $MIKTEX_GID -o miktex
    useradd --shell /bin/bash -u $MIKTEX_UID -g $MIKTEX_GID -o -c "" -Md /miktex miktex
    mkdir -p /miktex/.miktex
    chown -R miktex:miktex /miktex/.miktex
    exec gosu miktex "$@"
fi
