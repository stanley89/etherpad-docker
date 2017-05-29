# Etherpad-Lite Dockerfile
#
# https://github.com/ether/etherpad-docker
#
# Developed from a version by Evan Hazlett at https://github.com/arcus-io/docker-etherpad 
# bmanojlovic - developed from pieces all over github...
#
# Version 1.0

# Use Docker's nodejs, which is based on ubuntu
FROM node:latest
MAINTAINER John E. Arnold, iohannes.eduardus.arnold@gmail.com

# Get Etherpad-lite's other dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  gzip \
  git-core \
  libssl-dev \
  pkg-config \
  python \
  supervisor \
  
  && rm -rf /var/lib/apt/lists/*

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
