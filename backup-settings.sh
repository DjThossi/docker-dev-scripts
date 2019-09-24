#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/scripts/projects.sh

for PROJECT_NAME in ${PROJECTS} ; do
    if [[ -d ${CUR_DIR}/apps/${PROJECT_NAME} ]]; then
        if [[ -x ${CUR_DIR}/scripts/${PROJECT_NAME}/backup-settings.sh ]] ; then
            ${CUR_DIR}/scripts/${PROJECT_NAME}/backup-settings.sh
        else
            ${CUR_DIR}/scripts/default/backup-settings.sh ${PROJECT_NAME}
        fi
    fi
done
