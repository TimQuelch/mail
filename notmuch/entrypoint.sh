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

# Create post-new hook if it doesn't exist
if [ ! -f /var/mail/maildir/.notmuch/post-new ]; then
    cat <<EOF > /var/mail/maildir/.notmuch/post-new
if [ -f /bin/notmuch-post-new ]; then
   /bin/notmuch-post-new
fi
EOF
    chown mail:mail /var/mail/maildir/.notmuch/post-new
    chmod +x /var/mail/maildir/.notmuch/post-new
fi

exec "$@"
