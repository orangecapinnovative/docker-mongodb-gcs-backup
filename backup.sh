#!/bin/sh

set -e

echo "Backup starting..."
. /root/container_env.sh

export BOTO_PATH=/root/config.boto

MONGODB_HOST=${MONGODB_HOST:-localhost}
MONGODB_PORT=${MONGODB_PORT:-27017}
BACKUP_DIR=${BACKUP_DIR:-/backup}

# Store the current date in YYYY-mm-DD-HHMMSS
DATE=$(date -u "+%F-%H%M%S")
ARCHIVE_NAME="backup-$DATE.tar.gz"

CMD_AUTH_PART=""

mkdir -p $BACKUP_DIR

if [[ ! -z $MONGODB_USER ]] && [[ ! -z $MONGODB_PASSWORD ]]
then
  CMD_AUTH_PART="--username=\"$MONGODB_USER\" --password=\"$MONGODB_PASSWORD\" "
fi

if [[ ! -z $MONGODB_DB ]]
then
  CMD_DB_PART="--db=\"$MONGODB_DB\" "
fi

if [[ $MONGODB_OPLOG = "true" ]]
then
  CMD_OPLOG_PART="--oplog "
fi

CMD="mongodump --host=\"$MONGODB_HOST\" --port=\"$MONGODB_PORT\" $CMD_AUTH_PART$CMD_DB_PART$CMD_OPLOG_PART--gzip --archive=$BACKUP_DIR/$ARCHIVE_NAME"

echo "Running command: $CMD"

eval "$CMD"

gsutil cp $BACKUP_DIR/$ARCHIVE_NAME "gs://$GCS_BUCKET"

rm $BACKUP_DIR/$ARCHIVE_NAME

echo "Backup done!"