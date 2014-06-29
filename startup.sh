#!/bin/bash

echo "Starting soapower..."
cd /opt/soapower/current
export SOAPOWER_HOME="/opt/soapower"
export SOAPOWER_HTTP_PORT=9010

/usr/bin/supervisord