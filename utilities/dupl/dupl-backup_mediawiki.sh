#!/bin/bash
########################################
## Prepares a specific Mediawiki installation for backup.
## Usage: backup_mediawiki <name>
########################################
# TODO:2012-01-08:Kevin Kragenbrink:Possibly allow for automatic database backup using $2 (type) and $3 (dbname).
# MediaWiki relies on a Database, and some users might intelligently separate out their various DBs; in those 
# instances, it would be best to bundle the database with the SMF installation and allow the user to specify the 
# database in the function call.
backup_mediawiki () 
{
    if [ -z "$1" ]; then
        local wiki="wiki"
    else
        local wiki="$1"
    fi

    # TODO:2012-01-08:Kevin Kragenbrink:The ${path} variable is too dependent on HM's file structure.
    # This should be a config setting in the main file.
    local path="${HOME}/haunted-memories.net/${wiki}"
    local backup="${BACKUP}/wiki/${wiki}"

    if [ -d "${path}" ]; then
        mkdir -p "${backup}"
        # TODO:2012-01-08:Kevin Kragenbrink:The tarball referenced below requires too much work to set up.
        # This should be a configuration setting, instead, and the subsequent restore script should automatically
        # pull the latest security patch of that version from the MW archives.
        cp "${path}/mediawiki.tar.bz2" "${backup}"
        cp "${path}/LocalSettings.php" "${backup}"
        cp -R "${path}/extensions/" "${backup}"
        cp -R "${path}/images/" "${backup}"
        rm -rf "${backup}/images/archive"
        rm -rf "${backup}/images/deleted"
        rm -rf "${backup}/images/temp"
        rm -rf "${backup}/images/thumb"
    else
        echo "Unable to locate wiki \"${wiki}\" for backup."
    fi
}


########################################
## Restores a specific Mediawiki installation from backup.
## Usage: restore_mediawiki <name>
########################################
restore_mediawiki() 
{
    echo "Restore functionality has not been implemented.."
}
