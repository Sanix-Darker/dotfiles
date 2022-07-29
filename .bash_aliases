#Locales
# export LANGUAGE=en_GB.UTF-8
# export LANG=en_GB.UTF-8
# export LC_ALL=en_GB.UTF-8

# SOME COLORS
# RESET
COLOROFF='\033[0m'       # TEXT RESET
# REGULAR COLORS
BLACK='\033[0;30m'        # BLACK
RED='\033[0;31m'          # RED
GREEN='\033[0;32m'        # GREEN
YELLOW='\033[0;33m'       # YELLOW
BLUE='\033[0;34m'         # BLUE
PURPLE='\033[0;35m'       # PURPLE
CYAN='\033[0;36m'         # CYAN
WHITE='\033[0;37m'        # WHITE

# BOLD
BBLACK='\033[1;30m'       # BLACK
BRED='\033[1;31m'         # RED
BGREEN='\033[1;32m'       # GREEN
BYELLOW='\033[1;33m'      # YELLOw
BBLUE='\033[1;34m'        # BLUE
BPURPLE='\033[1;35m'      # PURPLE
BCYAN='\033[1;36m'        # CYAN
BWHITE='\033[1;37m'       # WHITE

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
    mkdir "$(dirname ${@: -1})" && cp -r $@
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
alias s='slides'

# alias python='python3'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ls_services='systemctl list-units --type=service'
alias v='nvim'
alias nv='nvim'
# we could use thre trash-cli to rf or rm-rf

# to list trash elements
_lf(){
    # list all trash delete elements and grep pipe to list all item deleted 
    # referenced only by the directory i am at the moment this command
    trash-list | sort -r | cat | grep $(pwd)
}
alias lf='_lf'
# to put inside the trash
alias rf='trash-put'
# To delete from trash
alias rrf='trash-rm'
# to empty the trans
alias rrff='trash-empty'
# to restore an item
alias rr='trash-restore'

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
    cpd $DOT_DIR/{.bashrc,.bash_aliases,.bash_logout} ~/

    # my vagrant stuffs
    cpd $DOT_DIR/vagrant/vms ~/vagrant/vms

    cpd $DOT_DIR/mac_Vagrantfile ~/vagrant/vms/mac/Vagrantfile
    cpd $DOT_DIR/ubu_Vagrantfile ~/vagrant/vms/ubu/Vagrantfile
    cpd $DOT_DIR/win_Vagrantfile ~/vagrant/vms/win/Vagrantfile
    cpd $DOT_DIR/ubu_arm64_Vagrantfile ~/vagrant/vms/ubu-arm64/Vagrantfile 

    # we copy our terminal alacritty
    cpd $DOT_DIR/alacritty.yml ~/.config/alacritty/alacritty.yml

    # we copy our i3 config 
    cpd $DOT_DIR/i3_config ~/.config/i3/config
    cpd $DOT_DIR/i3lock.sh ~/.config/i3/i3lock.sh
    cpd $DOT_DIR/i3mouse.sh ~/.config/i3/i3mouse.sh

    # For my git configurations
    cpd $DOT_DIR/.gitconfig ~/.gitconfig
    cpd $DOT_DIR/.tmux.conf ~/.tmux.conf
    cpd $DOT_DIR/rofi_config.rasi ~/.config/rofi/config.rasi

    # we return on our previus directory
    cd -
}

