#!/bin/sh
set -e

cp -R /tmp/.ssh /var/mail/.ssh
chown -R mail:mail /var/mail/.ssh
chmod 700 /var/mail/.ssh
chmod 600 /var/mail/.ssh/authorized_keys

exec "$@"
