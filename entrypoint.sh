#!/bin/bash

trap "umount /home/shared/s3" SIGKILL SIGTERM SIGHUP SIGINT EXIT

mount --make-shared /home/shared/s3

mkdir -p /home/shared/s3
mkdir -p /tmp

if test -n $GID; then
  groupadd -g $GID s3fs
  GID_OPT="-o gid=${GID}"
fi

if test -n $UID; then
  useradd -u $UID s3fs
  UID_OPT="-o uid=${UID}"
fi

s3fs $BUCKETNAME /home/shared/s3 -o use_cache=/tmp \
  $GID_OPT $UID_OPT \
  -o allow_other -o umask=022 -o use_rrs -f &

wait
sleep 2
