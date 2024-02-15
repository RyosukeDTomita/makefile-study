FROM ubuntu:22.04 as build
WORKDIR /usr/local/app
RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends make
apt-get install -y --no-install-recommends g++
rm -rf /var/lib/apt/lists/*
EOF
