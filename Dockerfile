FROM phusion/baseimage:0.9.19

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN \
  add-apt-repository ppa:openjdk-r/ppa && \
  apt-get update && apt-get install -y \
  openjdk-8-jdk \
  wget

RUN rm -rf /var/lib/apt/lists/*

ENV NEO4J_VERSION 3.0.4

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
VOLUME ["/neo4j/logs"]

RUN mkdir -p /etc/service/neo4j
ADD neo4j.sh /etc/service/neo4j/run

ADD neo4j.toml /etc/confd/conf.d/neo4j.toml
ADD neo4j.conf.tmpl /etc/confd/templates/neo4j.conf.tmpl
ADD neo4j-wrapper.toml /etc/confd/conf.d/neo4j-wrapper.toml
ADD neo4j-wrapper.conf.tmpl /etc/confd/templates/neo4j-wrapper.conf.tmpl

EXPOSE 1337 7473 7474 7687

CMD ["/sbin/my_init", "--quiet"]
