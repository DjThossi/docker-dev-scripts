#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/../colors.sh

PROJECT_NAME=$1

cd ${CUR_DIR}/../../apps/${PROJECT_NAME}

if [[ -r ./docker-compose.yml ]] ; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Stopping${NO_COLOR}"
    docker-compose stop
else
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Skipped stopping. No docker-compose.yml found${NO_COLOR}"
fi

cd ${CUR_DIR}
