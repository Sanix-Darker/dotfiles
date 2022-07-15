#Locales
# export LANGUAGE=en_GB.UTF-8
# export LANG=en_GB.UTF-8
# export LC_ALL=en_GB.UTF-8

# some more ls aliases
alias ls='exa'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lss='ls'
alias sl='ls'
alias lsc='ls'
alias ld='ls -d */'
alias cb='xclip -selection clipboard'
alias n='nordvpn connect'
alias mkdir='mkdir -p'
# This will create a directory if it doesn't exist
# And paste into it (cpd instead of normal cp to differentiate those)
_cpd(){
    mkdir $(dirname $1) && cp -r $@
}
alias cpd=_cpd

# some virtualenv python stuffs
alias ee='source *env*/bin/activate'
alias vv='virtualenv -p python3.10 env'
alias de='deactivate'
alias p='python3'

# the lock command
alias lo='gnome-screensaver-command -l'

if [ -f ~/.bash_work_aliases ]; then
    . ~/.bash_work_aliases
fi

# To mkdir a directory and cd into it
_md(){
    mkdir $1 && cd $1
}
alias md=_md

# To delete the current directory where am i
_rd(){
    tmp_dir=$(pwd)
    read -p "Are you sure (Y/y) {rm -rf $(pwd)}? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        cd .. && rm -rf $tmp_dir
    fi
}
alias rd=_rd
# overrided the cd command with the zoxide command line
# But let's do that only we're sure zoxide is installed properly
$(command -v zoxide > /dev/null) && [[ $? == 0 ]] && alias cd='z'

# alias br='/usr/bin/broot'
# Kill a process running on a specific port
_killport(){
    sudo kill -9 $(sudo lsof -t -i:$1)
}
alias killport=_killport
alias gf=$HOME/ACTUALC/github/git-search/gf.sh

# My custom build of scrcpy
alias scrcpy='/usr/local/bin/scrcpy -m1024'
alias gbd='sh $HOME/gbd.sh'
alias s='slides'

# alias python='python3'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ls_services='systemctl list-units --type=service'
alias v='nvim'
alias nv='nvim'
alias rf='rm -rf'
alias gg='google-chrome-stable'
alias hs='http-server -o'
# alias pip='python3.10 -m pip'
alias i='ipython'
# To refresh stuff with source on bash alialses and bashrc itself
alias so='source ~/.bashrc'

# To list running services
alias services='systemctl list-units --type=service'

## dotfiles management
DOT_DIR="$HOME/dotfiles"
# Assuming we already have the dotfiles directory
# on our workspace
_set_dot_files(){
    # vim stuffs
    mkdir ~/.config/nvim/
    cpd $DOT_DIR/init.lua ~/.config/nvim/
    cpd $DOT_DIR/config.vim ~/.config/nvim/
    cpd $DOT_DIR/plugins.vim  ~/.config/nvim/
    mkdir ~/.config/nvim/autoload ~/.config/nvim/colors
    cpd $DOT_DIR/autoload  ~/.config/nvim/
    cpd $DOT_DIR/colors ~/.config/nvim/

    # for neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    # to install new stuffs if some of them were missing
    nvim --headless +PlugInstall +qall

    # cocInstall servers
    coc_servers=(
        "coc-json" "coc-html" "coc-css" "coc-sh"
        "coc-pyright" "coc-go" "coc-tsserver"
    )
    for i in "${coc_servers[@]}"
    do
        echo "[-] Nvim CocInstall $i..."
        nvim --headless +"CocInstall $1" +qall
    done

    # for my bash stuffs
    cpd $DOT_DIR/.bashrc ~/.bashrc
    cpd $DOT_DIR/.bash_aliases ~/.bash_aliases
    cpd $DOT_DIR/.bash_logout ~/.bash_logout

    # my vagrant stuffs
    cpd $DOT_DIR/vagrant ~/vagrant/

    # we copy our terminal alacritty
    cpd $DOT_DIR/alacritty.yml ~/.config/alacritty/alacritty.yml
    # we copy our felix config 
    cpd $DOT_DIR/felix_config.toml ~/.config/felix/config.toml

    # we copy our polybar config 
    cpd $DOT_DIR/polybar_config.ini ~/.config/polybar/config.ini
    
    # we copy our felix config 
    cpd $DOT_DIR/i3_config ~/.config/i3/config

    # For my git configurations
    cpd $DOT_DIR/.gitconfig ~/.gitconfig
    cpd $DOT_DIR/.tmux.conf ~/.tmux.conf
    cpd $DOT_DIR/config.rasi ~/.config/rofi/config.rasi

    # we return on our previus directory
    cd -
}

