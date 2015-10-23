#!/bin/bash

WD=`pwd`

DOCKER_COMPOSE=`which docker-compose`
if [[ $? -ne 0 ]]; then
  echo "Please install docker-compose (https://docs.docker.com/compose/install/)"
  exit 1
fi

cd services
$DOCKER_COMPOSE up -d
cd $WD

./prepare-dbs.sh

