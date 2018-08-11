#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
SQL_SCRIPT_DIR=$SCRIPT_DIR/sql-scripts
VARIABLE_FILE="$SCRIPT_DIR/declare-variable.sh"
. $VARIABLE_FILE

#get script list to add
SQL_SCRIPT_ARRAY=($(ls "$SCRIPT_DIR/sql-scripts/"))
printf "\nSQL Scripts : \n"
echo "${SQL_SCRIPT_ARRAY[*]}"

if [ ! "$(docker ps -q -f name=$DOCKER_CONTAINER_NAME)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$DOCKER_CONTAINER_NAME)" ]; then
        # start container
        echo 'Container stopped, restarting it ...'
        docker start $DOCKER_CONTAINER_NAME
    else 
        # run container
        echo 'Container does not exist, initing it'
        docker run -d -p 3306:3306 --name $DOCKER_CONTAINER_NAME -v $HOST_SHARED_FOLDER:/var/lib/mysql -e MYSQL_DATABASE=$MYSQL_DATABASE -e MYSQL_ROOT_USER=$MYSQL_ROOT_USER -e MYSQL_ROOT_PASSWORD=$MYSQL_PASSWORD  -d $DOCKER_IMAGE_NAME
        echo "Initing DB with scripts"
        for i in "${SQL_SCRIPT_ARRAY[@]}"
        do
            : 
            SCRIPT_CONTENT=$(<$SQL_SCRIPT_DIR/$i)
            COMMAND="exec mysql -h'$DOCKER_IP' -P'$DOCKER_PORTS_EXPOSED' -u$MYSQL_USER -p$MYSQL_PASSWORD -e'$SCRIPT_CONTENT'"
            echo "COMMAND : $COMMAND"
            docker run -it --link $DOCKER_CONTAINER_NAME:mysql --rm mysql sh -c "$COMMAND"
            
        done
    fi
else
    echo "Container is already running"
fi