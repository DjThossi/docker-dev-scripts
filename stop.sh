#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/scripts/projects.sh

for PROJECT_NAME in ${PROJECTS} ; do
    if [[ -d apps/${PROJECT_NAME} ]]; then
        if [[ -x ./scripts/${PROJECT_NAME}/stop.sh ]] ; then
            ./scripts/${PROJECT_NAME}/stop.sh
        else
            ./scripts/default/stop.sh ${PROJECT_NAME}
        fi
    fi
done

${CUR_DIR}/backup-settings.sh
