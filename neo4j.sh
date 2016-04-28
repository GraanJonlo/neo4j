#!/bin/bash
/usr/local/bin/confd -onetime -backend env

mkdir -p /neo4j/certificates

chown neo4j:neo4j /data
chown neo4j:neo4j /neo4j/data
chown neo4j:neo4j /neo4j/conf
chown neo4j:neo4j /neo4j/certificates
chown neo4j:neo4j /neo4j/logs

chmod 0755 /data

exec /sbin/setuser neo4j /neo4j/bin/neo4j console