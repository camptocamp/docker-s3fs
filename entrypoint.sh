#!/bin/bash

SHARED_DIR="/home/shared/s3"
TMPDIR="/tmp"

trap "umount ${SHARED_DIR}" SIGKILL SIGTERM SIGHUP SIGINT EXIT

mount --make-shared $SHARED_DIR
mkdir -p $TMPDIR
OPTS="-o use_cache=${TMPDIR} -o allow_other -o umask=022 -o use_rrs -f"

if ! test -z "$S3FS_GID"; then
  groupadd -g $S3FS_GID s3fs
  OPTS="${OPTS} -o gid=${S3FS_GID}"
fi

if ! test -z "$S3FS_UID"; then
  useradd -u $S3FS_UID s3fs
  OPTS="${OPTS} -o uid=${S3FS_UID}"
fi

if ! test -z "$S3FS_URL"; then
  OPTS="${OPTS} -o url=${S3FS_URL}"
fi

if ! test -z "$DEBUG_LEVEL"; then
  OPTS="${OPTS} -o dbglevel=${DEBUG_LEVEL}"
fi

s3fs $BUCKETNAME $SHARED_DIR $OPTS $EXTRA_OPTS &

wait
sleep 2
