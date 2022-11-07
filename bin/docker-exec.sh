#!/bin/sh

#Exit script on failure of any command
set -e

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

errorMsg=$(
    echo $RED"[  ERROR]"$NC
)

infoMsg=$(
    echo ${BOLD}"[   INFO]"${NORMAL}
)

warningMsg=$(
    echo $YELLOW"[WARNING]"$NC
    )

successMsg=$(
    echo $GREEN"[SUCCESS]"$NC
)

checkContainers=$(
    docker container ls | grep $DOCKER_IMAGE_NAME
)

VERBOSE_TAG_1=$infoMsg
VERBOSE_TAG_2=$errorMsg
VERBOSE_TAG_3=$warningMsg
VERBOSE_TAG_4=$successMsg
DOCKER_CONTAINER_NAME=$2
POSTGRES_USERNAME=$3


postgresConnect=$(
    docker exec -it -u ${POSTGRES_USERNAME} ${DOCKER_CONTAINER_NAME} psql 
)
bashConnect=$(
    docker exec -it $DOCKER_CONTAINER_NAME bash
)

#mysqlConnect=$(
#)

if [[ -z $2 ]]; then
    echo "$VERBOSE_TAG_3 ${NORMAL} Please provide the container name to exec into..."
    echo "$VERBOSE_TAG_1 ${NORMAL} For a full list of running containers run docker ps"

elif [[ $DOCKER_IMAGE_NAME == *'postgres'* ]]; then

    echo "$VERBOSE_TAG_3 ${NORMAL} Please provide the postgres username to connect with"
    $postgresConnect

else
    
    echo "$VERBOSE_TAG_1 ${NORMAL} Connecting to docker service... $DOCKER_CONTAINER_NAME"
    $bashConnect
fi    


