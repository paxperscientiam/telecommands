#!/usr/bin/env bash


function listen() {
    local cmd
    local savedir
    local format
    local trim

    while [[ "${#1}" -gt 0 ]]; do
        case "${1}" in
            -s|--savedir)
                savedir="${2}"
                ;;
            -f|--format)
                format="${2}"
                ;;
            -t|--trim)
                trim="${2}"
                ;;
        esac
        shift 1
    done

    savedir="${savedir:-$TMPDIR}"
    format="${format:-ogg}"
    trim="${trim:-10:00}"

    cmd=$'command rec -c 2 "${savedir}"/radio."${format/\./}" trim 0 "${trim}"'
    printf 'command: %s\n' "${cmd}"

    command -v sox >/dev/null 2>&1 || { echo >&2 "I require sox but it's not installed.  Aborting."; exit 1; }
    eval "${cmd}"
}


if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f listen
else
    listen "${@}"
    exit $?
fi