_push_dot_files(){
    # vim stuffs
    cpd ~/.config/nvim/init.lua $DOT_DIR/init.lua 
    cpd ~/.config/nvim/config.vim $DOT_DIR/config.vim
    cpd ~/.config/nvim/plugins.vim $DOT_DIR/plugins.vim

    mkdir $DOT_DIR/autoload $DOT_DIR/colors
    cpd ~/.config/nvim/autoload $DOT_DIR
    cpd ~/.config/nvim/colors $DOT_DIR

    # for my bash stuffs
    cpd ~/.bashrc $DOT_DIR
    cpd ~/.bash_aliases $DOT_DIR
    cpd ~/.bash_logout $DOT_DIR

    # other configurations
    cpd ~/.tmux.conf $DOT_DIR

    # my vagrant stuffs
    cpd ~/vagrant $DOT_DIR

    # copy alacritty conf
    cpd ~/.config/alacritty/alacritty.yml $DOT_DIR
    # copy felix conf
    cpd ~/.config/felix/config.toml $DOT_DIR/felix_config.toml
    # copy polybar
    cpd ~/.config/polybar/config.ini $DOT_DIR/polybar_config.ini
    # copy conf
    cpd ~/.config/i3/config $DOT_DIR/i3_config
    
    # Our rofi theme for search
    cpd ~/.config/rofi/config.rasi $DOT_DIR/rofi_config.rasi

    # For my git configurations
    cpd ~/.gitconfig $DOT_DIR
    cd $DOT_DIR
    # git stash && git pull --prune && git stash pop
    sleep 1
    git diff
    git add -A && git commit -m "feat: updates for $(date)"
    git push

    # we return on our previus directory
    cd -
}

_pull_dot_files(){
    if [[ ! -d $DOT_DIR ]]
    then
        git clone https://github.com/Sanix-Darker/dotfiles
    else
        cd $DOT_DIR
        git pull
    fi
}

_source_dev_stack(){
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo add-apt-repository ppa:regolith-linux/release
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt update -y && apt-get update -y
}
_install_vagrant(){
    # install virtualbox
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

    sudo apt install virtualbox-6.1 -y
    wget https://download.virtualbox.org/virtualbox/6.1.8/Oracle_VM_VirtualBox_Extension_Pack-6.1.8.vbox-extpack
    sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.8.vbox-extpack

    # Install vagrant and it's stuff
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-get update -y && sudo apt-get install vagrant -y
}

_install_alacritty(){
    # we install alacritty as our terminal
    sudo apt-get install cmake pkg-config \
        libfreetype6-dev libfontconfig1-dev \
        libxcb-xfixes0-dev libxkbcommon-dev \
        python3 -y
    cargo install alacritty

    npm i -g alacritty-themes
}

