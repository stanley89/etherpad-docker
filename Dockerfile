# Etherpad-Lite Dockerfile
#
# https://github.com/ether/etherpad-docker
#
# Developed from a version by Evan Hazlett at https://github.com/arcus-io/docker-etherpad 
# bmanojlovic - developed from pieces all over github...
#
# Version 1.0

FROM node:latest
MAINTAINER stanley89

# Get Etherpad-lite's other dependencies
RUN apt-get update && apt-get install -y gzip git-core curl python libssl-dev pkg-config build-essential supervisor && \
    apt-get clean && apt-get autoclean 

# Grab the latest Git version
RUN cd /opt && git clone https://github.com/ether/etherpad-lite.git etherpad

# Install node dependencies and plugins
RUN cd /opt/etherpad/ && ./bin/installDeps.sh

# Add conf files
ADD supervisor.conf /etc/supervisor/supervisor.conf
ADD start.sh /
RUN chmod +x start.sh

EXPOSE 9001
CMD ./start.sh
