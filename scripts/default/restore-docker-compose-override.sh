#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
PROJECT_NAME=$1
DOCKER_COMPOSE_OVERRIDE_FINAL_PLACE=${CUR_DIR}/../../apps/${PROJECT_NAME}/docker-compose.override.yml
DOCKER_COMPOSE_FINAL_PLACE=${CUR_DIR}/../../apps/${PROJECT_NAME}/docker-compose.yml

source ${CUR_DIR}/../colors.sh

if [[ -r ${DOCKER_COMPOSE_OVERRIDE_FINAL_PLACE} || ! -r ${DOCKER_COMPOSE_OVERRIDE_FINAL_PLACE}.dist || ! -r ${DOCKER_COMPOSE_FINAL_PLACE} ]] ; then
    exit 0;
fi

DOCKER_COMPOSE_OVERRIDE_ENVIRONMENT=${CUR_DIR}/../../environments/${PROJECT_NAME}/docker-compose.override.yml

if [[ -r ${DOCKER_COMPOSE_OVERRIDE_ENVIRONMENT} ]] ; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}docker-compose.override.yml copied from environment${NO_COLOR}"

    cp ${DOCKER_COMPOSE_OVERRIDE_ENVIRONMENT} ${DOCKER_COMPOSE_OVERRIDE_FINAL_PLACE}
    exit 0;
fi

if [[ -r ${DOCKER_COMPOSE_OVERRIDE_FINAL_PLACE}.dist ]] ; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}docker-compose.override.yml copied from repository${NO_COLOR}"

    cp ${DOCKER_COMPOSE_OVERRIDE_FINAL_PLACE}.dist ${DOCKER_COMPOSE_OVERRIDE_FINAL_PLACE}
    exit 0;
fi

echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${RED} restoring docker-compose.override.yml strange. Please have a look${NO_COLOR}"

