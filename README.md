Use Soapower with Docker
======

Run Soapower 2.1.4 with container on index.docker.io
----
```
docker run -i -d -p 49010:9010 -p 49011:27017 -p 49012:22 --privileged -t -v /data/soapower/mongodb:/data/db -v /data/soapower/backups:/opt/soapower/backups yesnault/docker-soapower:215
```

Run Soapower 2.1.4 with your own newly built container
-----------
```
git clone https://github.com/soapower/docker.git

./build.sh
./run-server.sh
````

Go to http://localhost.local:49010

Docker HTTP listen on 49010, mongodb listen on 49011, ssh listen on 49012

MongoDB files are written on `/data/mongodb` (described in run-server.sh)
