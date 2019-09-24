#!/usr/bin/env bash

set -o nounset
set -o errexit

CUR_DIR=$( cd "$(dirname "$0")" ; pwd -P )

source ${CUR_DIR}/scripts/colors.sh

## Check for SSH key
if [[ ! -s "$HOME/.ssh/id_rsa.pub" ]]; then
    echo -e "${RED}ERROR: Public SSH key missing. Please generate a key and assign to your Bitbucket account${NO_COLOR}"
    exit 1
fi

## Check if docker-compose is available
if ! hash docker-compose 2>/dev/null; then
    echo -e "${RED}ERROR: Command 'docker-compose' missing${NO_COLOR}"
    exit 1
fi

## Update /etc/hosts with entries from domains.txt
sudo ./scripts/update-hosts-file.sh

source ${CUR_DIR}/scripts/projects.sh

hinit CLONED_PROJECTS
for PROJECT_NAME in ${PROJECTS} ; do
    if [[ ! -d ${CUR_DIR}/apps/${PROJECT_NAME} ]]; then
        echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Cloning${NO_COLOR}"
        git clone git@github.com:DjThossi/${PROJECT_NAME}.git apps/${PROJECT_NAME}
        hput CLONED_PROJECTS ${PROJECT_NAME} cloned
    else
        hput CLONED_PROJECTS ${PROJECT_NAME} existing
    fi
done

${CUR_DIR}/restore-settings.sh

for PROJECT_NAME in ${PROJECTS} ; do
    if [[ `hget CLONED_PROJECTS ${PROJECT_NAME}` == 'cloned' && \
        -x ${CUR_DIR}/scripts/${PROJECT_NAME}/install.sh ]] ;
    then
        echo -e "${BRIGHT_BLUE}${PROJECT_NAME}: ${BLUE}Running install.sh${NO_COLOR}"
        ${CUR_DIR}/scripts/${PROJECT_NAME}/install.sh
    fi
done
