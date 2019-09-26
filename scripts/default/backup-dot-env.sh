#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
PROJECT_NAME=$1
ENV_FILE_WORK_DIR=${CUR_DIR}/../../apps/${PROJECT_NAME}/.env
ENV_FILE_IN_ENVIRONMENT=${CUR_DIR}/../../environments/${PROJECT_NAME}/env

source ${CUR_DIR}/../colors.sh

if [[ ! -r ${ENV_FILE_WORK_DIR} ]] ; then
    exit 0;
fi

echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Backup .env file${NO_COLOR}"
cp ${ENV_FILE_WORK_DIR} ${ENV_FILE_IN_ENVIRONMENT}