_install_path_browsing_utils(){
    # we install zoxide for fast cd
    curl -sS https://webinstall.dev/zoxide | bash;
    # installing rust and exa (for ls/ll)
    curl https://sh.rustup.rs -sSf | sh

    wget -c https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
    unzip exa-linux-x86_64-0.8.0.zip
    sudo mv exa-linux-x86_64 /usr/local/bin/exa
    rm -rf exa*.zip

    # Install FZF
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # We install felix (the vim file manager)
    cargo install felix

    # to install i3
    sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
        libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev \
        libxcb-cursor-dev xutils-dev libtool automake autoconf gcc make pkg-config libpam0g-dev libcairo2-dev \
        libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev \
        libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev \
        libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y
    # For image manipulation and rofi for the fast search windows
    # arandr is for managing the xrandr for monitors
    sudo apt install i3-gaps mpv feh rofi arandr -y
    git clone https://github.com/Raymo111/i3lock-color.git && cd i3lock-color && ./install-i3lock-color.sh

    # install delta, a amzing tool for diff
    wget https://github.com/dandavison/delta/releases/download/0.12.1/git-delta_0.12.1_amd64.deb
    sudo apt install ./git-delta_0.12.1_amd64.deb -y

    # Install polybar
    sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev \
        libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev \
        libcurl4-openssl-dev libnl-genl-3-dev -y
    git clone --recursive https://github.com/polybar/polybar
    cd polybar
    mkdir build
    cd build
    cmake ..
    make -j$(nproc)
    # Optional. This will install the polybar executable in /usr/local/bin
    sudo make install
}

_install_nvim_and_utils(){
    # For neovim we get the latests nightly version
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    sudo chmod +x ./nvim.appimage
    sudo mv ./nvim.appimage /usr/local/bin/nvim

    # To install CocInstall, we need nodejs
    sudo apt install nodejs npm -y
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source ~/.bashrc
    nvm install stable

    # install a simple git visualizer
    wget -O grv https://github.com/rgburke/grv/releases/download/v0.3.2/grv_v0.3.2_linux64
    chmod +x ./grv && sudo mv ./grv /usr/bin/grv
}

_install_dev_stack(){
    _source_dev_stack

    # sudo apt install type
    devStack=(
        "build-essential"
        "software-properties-common"

        "tmux" "tmate" "git-lfs"
        "python3-dev" "python3-pip"
        "python3-setuptools"
        "python3-testresources"
        "python3.10-distutils"
        "python3.10-dev"

        "zip" "unzip" "curl" "wget"

        "docker" "docker-compose"
        "git" "bat" "snap"
        "silversearcher-ag"
    )
    for i in "${devStack[@]}"
    do
        echo "[-] installing $i..."
        sudo apt install $i -y
    done

    read -p "Install Path browsing utils ? (Y/y) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        _install_path_browsing_utils
    fi

    # For a weird perl warning error on locales UTF-8
    sudo locale-gen en_GB.UTF-8
    sudo dpkg-reconfigure locales

    _install_nvim_and_utils

    read -p "Install vagrant stuffs ? (Y/y) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        _install_vagrant
    fi

    # the most beautifull downloader
    # and the markdown powerpoint presenter
    sudo snap install slides aria2c
    
    read -p "Install alacritty terminal ? (Y/y) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        _install_alacritty
    fi
}

_help(){
   curl -s -L cheat.sh/$@ | less -R
}
alias h='_help'
alias a='aria2c'
# Alias definitions.
alias postman='~/Postman/Postman &'
alias clean_docker_images='docker rmi $(docker images -f "dangling=true" -q)'
alias clean_docker_images_all='docker image prune --all'
alias clean_docker_container='docker rm -f $(docker ps -a -q)'
alias cat='batcat -p'
alias tmux='tmux -2'

# To fastly jump in a remote branch
_get(){
    if [ -d ".git" ]; then
        if [ -n "$1" ]; then
            # An argument passed
            # We try to stash our changes if there where some...
            git stash
            # We fetch/checkout the target branch
            git fetch origin $1
            git checkout $1
        else
            # No argument passed
            echo "Usage: get feat/test-stuff"
        fi
    else
        echo "[x] Oups, not a .git directory !"
    fi
}

# To get back to your stuffs (branch and changes)
_back(){
    if [ -d ".git" ]; then
        # To revert local changes that have been made
        git restore --staged .
        git restore .
        # To get back on previous branch
    	git checkout -
        # We try to get our precedents changes back...
        git stash pop
    else
        echo "[x] Oups, not a .git directory !"
    fi
}

