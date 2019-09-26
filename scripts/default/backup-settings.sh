#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/../colors.sh

PROJECT_NAME=$1

cd ${CUR_DIR}/../../
if [[ ! -d environments/${PROJECT_NAME} ]]; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}mkdir environments/${PROJECT_NAME}${NO_COLOR}"
    mkdir environments/${PROJECT_NAME}
fi

cd ${CUR_DIR}
./backup-idea-directory.sh ${PROJECT_NAME}
./backup-docker-compose-override.sh ${PROJECT_NAME}
./backup-dot-env.sh ${PROJECT_NAME}