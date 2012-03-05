#!/bin/bash
########################################
## Sends the Archives to a S3 using Duplicity.
## Dependencies:
##   * duplicity
##   * python-boto
## Usage: archive_s3 <bucket>
##
## Required Variables:
##   * PASSPHRASE
##   * AWS_ACCESS_KEY_ID
##   * AWS_SECRET_ACCESS_KEY
########################################
archive_s3 () 
{
    if [ -z "$1" ]; then
        echo "No s3 bucket provided."
    else
        local bucket="$1"
        duplicity "${BACKUP}" "s3+http://${bucket}"
    fi
}

########################################
## Retrieves the Archives from S3 using Duplicity.
## Dependencies:
##   * duplicity
##   * python-bo
## Usage: retrieve_s3 <bucket>
##
## Required Variables:
##   * PASSPHRASE
##   * AWS_ACCESS_KEY_ID
##   * AWS_SECRET_ACCESS_KEY
########################################
retrieve_s3 () 
{
    echo "Retrieval functionality has not been implemented."
}
