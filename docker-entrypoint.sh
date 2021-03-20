#!/bin/bash

set -eu

AUTHORIZED_KEYS_DIR="/authorized_keys"

# list authorized_keys
for pubkeypath in "${AUTHORIZED_KEYS_DIR}"/*; do
    username="$(basename "${pubkeypath}")"

    useradd \
        --shell "/usr/sbin/nologin" \
        --no-create-home "${username}"

    mkdir -p "/home/${username}/.ssh" -m 700
    cp "${AUTHORIZED_KEYS_DIR%/}/${username}" "/home/${username}/.ssh/authorized_keys"
    chown -R "${username}:${username}" "/home/${username}"
    chmod 600 "/home/${username}/.ssh/authorized_keys"
    
    echo "user added: ${username}"
done

/usr/sbin/sshd -D -E /sshd_log/auth.log

