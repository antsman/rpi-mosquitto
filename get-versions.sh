#!/bin/bash

test -n "$1" && (
    echo MOSQUITTO_VERSION=\"$(docker exec -t $1 mosquitto -h | grep version | awk '{ print $3 }') | tr -d '\n'\" | tee env.properties
    echo ALPINE_VERSION=\"$(docker exec -t $1 cat /etc/alpine-release | tr -d '\r')\" | tee -a env.properties
) || (
    echo Give container name as parameter!
    exit 1
)
