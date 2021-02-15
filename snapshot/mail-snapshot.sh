#!/bin/bash

mnt=/mnt/mail
maildir="$mnt/maildir"
exclude=".notmuch"
bucket="s3://timquelch-mail-archive"

cd $maildir || exit
template="$mnt/maildir-$1-$(date -Iminutes)-XXXXX.tar.gz"
afile="$(mktemp $template)"

echo "Creating maildir snapshot: $afile"
tar -czf "$afile" --exclude "$exclude" *

echo "Moving $1 snapshot to $bucket storage"
aws s3 mv "$afile" "$bucket" --no-progress

echo "Completed $1 snapshot"
