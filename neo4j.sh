#!/bin/bash

chown neo4j:neo4j /data
chown neo4j:neo4j /neo4j/data
chown neo4j:neo4j /neo4j/conf
chmod 0755 /data

exec /sbin/setuser neo4j /neo4j/bin/neo4j console

