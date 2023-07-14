#!/bin/bash

_automatic_install(){
    echo "----------"
    echo "Do you want it to be installed automatically ?"

    read -p "[?] (Y/y): " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]];then
        echo ""
        echo ">> $1"
        sudo $1
    fi
    echo ""
}

_check_requirements(){
    requirements=(
        "make" "git"
        "docker"
    )
    for req in "${requirements[@]}"
    do
        command -v $req > /dev/null
        if [ "$?" == "0" ]; then
            echo "---"
            echo "'$req' is required for this script to run"

            if [[ "$req" == "docker" ]]; then
                echo "Tips: apt-get install \
                    docker-ce docker-ce-cli containerd.io
                    docker-buildx-plugin docker-compose-plugin -y
                "
                _automatic_install "apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y"
            else
                echo "Tips: apt-get install $req git -y"
                _automatic_install "apt-get install $req -y"
            fi
        fi
    done
}

_quick(){
    _check_requirements

    echo ">> Cloning the repository..."
    git clone https://github.com/Sanix-Darker/dotfiles && cd dotfiles
    echo ">> make..."
    make
}

_quick
