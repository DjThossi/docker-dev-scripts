#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )
source ${CUR_DIR}/../colors.sh

cd ${CUR_DIR}/../../apps/docker-dummy-b

docker-compose run php composer install

cd ${CUR_DIR}
