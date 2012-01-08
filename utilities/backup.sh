#!/bin/bash
BASEDIR="$(pwd)/$(dirname $0)"
PATH="${PATH}:${BASEDIR}/dupl"
BACKUP="${HOME}/backup"

# Require the basic script.
source "dupl-backup.sh"

# Reqire additional scripts as needed.
source "dupl-backup_rhost.sh"
source "dupl-backup_mediawiki.sh"
source "dupl-backup_smf.sh"
source "dupl-backup_mysql.sh"
source "dupl-archive_s3.sh"

# Configure any variables required by your scripts.
export MYSQL_USERNAME=""
export MYSQL_PASSWORD=""
export MYSQL_HOSTNAME=""
export PASSPHRASE=""
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

# Define the backup preparations in order of operations.
backup_rhost live
backup_mediawiki wiki
backup_smf forum
backup_mysql vienna_live

# Call your archival function
archive_s3 writh-backups/haunted-memories

# Run cleanup
cleanup
