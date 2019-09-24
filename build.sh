#!/usr/bin/env bash

set -o nounset
set -o errexit

NO_CACHE_VALUE=""
if [[ "$@" =~ "--no-cache" ]]
then
    NO_CACHE_VALUE="--no-cache"
fi

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/scripts/projects.sh

for PROJECT_NAME in ${PROJECTS} ; do
    if [[ -d apps/${PROJECT_NAME} ]]; then
        if [[ -x ./scripts/${PROJECT_NAME}/stop.sh ]] ; then
            ./scripts/${PROJECT_NAME}/build.sh ${NO_CACHE_VALUE}
        else
            ./scripts/default/build.sh ${PROJECT_NAME} ${NO_CACHE_VALUE}
        fi
    fi
done

${CUR_DIR}/backup-settings.sh
