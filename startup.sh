#!/bin/bash
if [ ! -f /.db_created ]; then
	/create_db.sh
	touch /.db_created
fi

echo "Starting soapower..."
cd /opt/soapower/current
export SOAPOWER_HOME="/opt/soapower"
export SOAPOWER_HTTP_PORT=9010
export SOAPOWER_DB_URL="jdbc:mysql://127.0.0.1:3306/soapower"
export SOAPOWER_DB_USER="soapower"
export SOAPOWER_DB_PASSWORD="soapower"

chmod +x soapowerctl.sh
/usr/bin/supervisord