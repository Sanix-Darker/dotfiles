#!/bin/bash

_check_requirements(){
    requirements=(
        "make" "git"
        "docker"
    )
    for $req in "${requirements[@]}"
    do
        $(command -v $req > /dev/null) && [[ $? != 0 ]] && echo "$req is required for this script to run" && exit 1
    done
    # all requirements available
}

_quick(){
    _check_requirements

    git clone https://github.com/Sanix-Darker/dotfiles
    cd dotfiles
    make
}

_quick
