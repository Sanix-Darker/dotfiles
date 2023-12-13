#!/bin/bash

# Requirements:
# - make
# - git
# - docker (if you're going to proceed with docker installations)

_start(){
    requirements=("make" "git" "docker")
    echo "> Checking for requirements ($requirements)..."
    for req in "${requirements[@]}"
    do
        command -v $req > /dev/null
        if [ "$?" != "0" ]; then
            echo -ne "---\n'$req' is required for this script to run!\n---"
            exit 1
        fi
    done
    echo ">> You have all requirements."
    echo ">> Cloning the dotfiles repository..."
    git clone https://github.com/Sanix-Darker/dotfiles && cd dotfiles

    echo ">> SetUp 'Base' DevStack from docker..."
    make
}

_start
