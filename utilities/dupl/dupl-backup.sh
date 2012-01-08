#!/bin/bash
# #######################################
# # Cleanup after archival to re-claim disk space.
# # Usage: cleanup
# #######################################
function cleanup() 
{
    rm -rf "${BACKUP}"
}
