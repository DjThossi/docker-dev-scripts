#!/usr/bin/env bash

PROJECTS="docker-dev-proxy docker-dummy-a docker-dummy-b"

hinit() {
    rm -f /tmp/hashmap.$1
}

hput() {
    echo "$2 $3" >> /tmp/hashmap.$1
}

hget() {
    grep "^$2 " /tmp/hashmap.$1 | awk '{ print $2 };'
}
