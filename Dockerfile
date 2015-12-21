FROM phusion/baseimage:0.9.18

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

RUN \
  add-apt-repository ppa:openjdk-r/ppa && \
  apt-get update && apt-get upgrade -y && apt-get install -y \
  openjdk-8-jdk \
  wget

ENV NEO4J_VERSION 2.3.1

RUN \
  cd /tmp && \
  wget -O neo4j.tar.gz http://neo4j.com/artifact.php?name=neo4j-community-$NEO4J_VERSION-unix.tar.gz && \
  tar xvzf neo4j.tar.gz && \
  mv neo4j-community-$NEO4J_VERSION /neo4j && \
  groupadd neo4j && \
  useradd -g neo4j neo4j && \
  rm -rf /tmp/*

WORKDIR /neo4j

VOLUME ["/data"]

RUN mkdir -p /etc/service/neo4j
ADD neo4j.sh /etc/service/neo4j/run
ADD neo4j-server.properties /neo4j/conf/neo4j-server.properties
ADD neo4j.properties /neo4j/conf/neo4j.properties

EXPOSE 7474
EXPOSE 1337

CMD ["/sbin/my_init", "--quiet"]

