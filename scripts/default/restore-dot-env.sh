#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
PROJECT_NAME=$1
ENV_FILE_WORK_DIR=${CUR_DIR}/../../apps/${PROJECT_NAME}/.env
ENV_DIST_FILE=${CUR_DIR}/../../apps/${PROJECT_NAME}/.env.dist
ENV_FILE_IN_ENVIRONMENT=${CUR_DIR}/../../environments/${PROJECT_NAME}/env

source ${CUR_DIR}/../colors.sh

if [[ -r ${ENV_FILE_WORK_DIR} || ! -r ${ENV_DIST_FILE} ]] ; then
    exit 0;
fi

if [[ -r ${ENV_FILE_IN_ENVIRONMENT} ]] ; then
    cp ${ENV_FILE_IN_ENVIRONMENT} ${ENV_FILE_WORK_DIR}

    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}.env restored from environment${NO_COLOR}"
    exit 0;
fi

if [[ -r ${ENV_DIST_FILE} ]] ; then
    cp ${ENV_DIST_FILE} ${ENV_FILE_WORK_DIR}

    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}.env copied from .env.dist${NO_COLOR}"
    exit 0;
fi

echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${RED} restoring .env is strange. Please have a look${NO_COLOR}"

