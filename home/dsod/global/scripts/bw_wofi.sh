#!/usr/bin/env bash

init() {
    if [[ -z "${BW_SESSION}" ]]; then
        
    fi
}

if [[ "$1" == "--listAll" ]]; then
    init
    list_all
elif [[ "$1" == "--search" ]];then
    init
    search
fi
