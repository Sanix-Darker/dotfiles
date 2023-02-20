#!/bin/bash

_check_requirements(){
    requirements=(
        "make" "git"
        "docker"
    )
    for req in "${requirements[@]}"
    do
        command -v $req > /dev/null
        if [ "$?" != "0" ]; then
            echo "$req is required for this script to run" && exit 1
        fi
    done
}

_quick(){
    _check_requirements

    git clone https://github.com/Sanix-Darker/dotfiles
    cd dotfiles
    make
}

_quick