_copy_to_dotfiles(){
    # vim stuffs
    cpd ~/.config/nvim/{init.lua,config.vim,plugins.vim} $DOT_DIR/

    mkdir $DOT_DIR/autoload $DOT_DIR/colors
    cpd ~/.config/nvim/autoload $DOT_DIR
    cpd ~/.config/nvim/colors $DOT_DIR

    # for my bash stuffs
    cpd ~/{.bashrc,.bash_aliases,.bash_logout} $DOT_DIR/

    # other configurations
    cpd ~/.tmux.conf $DOT_DIR

    # my vagrant stuffs
    cpd ~/vagrant/vms/mac/Vagrantfile $DOT_DIR/mac_Vagrantfile
    cpd ~/vagrant/vms/ubu/Vagrantfile $DOT_DIR/ubu_Vagrantfile
    cpd ~/vagrant/vms/win/Vagrantfile $DOT_DIR/win_Vagrantfile
    cpd ~/vagrant/vms/ubu-arm64/Vagrantfile $DOT_DIR/ubu_arm64_Vagrantfile

    # copy alacritty conf
    cpd ~/.config/alacritty/alacritty.yml $DOT_DIR
    # copy i3 conf
    cpd ~/.config/i3/config $DOT_DIR/i3_config
    cpd ~/.config/i3/i3lock.sh $DOT_DIR/i3lock.sh
    cpd ~/.config/i3/i3mouse.sh $DOT_DIR/i3mouse.sh
    
    # Our rofi theme for search
    cpd ~/.config/rofi/config.rasi $DOT_DIR/rofi_config.rasi

    # For my git configurations
    cpd ~/.gitconfig $DOT_DIR
}

_push_dot_files(){
    _copy_to_dotfiles

    cd $DOT_DIR
    # git stash && git pull --prune && git stash pop
    git diff && git add -A && git commit -m "feat: updates for $(date)"

    echo "[-] dotfiles commited !"

    # we push on condition
    _confirm "[>] Push those changes on github ?" git push

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
    sudo add-apt-repository ppa:regolith-linux/release \
        apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" &&\
        apt update -y
}


_install_android_studio(){
    sudo add-apt-repository ppa:maarten-fonville/android-studio -y
    sudo apt update -y

    sudo apt install openjdk-11-jdk \
        android-studio \
        android-tools-adb \
        android-tools-fastboot
}

_install_vagrant(){
    sudo apt update -y
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
    sudo apt update -y
    curl https://sh.rustup.rs -sSf | sh
    # we install alacritty as our terminal
    sudo apt-get install cmake pkg-config \
        libfreetype6-dev libfontconfig1-dev \
        libxcb-xfixes0-dev libxkbcommon-dev \
        python3 -y
    cargo install alacritty

    npm i -g alacritty-themes
}

_install_path_browsing_utils(){
    sudo apt update -y

    # we install zoxide for fast cd
    curl -sS https://webinstall.dev/zoxide | bash;
    # installing rust and exa (for ls/ll)
    curl https://sh.rustup.rs -sSf | sh

    wget -c https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
    unzip exa-linux-x86_64-0.8.0.zip
    sudo mv exa-linux-x86_64 /usr/local/bin/exa
    rm -rf exa*.zip
}


_install_nvim(){
    echo "[-] Current version : $(nvim --version)"
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    sudo chmod +x ./nvim.appimage
    sudo mv ./nvim.appimage /usr/local/bin/nvim
    echo "[-] Installed version : $(nvim --version)"
}

_install_node_stuffs(){
    sudo apt install nodejs npm -y
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source ~/.bashrc
    nvm install stable
}

_install_grv(){
    wget -O grv https://github.com/rgburke/grv/releases/download/v0.3.2/grv_v0.3.2_linux64
    chmod +x ./grv && sudo mv ./grv /usr/bin/grv
}

_install_nvim_and_utils(){
    sudo apt update -y

    # For neovim we get the latests nightly version
    _confirm "Install the latest nvim nightly release ?" _install_nvim

    # To install CocInstall, we need nodejs
    _confirm "Install the nodejs, npm and nvm (usefull for Coc-Server) ? " _install_node_stuffs

    # install a simple git visualizer
    _confirm "Install a git visualizer for commits, branchs and other stuffs (grv) ? " _install_grv
}

