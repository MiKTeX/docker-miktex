#!/bin/sh

if [ -z "${MIKTEX_UID}" ]; then
    exec "$@"
else
    MIKTEX_GID=${MIKTEX_GID:-${MIKTEX_UID}}
    groupadd -g $MIKTEX_GID -o miktex
    useradd --shell /bin/bash -u $MIKTEX_UID -g $MIKTEX_GID -o -c "" -Md /miktex miktex
    if [ -d /miktex/.miktex ]; then
        chown -R miktex:miktex /miktex/.miktex
    fi
    exec gosu miktex "$@"
fi
