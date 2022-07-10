#!/bin/sh

FILE=`date +"%Y-%m-%d-%H_%M"`${FILE_SUFFIX}
OUTPUT_FILE=${BACKUP_DIR}/${FILE}

mkdir -p ${BACKUP_DIR}
mkdir -p /temp/last-backup

rsync -ravp --progress --stats -e "ssh -oStrictHostKeyChecking=no -o ExitOnForwardFailure=yes -p $SSH_PORT -i id_rsa" "$SSH_USERNAME@$SSH_HOST:$REMOTE_SOURCE_PATH/" /temp/last-backup --delete

tar -cvpzf "${OUTPUT_FILE}.tar.gz" -C /temp/last-backup .

echo "${OUTPUT_FILE}.tar.gz was created:"
ls -l ${OUTPUT_FILE}.tar.gz

find $BACKUP_DIR -maxdepth 1 -mtime +$DAYS_TO_KEEP -name "*${FILE_SUFFIX}.tar.gz" -exec rm -rf '{}' ';'
