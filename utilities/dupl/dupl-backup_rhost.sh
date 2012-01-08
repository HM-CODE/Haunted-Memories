#!/bin/bash
########################################
## Prepares an installation of RhostMUSH for backup.
## Usage: backup_rhost <environment>
########################################
backup_rhost () 
{
    if [ -z "$1" ]; then
        local game="live"
    else
        local game="$1"
    fi

    # TODO:2012-01-08:Kevin Kragenbrink:The ${path} variable is too dependent on HM's file structure.
    # This should be a config setting in the main file.
    local path="${HOME}/rhost/${game}"
    local backup="${BACKUP}/game/${game}"

    if [ -d "${path}" ]; then
        mkdir -p "${backup}"
        # TODO:2012-01-08:Kevin Kragenbrink:The tarball referenced below requires too much work to set up.
        # This should be a configuration setting, instead, and the subsequent restore script should automatically
        # tar up the necessary portions of RhostMUSH.
        cp "${path}/rhost.tar.bz2" "${backup}"
        cp "${path}/Server/game/netrhost.conf" "${backup}"
        cp "${path}/Server/game/netrhost.log" "${backup}"
        cp -R "${path}/Server/game/roomlogs" "${backup}"
        for file in $(find "${path}/Server/game/" -type f -name *.flat); do 
            cp "${file}" "${backup}"
        done
        for file in $(find "${path}/Server/game" -type f -name RhostMUSH.dump.*); do
            cp "${file}" "${backup}"
        done
        cp -R "${path}/Server/game/txt" "${backup}"
        cp "${path}/Server/src/Makefile" "${backup}"
    else
        echo "Unable to locate game \"${game}\" for backup."
    fi
}

########################################
## Restores an installation of RhostMUSH from backup.
## Usage: restore_rhost <environment>
########################################
restore_rhost ()
{
    echo "Restore functionality has not been implemented."
}
