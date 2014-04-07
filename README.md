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

Go to http://localhost.local:9010

Docker HTTP listen on 9010, mysql listen on 9011, ssh listen on 9012

Mysql files are written on `/data/mysql` (described in run-server.sh)
