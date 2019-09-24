#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/../colors.sh

PROJECT_NAME=$1

cd ${CUR_DIR}/../../

if [[ -d ./environments/${PROJECT_NAME}/idea && ! -d ./apps/${PROJECT_NAME}/.idea ]]; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Copy .idea folder from environment${NO_COLOR}"
    cp -r ./environments/${PROJECT_NAME}/idea ./apps/${PROJECT_NAME}/.idea
fi

cd ${CUR_DIR}