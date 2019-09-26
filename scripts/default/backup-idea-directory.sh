#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/../colors.sh

PROJECT_NAME=$1

cd ${CUR_DIR}/../../
if [[ ! -d apps/${PROJECT_NAME}/.idea ]]; then
    exit 0;
fi

if [[ -d environments/${PROJECT_NAME}/idea ]]; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Move idea folder to idea_bak${NO_COLOR}"
    mv environments/${PROJECT_NAME}/idea environments/${PROJECT_NAME}/idea_bak
fi

echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Backup .idea folder${NO_COLOR}"
cp -r apps/${PROJECT_NAME}/.idea environments/${PROJECT_NAME}/idea


if [[ -d environments/${PROJECT_NAME}/idea_bak ]]; then
    echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Remove idea_bak folder${NO_COLOR}"
    rm -r environments/${PROJECT_NAME}/idea_bak
fi

cd ${CUR_DIR}