_install_python_stuffs(){
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt update -y

    devStack=(
        "python3-dev" "python3-pip"
        "python3-setuptools"
        "python3-testresources"
        "python3.10-distutils"
        "python3.10-dev"
    )
    for i in "${devStack[@]}"
    do
        echo -e "\n$GREEN[-] Installing $i...$COLOROFF"
        sudo apt install $i -y
    done
}

# With a given message as input, this function will execute anything
# after the second argument passed
# Ex : _confirm "Message" echo "test"
_confirm(){
    args=("${@}")
    echo -e "\n$BLUE[-] ${args[0]} $COLOROFF"
    read -p "[?] (Y/y): " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        clear
        echo -e "\n$BLUE[+] ${args[0]} $COLOROFF"
        callback=${args[@]:1}
        # echo ">>" $callback
        $callback
        echo -e "\n$BWHITE-----------------------------------------------------------------$COLOROFF"
    fi
    echo
}


_install_i3(){
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

    # install autolock
    # sudo apt-get install xautolock -y
}

_install_delta(){
    wget https://github.com/dandavison/delta/releases/download/0.12.1/git-delta_0.12.1_amd64.deb && \
    sudo apt install ./git-delta_0.12.1_amd64.deb -y
}

_install_FZF(){
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install
}

_install_locales_lang(){
    sudo locale-gen en_GB.UTF-8 && \
    dpkg-reconfigure locales
}

_install_basics(){
    sudo add-apt-repository ppa:git-core/ppa -y
    # sudo apt install type
    devStack=(
        "build-essential"
        "software-properties-common"

        "tmux" "tmate" "git-lfs"
        "tar" "zip" "unzip" "curl"
        "wget" "gcc" "g++" "make"

        "docker" "docker-compose"
        "git" "bat" "snap"
        "silversearcher-ag"
    )
    for i in "${devStack[@]}"
    do
        echo -e "\n$GREEN[-] Installing $i...$COLOROFF"
        sudo apt install $i -y
    done
    
    # For a weird perl warning error on locales UTF-8
    _confirm "Reconfigure locale langs ? " _install_locales_lang

    # Install FZF
    _confirm "Install FZF (require git) ?" _install_FZF

    # install delta, a amzing tool for diff
    _confirm "Install delta for diff highlighting ?" _install_delta
}

_install_extras_stuffs(){
    # the most beautifull downloader
    # and the markdown powerpoint presenter
    sudo snap install slides aria2c
}

_install_dev_stack(){
    _source_dev_stack

    _confirm "Install Basics utils (git, docker...) stuffs ?" _install_basics
    _confirm "Install python(.10) stuffs ?" _install_python_stuffs
    _confirm "Install Path browsing utils ?" _install_path_browsing_utils
    _confirm "Install Nvim stuffs ?" _install_nvim_and_utils
    _confirm "Install i3 stuffs (heavy | ui) ?" _install_i3
    _confirm "Install vagrant stuffs (heavy) ?" _install_vagrant
    _confirm "Install alacritty terminal (ui) ?" _install_alacritty
    _confirm "Install extras stuffs (slides, aria2c) ?" _install_extras_stuffs
}

_install_help(){
    cat ~/.bash_aliases | grep "\"Install " | grep "_confirm" | grep "_install_" | cut -b 22-
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

_get_coworker(){
    remote_u=(${1//:/ })

    author=${remote_u[0]}
    branch=${remote_u[1]}
    current_dir=$(basename $PWD)
    target="git@github.com:$author/$current_dir"

    echo -e "> author: $BWHITE $author $COLOROFF"
    echo -e "> branch: $BWHITE $branch $COLOROFF"
    echo -e "> repo-name: $BWHITE $current_dir $COLOROFF"
    echo -e "> target-repo: $BWHITE $target $COLOROFF"

    read -p "Those informations are good ? (Y/y): " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        git remote add $author $target
        git fetch $author
        git checkout --track $author/$branch
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
_pdf(){
    pdftotext -layout "$1" - | less
}
alias pdf='_pdf'

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

m() {
  python3 -c "from math import *; print($*)"
}

