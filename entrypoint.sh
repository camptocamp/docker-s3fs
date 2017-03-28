#!/bin/bash

trap "umount /home/shared/s3" SIGKILL SIGTERM SIGHUP SIGINT EXIT

mount --make-shared /home/shared/s3

mkdir -p /home/shared/s3
mkdir -p /tmp
s3fs $BUCKETNAME /home/shared/s3 -o use_cache=/tmp -o allow_other -o umask=0002 -o use_rrs -f &

wait
sleep 2
