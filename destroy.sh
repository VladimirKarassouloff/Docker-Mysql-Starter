#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"

VARIABLE_FILE="$SCRIPT_DIR/declare-variable.sh"
. $VARIABLE_FILE

if [ "$(docker ps -aq -f name=$DOCKER_CONTAINER_NAME)" ]; then
	docker rm -f $DOCKER_CONTAINER_NAME
else
	echo 'Nothing to do, container does not exist'
fi
