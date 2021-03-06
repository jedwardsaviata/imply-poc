#!/bin/bash

./run-services.sh

WD=`pwd`

DOCKER_COMPOSE=`which docker-compose`
if [[ $? -ne 0 ]]; then
  echo "Please install docker-compose (https://docs.docker.com/compose/install/)"
  exit 1
fi

cd druid
$DOCKER_COMPOSE up -d
cd $WD

cd panoramix
$DOCKER_COMPOSE up -d
cd $WD