# To have in the terminal 
# only the command you executed got reload
# and cleared instead of multilines
_only(){
    watch -n 0.5 "$1"
}

# For the browser in the terminal
# But with no sessions
alias b='pkill -f firefox; /usr/bin/browsh_1.6.4_linux_amd64'

_f() (
  [ "$?" != 0 ] && fuck;
)
alias f="_f"
alias x='xdg-open .'

# _git_search "function name"
_git_search(){
    echo "[-] Searching for '${1}' in this repo..."
    sleep 2
    # We less in the list of results
    # a smart git command to get commit, file and line where
    # the string is available
    git rev-list --all | (
        while read revision; do
            git grep -n -F "${1}" $revision
        done
    ) > ${HOME}/.gf-out

    less ${HOME}/.gf-out
}

# __git_open_code "function name"
_git_open_code(){
    # getting your current branch
    branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

    # A smart split from the incomming $1 parameter
    arr=($(echo "$1" | tr ':' '\n'))
    commit=${arr[0]}
    file=${arr[1]}
    line=${arr[2]}

    # some verbose
    echo "[-] Moving on commit : $commit" && sleep 1
    echo "[-] Moving on file : $file" && sleep 1
    echo "[-] Moving on line : $line" && sleep 1

    # A checkout on the commit then a less on the line of the file
    git checkout "$commit"
    less +"$line" "$file"

    sleep 2
    echo "\n[-] Rolling back to your precedent branch..."
    # comming back to reality
    git checkout "$branch"
}

# To clone a sub_dir
# To clone a sub directory from a random project
# _git_clone_sub directory1 https://github.com/author/repo 
# Or from a specific branch
# _git_clone_sub directory1 https://github.com/author/repo  
_git_clone_sub(){

    REPO_NAME="$(echo $2 | grep -oE '[^/]+$')"

    git init $REPO_NAME
    cd $REPO_NAME

    git remote add origin $2
    git config core.sparsecheckout true

    # Specipy the sub directory
    echo "$1/*" >> .git/info/sparse-checkout

    # then get it, the depth is the way too far wher you can go...
    git pull origin master

}

_git_squash(){

    read -p "You're about to squash all the commits from this branch ? (Y/y) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # Commit count difference between my branch and the master branch
        COMMIT_COUNT=git rev-list --count HEAD ^master
        # We rebase from the amount of commit
        git rebase -i HEAD~$COMMIT_COUNT
    else
        echo "Squash stopped"
    fi

}

# To install apt-clone for backups
# sudo apt-get install apt-clone
# To Make a backup
# sudo apt-clone clone path-to/apt-clone-state-ubuntu-$(lsb_release -sr)-$(date +%F).tar.gz
# To restore a backup
# sudo apt-clone restore path-to/apt-clone-state-ubuntu.tar.gz
# To restore to the newer version:
#  sudo apt-clone restore-new-distro path-to/apt-clone-state-ubuntu.tar.gz $(lsb_release -sc)

# to host anything
alias tb="nc termbin.com 9999"

# to see pdf on the terminal
_pff(){
    pdftotext -layout "$1" - | less
}
alias pff='_pff'

# For tmux command :
alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach-session -t'
alias to='ta other'
alias tkill='tmux kill-server'

# open telegram as tgg
alias tgg='nohup /home/dk/Downloads/tsetup.3.4.8/Telegram/Telegram &'
alias com='pkill compton && nohup compton -f &'

# To control the brightness with xrandr
_xrandr(){
    # _xrandr lu eDP-1-1 0.9
    if [[ $1 == 'ls' ]];then
        xrandr -q | grep ' connected' | head -n 1 | cut -d ' ' -f1
    elif [[ $1 == 'lu' ]];then
        xrandr --output $2 --brightness $3
    fi
}
alias docker_ps="docker ps --format 'table {{.RunningFor}}\t{{.Status}}\t{{.Names}}'"
alias untar="tar -xf"
