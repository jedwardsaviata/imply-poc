#!/bin/bash
DOCKER_COMPOSE=`which docker-compose`
if [[ $? -ne 0 ]]; then
  echo "Please install docker-compose (https://docs.docker.com/compose/install/)"
  exit 1
fi

$DOCKER_COMPOSE kill
$DOCKER_COMPOSE rm
