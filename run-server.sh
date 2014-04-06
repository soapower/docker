#!/bin/sh

docker run -i -d  -p 9010:9010 -p 9011:3306 -p 9012:22 --privileged -t -v /data/soapower/mysql:/var/lib/mysql soapower/soapower