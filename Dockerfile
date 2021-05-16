FROM ubuntu:16.04

MAINTAINER Couchbase Docker Team <docker@couchbase.com>

# Install dependencies:
#  runit: for container process management
#  wget: for downloading .deb
#  chrpath: for fixing curl, below
#  tzdata: timezone info used by some N1QL functions
# Additional dependencies for system commands used by cbcollect_info:
#  lsof: lsof
#  lshw: lshw
#  sysstat: iostat, sar, mpstat
#  net-tools: ifconfig, arp, netstat
#  numactl: numactl
RUN apt-get update && \
    apt-get install -yq runit wget chrpath tzdata \
    lsof lshw sysstat net-tools numactl python-httplib2 && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG CB_VERSION=5.5.0
ARG CB_RELEASE_URL=https://packages.couchbase.com/releases/5.5.0
ARG CB_PACKAGE=couchbase-server-enterprise_5.5.0-ubuntu16.04_amd64.deb
ARG CB_SHA256=9eb499e953451e0675d4a3d04cee40b654d3d548d54f1fdece97c2a192f7d778

ENV PATH=$PATH:/opt/couchbase/bin:/opt/couchbase/bin/tools:/opt/couchbase/bin/install

# Create Couchbase user with UID 1000 (necessary to match default
# boot2docker UID)
RUN groupadd -g 1000 couchbase && useradd couchbase -u 1000 -g couchbase -M

# Install couchbase
RUN export INSTALL_DONT_START_SERVER=1 && \
    wget -N --no-verbose $CB_RELEASE_URL/$CB_PACKAGE && \
    echo "$CB_SHA256  $CB_PACKAGE" | sha256sum -c - && \
    dpkg -i ./$CB_PACKAGE && rm -f ./$CB_PACKAGE


EXPOSE 8091 8092 8093 8094 8095 8096 11207 11210 11211 18091 18092 18093 18094 18095 18096
VOLUME /opt/couchbase/var