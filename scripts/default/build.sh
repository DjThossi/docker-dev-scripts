#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/../colors.sh
PROJECT_NAME=$1

cd ${CUR_DIR}/../../apps/${PROJECT_NAME}

if [[ -r ./docker-compose.yml ]] ; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Building${NO_COLOR}"

    NO_CACHE_VALUE=""
    if [[ "$@" =~ "--no-cache" ]] ; then
        echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Without Cache${NO_COLOR}"
        NO_CACHE_VALUE="--no-cache"
    fi

    docker-compose build ${NO_CACHE_VALUE}
else
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Skipped building. No docker-compose.yml found${NO_COLOR}"
fi

cd ${CUR_DIR}
