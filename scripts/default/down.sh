#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/../colors.sh

PROJECT_NAME=$1

cd ${CUR_DIR}/../../apps/${PROJECT_NAME}

if [[ -r ./docker-compose.yml ]] ; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Shutting down${NO_COLOR}"
    docker-compose down --rmi all
else
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Skipped downing. No docker-compose.yml found${NO_COLOR}"
fi

cd ${CUR_DIR}
