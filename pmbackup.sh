#!/bin/bash

# Backup Profile Manager on 10.7 Lion Server
# Matt Hansen - hansen.m@psu.edu
# Adapted from - http://sourcenetworks.posterous.com/lion-os-collaboration-services-manually-backi

# Restore from a pg_dump:
# psql -U _postgres -d device_management -c -f /path/to/backup/filename.sql

DATEFORMAT="+%m.%d.%Y-%H%M%S"
SCRIPT=`basename $0`
BKUPLOCATION=/Library/Server/PostgreSQL/Backup/
PGUSER=_postgres

echo "`date "$DATEFORMAT"` - "$SCRIPT" - Running"

# Run as root
if [ "$UID" -ne 0 ];then
        echo "`date "$DATEFORMAT"` - "$SCRIPT" - Not run as root!"
        exit 1
fi

# Stop Profile Manager
serveradmin stop devicemgr

sleep 1

# Start Postgres
serveradmin start postgres

sleep 1

# Backup Database
/usr/bin/pg_dump -U _postgres device_management -c -f ${BKUPLOCATION}device_management-`date "$DATEFORMAT"`.sql

sleep 1

# Start Profile Manager
serveradmin start devicemgr