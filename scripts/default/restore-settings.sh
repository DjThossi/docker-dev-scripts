#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
PROJECT_NAME=$1

${CUR_DIR}/restore-docker-compose-override.sh ${PROJECT_NAME}
${CUR_DIR}/restore-idea-directory.sh ${PROJECT_NAME}
