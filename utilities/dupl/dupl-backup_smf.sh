#!/bin/bash
########################################
## Prepares a specific SMF forum for backup.
## Usage: backup_smf <forum> [<dbtype> <dbname>]
########################################
# TODO:2012-01-08:Kevin Kragenbrink:Possibly allow for automatic database backup using $2 (type) and $3 (dbname).
# SMF relies on a Database, and some users might intelligently separate out their various DBs; in those instances, 
# it would be best to bundle the database with the SMF installation and allow the user to specify the database in
# the function call.
backup_smf () 
{
    if [ -z "$1" ]; then
        local forum="forum"
    else
        local forum="$1"
    fi

    # TODO:2012-01-08:Kevin Kragenbrink:The ${path} variable is too dependent on HM's file structure.
    # This should be a config setting in the main file.
    local path="${HOME}/haunted-memories.net/${forum}"
    local backup="${BACKUP}/forum/${forum}"

    if [ -d "${path}" ]; then
        mkdir -p "${backup}"
        # TODO:2012-01-08:Kevin Kragenbrink:The tarball referenced below requires too much work to set up.
        # This should be a configuration setting, instead, and the subsequent restore script should automatically
        # tar up the necessary portions of RhostMUSH.
        cp "${path}/smf.tar.bz2" "${backup}"
        cp "${path}/Settings.php" "${backup}"
    else
        echo "Unable to locate forum \"${forum}\" for backup."
    fi  
}

########################################
## Restores an SMF forum from backup.
## Usage: restore_smf <forum> [<dbtype> <dbname>]
########################################
restore_smf ()
{
    echo "Restore functionality has not been implemented."
}
