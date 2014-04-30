Use Soapower with Docker
======

Run Soapower 1.4.0 with container on index.docker.io
----
```
docker run -i -d -p 49010:9010 -p 49011:3306 -p 49012:22 --privileged -t -v /data/soapower/mysql:/var/lib/mysql yesnault/docker-soapower:140
```

Run Soapower 1.4.0 with your own newly built container
-----------
```
git clone https://github.com/soapower/docker.git

./build.sh
./run-server.sh
````

Go to http://localhost.local:49010

Docker HTTP listen on 49010, mysql listen on 49011, ssh listen on 49012

Mysql files are written on `/data/mysql` (described in run-server.sh)
