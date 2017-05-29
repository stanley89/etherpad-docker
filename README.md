etherpad-docker
===============

This is a Docker image which is nothing more than the basic test Etherpad setup as described on https://github.com/ether/etherpad-lite. It is possible to use this image with sameersbn/mysql to provide mysql storage to etherpad:
(All of these instructions are as root.)

To build the image from github sources, run:

`docker build -t etherpad-docker github.com/stanley89/etherpad-docker`

In order to use image with mysql storage, use sameersbn/mysql image:

`docker pull sameersbn/mysql`

`docker run -d --name etherpad-mysql --restart=always -v /var/lib/docker/data/etherpad/mysql/:/var/lib/mysql -e 'DB_NAME=etherpad' -e 'DB_USER=etherpad' -e 'DB_PASS=xxx' sameersbn/mysql:latest`

To run Etherpad linked with mysql on port 9001, run:

`docker run -d --name etherpad --restart=always -p 9001:9001 -e 'ETHERPAD_TITLE=My Pad' --link etherpad-mysql:mysql etherpad-docker`

To run Etherpad on port 9001 with external mysql, use:

`docker run -d --name etherpad --restart=always -p 9001:9001 -e 'ETHERPAD_TITLE=My Pad' -e 'MYSQL_ENV_DB_USER=user' -e 'MYSQL_PORT_3306_TCP_ADDR=host' -e 'MYSQL_ENV_DB_PASS=password' -e 'MYSQL_ENV_DB_NAME=dbname' etherpad-docker`

