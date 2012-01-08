#!/bin/bash
########################################
## Prepares a MySQL database for backup.
## Dependencies:
##   * mysqldump
## Usage: backup_mysql <database>
##
## Required Variables:
##   * MYSQL_USERNAME
##   * MYSQL_PASSWORD
##   * MYSQL_HOSTNAME
########################################
backup_mysql () 
{
    if [ -z "$1" ]; then
        echo "No MySQL database specified to backup."
    else
        local database="$1"
        local backup="${BACKUP}/sql"
        
        mkdir -p "${backup}"
        mysqldump -u"${MYSQL_USERNAME}" -p"${MYSQL_PASSWORD}" -h"${MYSQL_HOSTNAME}" "${database}" > "${backup}/${database}.sql"
    fi
}

########################################
## Restores a MySQL database from backup.
## Dependencies:
##   * mysql
## Usage: restore_mysql <database>
##
## Required Variables:
##   * MYSQL_USERNAME
##   * MYSQL_PASSWORD
##   * MYSQL_HOSTNAME
########################################
restore_mysql ()
{
    echo "Restore functionality has not been implemented."
}
