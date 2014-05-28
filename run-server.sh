#!/bin/sh

docker run -i -d  -p 49010:9010 -p 49011:29017 -p 49012:22 --privileged -t -v /data/soapower/mongodb:/data/db soapower/soapower
