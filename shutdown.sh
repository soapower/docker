#!/bin/sh

ID=`docker ps | grep soapower/soapower | cut -d " " -f1`
NAME=`docker ps | grep soapower/soapower | cut -d " " -f9` 
echo " Kill ${NAME} : ${ID}"
docker kill ${ID}
