#!/bin/bash

WAIT4PG=`which wait-for-postgres`
if [[ $? -ne 0 ]]; then
  echo "Please install wait-for-postgres (npm install -g wait-for-postgres)"
  exit 1
fi

WAIT4CASS=`which wait-for-cassandra`
if [[ $? -ne 0 ]]; then
  echo "Please install wait-for-cassandra (npm install -g wait-for-cassandra)"
  exit 1
fi

PG_IP=`docker inspect --format="{{ .NetworkSettings.IPAddress }}" imply-poc-postgresql`
CASS_IP=`docker inspect --format="{{ .NetworkSettings.IPAddress }}" imply-poc-cassandra`

$WAIT4PG --host=$PG_IP --username=postgres --password=postgres 
docker cp ./postgres.sql imply-poc-postgresql:/postgres.sql
docker exec imply-poc-postgresql psql -U postgres -a -f /postgres.sql

$WAIT4CASS --host=$CASS_IP
docker cp ./cassandra.cql imply-poc-cassandra:/cassandra.cql
docker exec imply-poc-cassandra cqlsh -f /cassandra.cql

