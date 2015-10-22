#!/bin/bash

WD=`pwd`

DOCKER_COMPOSE=`which docker-compose`
if [[ $? -ne 0 ]]; then
  echo "Please install docker-compose (https://docs.docker.com/compose/install/)"
  exit 1
fi

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

cd services
$DOCKER_COMPOSE up -d
cd $WD

PG_IP=`docker inspect --format="{{ .NetworkSettings.IPAddress }}" imply-poc-postgresql`
CASS_IP=`docker inspect --format="{{ .NetworkSettings.IPAddress }}" imply-poc-cassandra`

$WAIT4PG --host=$PG_IP --username=postgres --password=postgres 
$WAIT4CASS --host=$CASS_IP

cd druid
$DOCKER_COMPOSE up -d
cd $WD

cd panoramix
$DOCKER_COMPOSE up -d
cd $WD

