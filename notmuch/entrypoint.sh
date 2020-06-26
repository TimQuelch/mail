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
hookdir=/var/mail/maildir/.notmuch/hooks
if [ ! -f ${hookdir}/post-new ]; then
    mkdir -p $hookdir
    cat <<EOF > ${hookdir}/post-new
#!/bin/sh
if [ -f /bin/notmuch-post-new ]; then
   /bin/notmuch-post-new
fi
EOF
    chown mail:mail ${hookdir}/post-new
    chmod +x ${hookdir}/post-new
fi

exec "$@"
