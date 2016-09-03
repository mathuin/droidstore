#!/bin/bash
IMAGE=mathuin/droidstore
rm -rf localhost
docker rm -f site-data site-server
docker build -t $IMAGE .
docker run -d -v /usr/share/nginx/html --name site-data $IMAGE
docker run -d --volumes-from site-data --name site-server -p 80:80 nginx
curl -s -D - http://localhost -o /dev/null | grep "200 OK"
curl -s -D - http://localhost | grep "Welcome"
wget --spider -e robots=off -r -p http://localhost
