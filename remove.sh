#!/bin/bash

WD=`pwd`

DOCKER_COMPOSE=`which docker-compose`
if [[ $? -ne 0 ]]; then
  echo "Please install docker-compose (https://docs.docker.com/compose/install/)"
  exit 1
fi

cd panoramix
$DOCKER_COMPOSE kill
$DOCKER_COMPOSE rm
cd $WD

cd druid
$DOCKER_COMPOSE kill
$DOCKER_COMPOSE rm
cd $WD

cd services
$DOCKER_COMPOSE kill
$DOCKER_COMPOSE rm
cd $WD

