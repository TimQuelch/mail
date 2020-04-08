#!/bin/sh
set -e

# Generate ssh hostkeys
ssh-keygen -A

# Copy mounted ssh dir to userdir so we can access
if [ -d /tmp/.ssh ]; then
    cp -R /tmp/.ssh /var/mail/.ssh
    chown -R mail:mail /var/mail/.ssh
    chmod 700 /var/mail/.ssh
    chmod 600 /var/mail/.ssh/authorized_keys
fi

exec "$@"
