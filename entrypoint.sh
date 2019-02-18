#!/bin/sh

MIKTEX_GID=${MIKTEX_GID:-1001}
MIKTEX_UID=${MIKTEX_UID:-1001}

groupadd -g $MIKTEX_GID -o miktex
useradd --shell /bin/bash -u $MIKTEX_UID -g $MIKTEX_GID -o -c "" -Md /miktex miktex

chown -R miktex:miktex /miktex

exec gosu miktex "$@"
