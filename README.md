Use Soapower with Docker
======

Run
----
```
docker run yesnault/docker-soapower:132
```

Build and Run
-----------
```
git clone https://github.com/soapower/docker.git

./build.sh
./run-server.sh
````

Go to http://localhost.local:49010

Docker HTTP listen on 49010, mysql listen on 49011, ssh listen on 49012

Mysql files are written on `/data/mysql` (described in run-server.sh)
