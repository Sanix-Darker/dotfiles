#!/bin/bash

# Requirements:
# - make
# - git
# - docker (if you're going to proceed with docker installations)

_check_requirements(){
    requirements=(
        "make" "git"
        "docker"
    )
    for req in "${requirements[@]}"
    do
        command -v $req > /dev/null
        if [ "$?" != "0" ]; then
            echo -ne "---\n'$req' is required for this script to run!\n---"
            exit 1
        fi
    done
}

_quick(){
    _check_requirements

    echo ">> Cloning the repository..."
    git clone https://github.com/Sanix-Darker/dotfiles && cd dotfiles

    echo ">> Installing..."
    make
}

_quick
