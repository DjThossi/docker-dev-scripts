#!/usr/bin/env bash

set -o nounset
set -o errexit

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

ETC_HOSTS="/etc/hosts"

function removeExistingEntries() {
    sed -i.bak -e "/.*docker-dev-scripts.*/ d" ${ETC_HOSTS}
    rm ${ETC_HOSTS}.bak
}

function addEntry() {

    local DOMAIN=$1
    local IP="127.0.0.1"

    local HOST_LINE="$(grep -e "\(\s\+\)${DOMAIN}.*\s*$" ${ETC_HOSTS})"

    if [[ ! -n "${HOST_LINE}" ]]; then
        echo -e "127.0.0.1\t${DOMAIN} ### docker-dev-scripts ###" >> ${ETC_HOSTS}
    fi
}

touch ${ETC_HOSTS}

removeExistingEntries

cat $PWD/scripts/domains.txt | while read line
do
    addEntry ${line}
done
