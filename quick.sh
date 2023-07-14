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
            echo "---"
            echo "'$req' is required for this script to run"

            if [[ "$req" == "docker" ]]; then
                echo "It will installed automatically !"

                sudo apt-get install ca-certificates curl gnupg -y

                sudo install -m 0755 -d /etc/apt/keyrings
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
                    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                sudo chmod a+r /etc/apt/keyrings/docker.gpg

                echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
                    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

                sudo apt-get install \
                    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
            else
                sudo apt-get install $req -y
            fi
        fi
    done
}

_quick(){
    sudo apt-get update -y

    _check_requirements

    echo ">> Cloning the repository..."
    git clone https://github.com/Sanix-Darker/dotfiles && cd dotfiles
    echo ">> make..."
    make
}

_quick
