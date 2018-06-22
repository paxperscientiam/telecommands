#!/bin/bash

function sleep() {
    pmset displaysleepnow
}


if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f sleep
else
    sleep "${@}"
    exit $?
fi
