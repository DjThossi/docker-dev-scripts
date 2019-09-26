#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
PROJECT_NAME=$1
DOCKER_COMPOSE_OVERRIDE_WORK_DIR=${CUR_DIR}/../../apps/${PROJECT_NAME}/docker-compose.override.yml

if [[ ! -r ${DOCKER_COMPOSE_OVERRIDE_WORK_DIR} ]] ; then
    exit 0;
fi

source ${CUR_DIR}/../colors.sh
echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Backup docker-compose.override.yml file${NO_COLOR}"
DOCKER_COMPOSE_OVERRIDE_ENVIRONMENT=${CUR_DIR}/../../environments/${PROJECT_NAME}/docker-compose.override.yml

cp ${DOCKER_COMPOSE_OVERRIDE_WORK_DIR} ${DOCKER_COMPOSE_OVERRIDE_ENVIRONMENT}


