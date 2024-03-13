#!/bin/bash

# Locales
# export LANGUAGE=en_GB.UTF-8
# export LANG=en_GB.UTF-8
# export LC_ALL=en_GB.UTF-8

# SOME COLORS
# RESET
export COLOROFF='\033[0m'
# REGULAR COLORS
export BLACK='\033[0;30m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export WHITE='\033[0;37m'

# BOLD
export BBLACK='\033[1;30m'
export BRED='\033[1;31m'
export BGREEN='\033[1;32m'
export BYELLOW='\033[1;33m'
export BBLUE='\033[1;34m'
export BPURPLE='\033[1;35m'
export BCYAN='\033[ 1;36m'
export BWHITE='\033[1;37m'

# Just some handlers for my given colors
_echo_green(){
    echo -ne "$GREEN$@$COLOROFF\n";
}
_echo_black(){
    echo -ne "$BLACK$@$COLOROFF\n";
}
_echo_blue(){
    echo -ne "$BLUE$@$COLOROFF\n";
}
_echo_white(){
    echo -ne "$WHITE$@$COLOROFF\n";
}
_echo_background_white(){
    echo -ne "$BWHITE$@$COLOROFF\n";
}
_echo_red(){
    echo -ne "$RED$@$COLOROFF\n";
}
_echo_yellow(){
    echo -ne "$YELLOW$@$COLOROFF\n";
}
_lower_case(){
    echo "$@" | tr '[:upper:]' '[:lower:]'
}
_upper_case(){
    echo "$@" | tr '[:lower:]' '[:upper:]'
}

## dotfiles directory management
export DOT_DIR="$HOME/dotfiles"
# Copy alacritty mpv tmux i3 git config, polybar and rofi
export CONFIG_PATHS=(
    "autostart"
    "rofi" "polybar"
    "git" "i3"
    "mpv" "alacritty"
    "gh-dash" "yazi"
)

# Generate random string input
# random_str=$(_random_string 10)
_generate_random_string(){
  local length=$1
  [ -z "$length" ] && length=10
  tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c "$length"
}

# NOTE: a small function to print what it's about to execute... could be great
# to show the user, what's going on
_xx(){
    _echo_background_white "\n>> $@"
    $@
}

# This will just execute your command in the /tmp directory
# that's all
_xm(){
    cd /tmp;
    _xx $@;
    cd -;
}

alias cat='bat -p'

# Small custom spinner
# Usage:
#   _start_spinner
#   your_command_that_may_takes_long
#   _stop_spinner
_start_spinner(){
    _spinner(){
        echo -n "> loading" && \
            while true; do echo -n "."; sleep 1; done;
    }
    _spinner &
    _SPINNER_PID=$! #<-- ici, we save the PID of the spinner process
}
_stop_spinner(){
    # Kill the _spinner process using its PID
    kill $_SPINNER_PID
}

# To check either something is installed or not
# Ex: _installed neofetch
# OR : $ _installed neofetch && echo "Installed" || echo "Nope"
_installed(){
    $(command -v $@ > /dev/null) && [[ $? == 0 ]] && return 0 || return 1
}

# With a given message as input, this function will execute anything
# after the second argument passed
# Ex : _confirm "Message" echo "test"
_confirm(){
    # We need a bypass param to run all installations without handling
    # anykind of confirmation, that's the reason of $NOTINTERACTIVE
    # variables. For example :
    #
    # NOTINTERACTIVE=1 _install_basics
    #
    args=("${@}")
    if [[ $NOTINTERACTIVE = "1" ]]; then
        _echo_blue "[+] ${args[0]} "
        callback=${args[@]:1}
        $callback
    else
        _echo_blue "[-] ${args[0]} "
        read -p "[?] (Y/y): " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            # clear
            # echo -e "$BLUE[+] ${args[0]} $COLOROFF"
            callback=${args[@]:1}
            # echo ">>" $callback
            $callback
            _echo_white "-------------------------------------------"
            return 0
        else
            return 1
        fi;
    fi;
    echo
}

# This util add a simple pre-check on command/elf
# that may be already installed or not
#
# Usage:
# _confirm_install_again lynx || return 0
# or
# _confirm_install_again lynx && \
#   sudo apt install lynx -y || \
#   echo "Not installing..." && return 1
_confirm_install_again(){
    _installed $@ && _confirm ">> $@ Already Installed, do you want to reinstall ?" echo
}

# for all git + fzf commands
export GIT_FZF_DEFAULT_OPTS="
	$FZF_DEFAULT_OPTS
	--ansi
	--reverse
	--height=100%
	--bind shift-down:preview-down
	--bind shift-up:preview-up
	--bind pgdn:preview-page-down
	--bind pgup:preview-page-up
	--bind q:abort
	$GIT_FZF_DEFAULT_OPTS
"

# _sleep 10
_sleep(){
    seconds=$1
    start="$(($(date +%s) + $seconds))"
    while [ "$start" -ge `date +%s` ]; do
        time="$(( $start - `date +%s` ))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 1
    done
}

alias tmux='tmux -f ~/.config/tmux/tmux.conf -2'

# some more ls aliases
alias ls='exa'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lss='ls'
alias sl='ls'
alias lsc='ls'
alias ld='ls -d */'
alias cb='xclip -selection clipboard' # copy to clipboard
alias co='xclip -o -selection clipboard' # get clipboard content
alias n='nordvpn connect'
alias mkdir='mkdir -p'
# This will create a directory if it doesn't exist
# And paste into it (cpd instead of normal cp to differentiate those)
_cpd(){
    mkdir -p "$(dirname ${@: -1})" && cp -r $@
}
alias cpd=_cpd

IS_ENV_SET(){
    GIVEN_ENV=$0
    DEFAULT_VALUE=$1

    # IS_ENV_SET $OUPS "default value"
    [[ "$GIVEN_ENV" -ne "" ]] && echo "$GIVEN_ENV" || echo "$DEFAULT_VALUE"
}

EXTRACT_REGEX(){
    string=$1
    regex=$2

    if [[ $string =~ $regex ]]; then
        # and yeah btw, the BASH_REMATCH variable is an array
        # that is automatically populated by the [[ ]]
        # double bracket conditional expression when using
        # the =~ operator to match a regular expression pattern.
        extracted_number="${BASH_REMATCH[1]}"
        echo "$extracted_number"
    else
        echo ""
    fi
}

# some virtualenv python stuffs
alias ee='source *env*/bin/activate'
# to fix distlib
# pip install --upgrade --force-reinstall distlib
# to fix package
# No module named 'packaging.metadata'
# pip install --upgrade setuptools wheel && pip install --upgrade packaging
alias ee_install_debuglibs="pip install -U poetry ipdb debugpy"
alias v12='python3.12 -m venv env'
alias v11='python3.11 -m venv env'
alias v10='python3.10 -m venv env'
alias v8='python3.8 -m venv env'
alias de='deactivate'
alias p='python3'
# alias python='python3.11'
# alias python3='python3.11'
# the default size installed by default sucks
alias size='du -sh'

# the lock command
alias lo='gnome-screensaver-command -l'

if [ -f ~/.bash_work_aliases ]; then
    . ~/.bash_work_aliases
fi

# To mkdir a directory and cd into it
# md path
_md(){
    mkdir $1 && cd $1
}
alias md=_md

# Touch but create recursivelly paths if they don't exist already
# _touchd /not/existing/yet/file1.y ~/.not/existing/file2.x
_touchd(){
    for i in ${@}; do
        dir_path="$(dirname $i)"
        file_name="$(basename $i)"

        _echo_black "On '$dir_path'"
        mkdir -p $dir_path

        _echo_black "Creating '$file_name'"
        touch $dir_path/$file_name
    done;
}
alias touchd=_touchd

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

# I want to run git status as soon as i get inside a git folder
# (love this btw)
_git_status_if_git_repo(){
    # if the .git is present, then run git status
    if [[ -d ".git" ]]; then
        # interesting to get up to date cron job to update the repo
        # git maintenance start # <-- comment this after
        git status
    fi
}
# overrided the cd command with the zoxide command line
# But let's do that only we're sure zoxide is installed properly
_magic_cd(){
    # zoxide and git status if it's a .git project
    # added a fallback in case of errors
    z $@ && _git_status_if_git_repo || cd
}
$(command -v zoxide > /dev/null) && [[ $? == 0 ]] && alias cd='_magic_cd'

# Another amazing cd with fzf
cdd() {
    local sel="$(zoxide query --list --score | fzf -n2 --reverse --query "$*" | head -1 | tr -s ' ' | sed 's/^\s\+//' | cut -d' ' -f2)" || return 1
	cd "$sel"
}

# Kill a process running on a specific port
_killport(){
    sudo kill -9 $(sudo lsof -t -i:$1)
}
alias killport=_killport

# To list processes running on a specific port
_lsport(){
    sudo ss -lptn "sport = :$1"
}
alias lsport=_lsport

_search_isos(){
    # you can obtain more iso here :
    # - http://iso.linuxquestions.org/
    # - https://www.linuxlookup.com/linux_iso

    local selected_link=$(cat <<EOF | fzf
https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-12.5.0-amd64-DVD-1.iso
http://ftp.pasteur.fr/mirrors/CentOS/7.9.2009/isos/x86_64/CentOS-7-x86_64-Everything-2009.iso
http://ftp.pasteur.fr/mirrors/CentOS/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2207-02.iso
https://distro.ibiblio.org/damnsmall/current/dsl-4.4.10-syslinux.iso
https://arch.mirror.winslow.cloud/iso/2024.03.01/archlinux-2024.03.01-x86_64.iso
https://download.fedoraproject.org/pub/fedora/linux/releases/39/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-39-1.5.iso
https://cdimage.kali.org/kali-2024.1/kali-linux-2024.1-installer-amd64.iso
https://cdimage.ubuntu.com/kubuntu/releases/22.04.4/release/kubuntu-22.04.4-desktop-amd64.iso
EOF
)

    if [ -n "$selected_link" ]; then
        cd ~/Downloads/
        local filename=$(basename $selected_link)
        _confirm "> Download $filename ?" wget $selected_link
        cd -
    fi
}

# git search on any history of a repository
# s or search
# gf s 'function name or any word you have in mind'
# # To open the file at that line :
# # o or open
# gf o 'commit_id:file_name:line'
#
# wget https://gist.github.com/Sanix-Darker/e571c1fdc2d0a5ecdb9959fecaa3416a -o ~/gf.sh
# chmod +x ~/gf.sh
alias gf=$HOME/gf.sh

# My custom build of scrcpy
alias scrcpy='/usr/local/bin/scrcpy -m1024'

# slides for running powepoint on my terminal.
alias s='slides'


# Toast alert message to notify on some events...
#
# To install :
#     sudo apt-get install libnotify-bin \
#         notify-osd \
#         xfce4-notifyd -y
#
# Usage: alert "Hello there, am dk"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# for nvim shortcuts
alias v='nvim'
# alias v='nvim -c "so ~/.config/nvim/init.lua"'
alias nv='v'
# for no user configuration
alias vclean='vim --clean'
alias nvclean='v --clean'
# we could use the trash-cli to rf or rm-rf

# to list trash elements
_lf(){
    # list all trash delete elements and grep pipe to list all item deleted
    # referenced only by the directory i am at the moment this command
    trash-list | sort -r | cat | grep $(pwd)
}
alias lf='_lf'

# to put inside the trash
alias rf='trash-put'

# recursivelly put inside the trashbin something
_rfr(){
    # search for $1 and rf it
    find . -name ''$1'' -type d -prune -exec trash-put '{}' +
}
alias rfr='_rfr'
# To delete from trash
alias rrf='trash-rm'
# to empty the trans
alias rrff='trash-empty'
# to restore an item
alias rr='trash-restore'
alias hs='http-server -o'
alias i='ipython3'
# To refresh stuff with source on bash alialses and bashrc itself
alias so='source ~/.bashrc'

# To list running services
alias services='systemctl list-units --type=service'

_set_nvim(){
    # copy nvim configs
    mkdir ~/.config/nvim/
    cpd $DOT_DIR/nvim/{lua,init.lua,config.vim,autoload} ~/.config/nvim/

    _confirm "Install nvm (you kinda need it for LSPs...)?" _install_nvm
    _confirm "Make nvm use 20... ?" nvm use 20

    # To install new stuffs if some of them were missing
    # FIXME: This is not stable, will fix it later
    # nvim --headless +PlugInstall +qall

    # yeah, we removed coc-nvim in favor of LSP
    lsp_conf=(
        "pyright" "ts-server" "vscode-langservers-extracted"
        "bash-language-server" "cssmodules-language-server"
        "dockerfile-language-server-nodejs" "emmet-ls"
        "graphql-language-service-cli" "typescript-language-server"
    )
    for i in "${lsp_conf[@]}"
    do
        echo "Installing LSP for $i..."
        npm install -g $i --user
    done

    # pour arduino
    # go install github.com/arduino/arduino-language-server@latest
}


# Assuming we already have the dotfiles directory
# on our workspace
_set_dot_files(){
    # for my bash stuffs
    cpd $DOT_DIR/{.bashrc,.bash_aliases} ~/

    # my vagrant stuffs
    cpd $DOT_DIR/vagrant/vms/ ~/vagrant/

    # we copy our ranger configuration
    cpd $DOT_DIR/ranger ~/.config/ranger

    # greenclip configuration
    cpd $DOT_DIR/greenclip.toml ~/.config/greenclip.toml

    # tmux config
    cpd $DOT_DIR/tmux/tmux.conf ~/.config/tmux/tmux.conf

    # gh-dash config
    mkdir -p ~/.config/gh-dash
    cpd $DOT_DIR/gh-dash/config.yml ~/.config/gh-dash/config.yml

    for path in "${CONFIG_PATHS[@]}"; do
        echo "Copy of '$DOT_DIR/$path' in ~/.config/..."
        cpd $DOT_DIR/$path/ ~/.config/
    done

    # set up nvim or not as a conditional
    _confirm "Set up nvim (you need a good node/npm (nvm) available) ?" _set_nvim

    # we return on our previus directory
    cd -
}

_copy_to_dotfiles(){
    # copy my bash-working stuff to ~/ssh
    cpd ~/.bash_work_aliases ~/ACTUALC/ssh/

    # nvim stuffs
    # We prevent copying plugins git based repositories too.
    cpd ~/.config/nvim/{lua,init.lua,config.vim,autoload} $DOT_DIR/nvim/

    # for my bash stuffs
    cpd ~/{.bashrc,.bash_aliases} $DOT_DIR/

    # my vagrant stuffs
    cpd ~/vagrant/vms/ $DOT_DIR/vagrant/

    # For ranger configurationss
    # to avoid copying plugins directories
    cpd ~/.config/ranger/{commands.py,rifle.conf,rc.conf,colorschemes} $DOT_DIR/ranger

    # greenclip configuration
    cpd ~/.config/greenclip.toml $DOT_DIR/greenclip.toml

    # tmux config
    cpd ~/.config/tmux/tmux.conf $DOT_DIR/tmux/tmux.conf

    # gh-dash configuration
    mkdir -p $DOT_DIR/gh-dash
    cpd ~/.config/gh-dash/config.yml $DOT_DIR/gh-dash/config.yml

    # we copy directories that needs to be copied
    for path in "${CONFIG_PATHS[@]}"; do
        echo "Copy of '~/.config/$path' in $DOT_DIR/..."
        cpd ~/.config/$path/ $DOT_DIR/
    done
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
    if [[ ! -d $DOT_DIR ]]; then
        git clone https://github.com/Sanix-Darker/dotfiles
    else
        cd $DOT_DIR && git pull
    fi
}

_source_dev_stack(){
    sudo add-apt-repository ppa:regolith-linux/release \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" &&\
    apt-get update -y
}

_set_gnome_dark_theme(){
    echo -ne "[Settings]\n gtk-application-prefer-dark-theme=1" > ~/.config/gtk-3.0/settings.ini
}

_install_android_studio(){
    sudo add-apt-repository ppa:maarten-fonville/android-studio -y
    sudo apt-get update -y
    sudo apt-get install openjdk-11-jdk \
        android-studio \
        android-tools-adb \
        android-tools-fastboot -y
}

_install_virtualbox(){

    _confirm_install_again virtualbox || return 0

    cd /tmp

    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    sudo apt-get install virtualbox-6.1 -y
    wget https://download.virtualbox.org/virtualbox/6.1.8/Oracle_VM_VirtualBox_Extension_Pack-6.1.8.vbox-extpack
    sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.8.vbox-extpack

    cd -
}

_install_vagrant(){
    _confirm_install_again vagrant || return 0

    cd /tmp
    sudo apt-get update -y
    # Install virtualbox
    _confirm "Install Virtualbox ?" _install_virtualbox
    # Install vagrant and it's stuff
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    wget https://releases.hashicorp.com/vagrant/2.2.19/vagrant_2.2.19_x86_64.deb
    sudo apt install ./vagrant_2.2.19_x86_64.deb -y
    vagrant --version

    cd -
}

_install_alacritty(){
    _confirm_install_again alacritty || return 0

    sudo apt-get update -y

    curl https://sh.rustup.rs -sSf | sh
    # we install alacritty as our terminal
    sudo apt-get install cmake pkg-config \
        libfreetype6-dev libfontconfig1-dev \
        libxcb-xfixes0-dev libxkbcommon-dev -y

    echo "[x] cargo install allacrity..."
    cargo install alacritty

    _confirm"[x] nvm use 20..." nvm use 20

    echo "[x] npm install alacritty-themes..."
    # for theming
    npm i -g alacritty-themes

    # For updating to the latest version
    # cd /tmp
    # git clone https://github.com/alacritty/alacritty.git
    # cd alacritty
    # cargo build --release
    # sudo cp ./target/release/alacritty $(which alacritty)
}

# faster linker than ld
_install_mold(){

    _confirm_install_again mold || return 0

    # /usr/bin/ld was binded to : lrwxrwxrwx 19 root  4 déc.  11:57 /usr/bin/ld -> x86_64-linux-gnu-ld
    cd /tmp

    if [ ! -d mold ]; then
        git clone https://github.com/rui314/mold.git
    fi;

    cd mold && mkdir -p build && cd ./build

    git checkout v2.4.0
    sudo ../install-build-deps.sh && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=c++ ..
    cmake --build . -j $(nproc) && sudo cmake --build . --target install
}

_cargo_update(){
    cargo install cargo-update
    cargo install-update -a
    cargo --version
}

_install_path_browsing_utils(){
    sudo apt-get update -y

    # we install zoxide for fast cd
    curl -sS https://webinstall.dev/zoxide | bash;
    # installing rust and exa (for ls/ll)
    curl https://sh.rustup.rs -sSf | sh

    sudo wget -c https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
    sudo unzip exa-linux-x86_64-0.8.0.zip
    sudo mv exa-linux-x86_64 /usr/local/bin/exa
    sudo rm -rf exa*.zip
    _confirm "Install batCat (require cargo (but should be available at this step)) ?" _install_batcat
    # putting this in comment for now
    _confirm "Install yazi(file browser on terminal) ?" _install_yazi
}

_install_nvim(){
    # FIXME: i downgraded because, the preview of fzf is not working anymore on 0.10.0
    # VERSION="nightly"
    local version="v0.9.0"

    echo "[-] -----------------------------------"
    echo "[-] Current version : $(nvim --version)"
    cd /tmp
    rm -rf ./nvim-linux64*
    wget https://github.com/neovim/neovim/releases/download/$version/nvim-linux64.tar.gz
    tar -xzvf ./nvim-linux64.tar.gz
    # we delete existing stuffs
    sudo rm -rf /usr/local/bin/nvim
    sudo rm -rf /usr/local/lib/nvim
    sudo rm -rf /usr/local/share/nvim
    # we move dirs
    sudo mv ./nvim-linux64/bin/* /usr/local/bin/
    sudo mv ./nvim-linux64/lib/* /usr/local/lib/
    sudo mv ./nvim-linux64/share/nvim /usr/local/share/

    # Since installing from source is for better performances
    # cd /tmp
    # git clone https://github.com/neovim/neovim
    # cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
    # sudo make install

    echo "[-] Installed version : $(nvim --version)"
    echo "[-] -----------------------------------"
}

# NOTE : DEPRECATED, use _install_nvm
_install_node_stuffs(){
    _confirm_install_again nvm || return 0

    mkdir /home/dk/.nvm

    sudo apt-get update -y
    sudo apt-get install nodejs npm -y
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    echo "[x] nvm installing stable version..."

    nvm install 20 && nvm use 20
    # source $HOME/.bashrc
    # source $HOME/.bash_aliases
    # $(command -v nvm > /dev/null) && [[ $? == 0 ]] && nvm install stable
}

_install_ctags_universal(){
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    # you may need sudo here depending on the user installing it
    make install
    ctags --version && [[ $? != 0 ]] && _echo_red "\n[+] ctags installation failed !"
}

_install_nvim_and_utils(){
    sudo apt-get update -y

    # For neovim we get the latests nightly version
    _confirm "Install the latest nvim nightly release ?" _install_nvim

    # not needed anymore (thanks to LSP).
    # To install CocInstall, we need nodejs
    # _confirm "Install the nodejs, npm and nvm ? " _install_node_stuffs

    # To install ctags( the universal one) for vista plugins
    # _confirm "Install ctags (universal) ?" _install_ctags_universal
}

_install_python_stuffs(){
    # ok, since deadsnakes is not available on ubuntu20.10 and
    # it's the distro am on at the moment, i have to use another
    # way to install python
    # VERSION=3.11.5

    # cd /tmp
    # echo "Installing Python$VERSION..."
    # wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz
    # tar xvf Python-$VERSION.tgz
    # cd Python-$VERSION
    # ./configure --enable-optimizations --enable-shared --with-ensurepip=install
    # make -j8
    # sudo make altinstall

    # echo "Python/Pip $VERSION installed successfully !"
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt-get update -y
    devStack=(
        "python3.10" "python3.11" "python3.12"
        "python3-dev" "python3-pip"
        "python3-setuptools"
        "python3-testresources"
        "python3-distutils"
        "python3.8-dev"
        "python3.10-dev"
        "python3.11-dev"
        "python3.12-dev"
        "python3-sphinx "

        # for venv stuffs (Important)
        "python3.8-venv"
        "python3.10-venv"
        "python3.11-venv"
        "python3.12-venv"
    )
    for i in "${devStack[@]}"
    do
        _echo_green "\n[-] Installing $i..."
        sudo apt-get install $i -y && \
            _echo_black "Installed $i successfully !" || \
            _echo_red "error installing $i"
    done

    _echo_black ">> Installing Pip(s) versions..."
    # To install multiple pip version
    pipToInstall=("3.8" "3.10" "3.11" "3.12")
    for pV in "${pipToInstall[@]}"; do
        curl -sS https://bootstrap.pypa.io/get-pip.py | python$pV
    done;
 }

_install_mpv(){
    _confirm_install_again mpv || return 0
    sudo apt update -y

    _echo_blue "> Installing mpv..."
    sudo apt install mpv -y

    _confirm_install_again yt-dlp || return 0
    # To install the youtube/mpv
    _echo_blue "> Installing yt-dlp_linux..."
    cd /tmp
    # let's fix yt-dlp and mpv versions
    wget https://github.com/yt-dlp/yt-dlp/releases/download/2023.12.30/yt-dlp_linux
    sudo chmod +x ./yt-dlp_linux && sudo mv ./yt-dlp_linux /usr/bin/yt-dlp

    cd -
}

_install_polybar(){
    _confirm_install_again polybar || return 0

    cd /tmp
    sudo apt update -y

    sudo apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev \
    libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev \
    libxcb-xkb-dev pkg-config xcb-proto libxcb-xrm-dev i3-wm \
    libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev \
    libxcb-cursor-dev libxcb-xinerama0-dev libxcb-cursor-dev libpulse-dev \
    libxcb-composite0-dev xcb libxcb-ewmh2 libuv1.dev python3-xcbgen libjsoncpp-dev -y

    git clone --recursive https://github.com/polybar/polybar && cd polybar

    mkdir build && cd build
    cmake ..
    make -j$(nproc)
    sudo make install
}

_install_i3_lock(){
    cd /tmp
    git clone https://github.com/Raymo111/i3lock-color.git
    cd i3lock-color
    chmod +x ./install-i3lock-color.sh
    ./install-i3lock-color.sh
}

_install_i3_navigation(){
    sudo apt-get install feh rofi arandr -y
}

_install_i3(){
    # another alternative
    # after downloading a release here : https://i3wm.org/downloads/
    # follow theses stemsp with meson
    _confirm "Install polybar ?" _install_polybar

    # To install i3 from source (will be compiled)
    sudo apt-get install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
        libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev \
        libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev \
        libxkbcommon-dev libxkbcommon-x11-dev libxcb-shape0-dev \
        ninja-build meson -y
    cd /tmp && wget https://github.com/i3/i3/archive/stable.tar.gz
    tar xzf stable.tar.gz && rm -rf stable.tar.gz
    cd i3-stable && mdir build
    cd build
    meson --prefix=/usr/local/ ..
    ninja
    sudo ninja install

    # Install i3 lock.
    _confirm "Install i3-lock ?" _install_i3_lock
    # For image manipulation and rofi for the fast search windows
    # arandr is for managing the xrandr for monitors
    _confirm "Install rofi/feh/arandr ?" _install_i3_navigation
    # Install greenclip for clipboard history
    _confirm "Install greenclip for clipboard history, depends on rofi ?" _install_greenclip

    # install autolock
    sudo apt-get install xautolock -y
}

_install_delta(){
    _confirm_install_again delta || return 0

    sudo wget https://github.com/dandavison/delta/releases/download/0.12.1/git-delta_0.12.1_amd64.deb && \
    sudo apt-get install ./git-delta_0.12.1_amd64.deb -y
}

_install_FZF(){
    # Yes i have my own version for searching on tmux session
    # + history based on the directory and some other cools stuffs
    git clone --depth 1 https://github.com/Sanix-Darker/fzf.git ~/.fzf && \
    cd ~/.fzf/
    git fetch origin me && git checkout me

    _echo_green "Installing fzf ~/.fzf/install: "
    ~/.fzf/install # [me] is my special branch btw (with my custom bindings over there).
    # go back to the previous dir
    cd -
}

_install_locales_lang(){
    sudo apt-get update -y
    sudo locale-gen en_GB.UTF-8 && \
    dpkg-reconfigure locales
}

_install_greenclip(){
    _confirm_install_again greenclip || return 0

    wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
    sudo mv ./greenclip /usr/local/bin/
    # we add rights for rofi to run it
    sudo chmod +x /usr/local/bin/greenclip
    # we need to spawn the daemon
    nohup greenclip daemon &
}

# NOTE: DEPRECATED (I use this on my own branch on fzf directly).
_install_tt(){
    # a fast switcher for sessions and panel inside tmux
    cd ~
    curl https://raw.githubusercontent.com/27medkamal/tmux-session-wizard/master/session-wizard.sh
    sudo cp ./session-wizard.sh /usr/local/bin/t
}

_install_clang(){
    cd /tmp
    git clone --depth=1 https://github.com/llvm/llvm-project.git
    cd llvm-project
    mkdir build && cd build
    cmake -DLLVM_ENABLE_PROJECTS=clang -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release  ../llvm
    make -j$(nproc)

    # Install clang-format too
    sudo apt-get install clang-format -y
}

_install_tmux(){
    echo "Installing yacc (flex and bison)..."
    sudo apt-get install bison flex -y

    # VERSION="3.1c" # i need something fast ABEK
    local version="3.4" # because i can
    # VERSION="master-0.0.1" # for my custom fork just to get all tmux updates so far
    local where_i_was=$PWD

    _echo_blue "> Installing tmux $version..."
    # A requirement for the compilation of tmux
    sudo apt install libevent-dev -y
    cd /tmp

    # getting tmux only if it's not yet downloaded
    if [ ! -f "tmux-${version}.tar.gz" ]; then
        _echo_blue "> Getting tmux $version..."
        wget https://github.com/tmux/tmux/archive/refs/tags/${version}.tar.gz -O "tmux-${version}.tar.gz"
        tar xf tmux-${version}.tar.gz #&& rm -f tmux-${VERSION}.tar.gz
    fi;

    _echo_blue "> Compile tmux $version..."
    cd tmux-${version}
    bash ./autogen.sh && ./configure && make && sudo make install

    _echo_blue "> Set to appropriate path v$version..."
    cd -
    sudo mv tmux-${version} /usr/bin/tmux

    # to be sure we deleted all processes related to the old version
    sudo killall -9 tmux

    cd $where_i_was

    if [ ! -d "~/.tmux/plugins/tpm" ]; then
        _echo_blue "> Installing tpm..."
        git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
    fi;
}

# for github action locally
_install_act(){
    # we install it using the bash command line
    curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
    # Looks like we need to move the ./bin/act to /usr/local/bin/
    sudo mv ./bin/act /usr/local/bin/act

   _confirm ">Install gh ?" _install_gh

    # to use gh act
    gh extension install nektos/gh-act
}

_install_dash(){
    _echo_blue "[x] install gh..."
   _confirm ">Install gh ?" _install_gh

    _echo_blue "[x] Install dash..."

    gh extension remove dlvhdr/gh-dash
    gh extension install dlvhdr/gh-dash
}

_install_yq(){
    _confirm_install_again yq || return 0

    local version=v4.2.0
    local binary=yq_linux_amd64

    cd /tmp
    wget https://github.com/mikefarah/yq/releases/download/${version}/${binary}.tar.gz -O - |\
        tar xz && sudo mv ${binary} /usr/bin/yq
    cd -
}

_install_zathura(){
    _confirm_install_again zathura || return 0

    sudo apt-get update -y
    sudo apt-get install zathura -y
}

_install_docker(){
    _confirm_install_again docker || return 0

    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -y && sudo apt-cache policy docker-ce

    sudo apt install docker-ce -y
    sudo systemctl status docker

    _echo_green ":::READ THIS LAZY BOY::: Now to make in run without sudo, please check for the instructions"
    _echo_red "> sudo groupadd docker"
    _echo_red "> sudo usermod -aG docker ${USER}"
    _echo_red "> newgrp docker"
    _echo_red "> docker ps (does it works ?) if not, continue with the list below"
    _echo_red "> ls -l /var/run/docker.sock"
    _echo_red "> sudo chmod 666 /var/run/docker.sock"
    _echo_red "> sudo systemctl restart docker"
}

_install_docker_compose(){
    _confirm_install_again docker-compose || return 0

    _xx cd /tmp
    _xx sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    _xx sudo chmod +x /usr/local/bin/docker-compose
    _xx sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    _xx docker-compose --version
    _xx cd -
}

_install_glow(){
    _confirm_install_again glow || return 0
    # markdown previewer
    go install github.com/charmbracelet/glow@latest
}

_install_rust(){
    _confirm_install_again rustc || return 0

    _echo_blue "> Installing rustc and cargo..."

    sudo apt update -y && sudo apt upgrade -y
    sudo apt install -y curl gcc make build-essential

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # To check the rust version installed
    rustc --version
}

_install_java(){
    _confirm_install_again java || return 0

    sudo apt update -y
    sudo apt install default-jre default-jdk -y

    java -version

    # sudo update-alternatives --config java
}

_install_ruby(){
    _confirm_install_again ruby || return 0

    local version="3.2.2" # boff, looks like this does the job

    sudo apt update -y
    sudo apt install libssl-dev \
        libreadline-dev zlib1g-dev autoconf \
        bison build-essential libyaml-dev \
        libreadline-dev libncurses5-dev libffi-dev \
        libgdbm-dev -y

    _echo_blue "> Going to install ruby v$version"
    _echo_blue "> Downloading the ruby tar file..."
    cd /tmp
    wget https://cache.ruby-lang.org/pub/ruby/3.2/ruby-$version.tar.gz
    tar -xzvf ruby-$version.tar.gz
    cd ruby-$version

    _echo_blue "> make installing..."
    ./configure && make && sudo make install

    ruby --version
}

_install_golang(){
    _confirm_install_again go || return 0
    #sudo apt update -y && sudo apt upgrade -y
    #sudo apt install golang-go -y # it's install 1.13

    # force installation of go1.21
    local version="1.22.0"
    _echo_blue "> Installing golang v${version}..."
    cd /tmp || exit
    sudo apt-get update -y
    wget "https://golang.org/dl/go${version}.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "go${version}.linux-amd64.tar.gz"
    source ~/.bashrc

    # To check the golang version installed
    go version
    cd -
}

_install_arduino_language_server(){
    cd /tmp

    git clone https://github.com/arduino/arduino-language-server && cd ./arduino-language-server
    go build
    sudo cp ./arduino-language-server /usr/bin/arduino-language-server
    sudo chmod +x /usr/bin/arduino-language-server

    arduino-language-server version
    cd -
}

_install_golang_specific_version(){
    if [ -z $GOLANG_VERSION_TO_INSTALL ]; then
        echo "< error: you need to set 'export GOLANG_VERSION_TO_INSTALL=1.xx.x' to run this command."
        return
    fi;

    _echo_blue "> Installing golang version '$GOLANG_VERSION_TO_INSTALL'"

    cd /tmp
    wget https://golang.org/dl/go$GOLANG_VERSION_TO_INSTALL.linux-amd64.tar.gz
    sudo mkdir /usr/local/go$GOLANG_VERSION_TO_INSTALL
    sudo tar -xf go$GOLANG_VERSION_TO_INSTALL.linux-amd64.tar.gz -C /usr/local/go$GOLANG_VERSION_TO_INSTALL

    _echo_blue "> Available now on /usr/local/go$GOLANG_VERSION_TO_INSTALL/go/bin/go"
    /usr/local/go$GOLANG_VERSION_TO_INSTALL/go/bin/go version
    sudo ln -s /usr/local/go$GOLANG_VERSION_TO_INSTALL/go/bin/go /usr/bin/go$GOLANG_VERSION_TO_INSTALL

    # echo "export PATH=$$PATH:/usr/local.go/bin" > ~/.bashrc
    # we get back to our previous dir
    cd -
}

_install_nerdfonts(){
    # Download here : https://github.com/source-foundry/Hackhttps://github.com/source-foundry/Hack
    # and then run : fc-cache -f -v
    # ----
    _echo_blue "Note: Sometimes it's '/usr/share/fonts/', so check there if this installation failed."
    _echo_black "cd /tmp"
    cd /tmp

    _echo_blue ">> wget Hack ( don't forget to rename that to Hack since it's what inside alac."
    sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.0/Hack.zip > /dev/null

    _echo_blue "< cd /usr/local/share/fonts/ ... and mv /tmp/Hack.zip..."
    cd /usr/local/share/fonts/ && sudo mv /tmp/Hack.zip .

    _echo_blue ">> Unzip Hack.."
    sudo unzip Hack.zip && sudo mkdir Hack && sudo cp HackNerdFont* ./Hack/

    _echo_blue ">> Copy Hack from /usr/local/share/fonts/Hack to /usr/share/fonts/..."
    sudo cp -r ./Hack /usr/share/fonts/

    _echo_blue ">> Installing the ttf..."
    fc-cache -f -v

    cd -
}

_install_gh(){
    _confirm_install_again gh || return 0

    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
        sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

    sudo apt update -y
    sudo apt install gh -y

    gh version
}

# official cli for spicedb
# _install_zed(){
#     sudo apt update -y && sudo apt install -y curl ca-certificates gpg
#     curl https://apt.fury.io/authzed/gpg.key | sudo apt-key add -
#     echo "deb https://apt.fury.io/authzed/ * *" > /etc/apt/sources.list.d/fury.list
#     # then we install
#     sudo apt update -y && sudo apt install -y zed
# }

# To install stuffs for notifications
_install_notifications(){
    sudo apt-get install libnotify-bin \
        notify-osd \
        xfce4-notifyd -y
}

# To install insomnia (i hate this thing)
_install_insomnia(){
    _confirm_install_again insomnia || return 0

    sudo snap install insomnia
}

# To install protoc for compiling proto-buf .proto files
_install_protoc(){
    _confirm_install_again protoc || return 0

    sudo apt update -y
    sudo apt install protobuf-compiler -y

    # The protoc-gen-go plugin is needed
    go install github.com/golang/protobuf/protoc-gen-go@latest

    protoc --version
}

_install_zed(){
    _confirm_install_again zed || return 0

    cd /tmp
    wget https://github.com/authzed/zed/releases/download/v0.15.0/zed_0.15.0_linux_amd64.deb
    sudo apt-get install ./zed_0.15.0_linux_amd64.deb -y
    cd -

    zed version
}

_install_kdenlive(){
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test
    sudo apt-get update

    # requirement needed to use it
    _echo_black "> Installing libstdc++6..."
    sudo apt-get install libstdc++6

    _echo_black "> Downloading the kdenlive appimage..."
    cd ~/Downloads/
    wget https://download.kde.org/stable/kdenlive/23.08/linux/kdenlive-23.08.2-x86_64.AppImage
    chmod +x ./kdenlive-23.08.2-x86_64.AppImage
    cd -
}

_install_lazydocker(){
    _confirm_install_again lazydocker || return 0
    go install github.com/jesseduffield/lazydocker@latest
}

_install_lazygit(){
    _confirm_install_again lazygit || return 0
    go install github.com/jesseduffield/lazygit@latest
}

_install_yarn(){
    _confirm_install_again yarn || return 0
    npm install -g yarn
}

_install_nvm(){
    _confirm_install_again nvm || return 0

	mkdir ~/.nvm

	sudo apt install curl -y
	curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

    _echo_green "> nvm install node bins" && nvm install node
    _echo_green "> nvm install node v16" && nvm install 16
    _echo_green "> nvm install node v8" && nvm install 18

    _confirm "Install Yarn with npm ?" _install_yarn
}

_set_cat_bg(){
    cp ~/dotfiles/bg.jpg ~/bg2.jpg
}

_fix_ssh_key(){
    chmod 600 $HOME/.ssh/id_ed25519
}

# for git, generate or get
_generate_gpg_keys(){
    GPG_KEY=$(gpg --list-secret-keys --keyid-format LONG | awk '/^sec/ { getline; print $1 }')
    if [ -z $GPG_KEY ]; then
        _echo_black "Not seeing a key for $GPG_KEY."
        gpg --full-generate-key
    fi;
    _echo_black "Generated public key for $GPG_KEY:"
    gpg --armor --export $GPG_KEY
}

_install_firefox(){
    _echo_red "Go there : https://www.mozilla.org/en-US/firefox/new/ and download the .deb"

    _confirm "Did you downloaded it ? the installation will take it from your ~/Downloads dir" echo "Good."

    cd ~/Downloads/ && tar xvf firefox-*.tar.bz2

    # Yes am going to put it there.
    sudo mkdir -p /opt/firefox/
    sudo cp -r ./firefox /opt/firefox/
    # just in case, we delete the existing one that may be present
    sudo rm -rf /usr/bin/firefox
    # we create the symbolic link to that opt bin
    sudo ln -s /opt/firefox/firefox/firefox /usr/bin/firefox

    # We clean
    # rm -rf firefox-*.tar.bz2 firefox
    cd -
}

_install_slack(){
    _confirm_install_again slack || return 0

    _echo_red "Go there : https://slack.com/intl/en-in/downloads/linux and download the .deb"

    _confirm "Did you downloaded it ? the installation will take it from your ~/Downloads dir" echo "Good."
    sudo apt install ~/Downloads/slack-desktop-*-amd64.deb
}

_install_thunderbird(){
    _confirm_install_again thunderbird || return 0

    sudo add-apt-repository ppa:mozillateam/thunderbird-next
    sudo apt update -y
    sudo apt install thunderbird -y
}

_install_telegram(){
    _echo_red "Go there : https://telegram.org/dl/desktop/linux and download the linux version"

    _confirm "Did you downloaded it ? the installation will take it from your ~/Downloads dir" echo "Good."
    cd ~/Downloads/
    tar -xf ./tsetup.*.tar.xz
    cd ./Telegram && ./Telegram &
}

_install_mkcert(){
    _confirm_install_again mkcert || return 0

    sudo apt-get install wget libnss3-tools -y

    cd /tmp
    wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64
    sudo mv mkcert-v1.4.3-linux-amd64 /usr/bin/mkcert
    sudo chmod +x /usr/bin/mkcert
    cd -

    mkcert --version
}

_install_yazi(){
    _confirm_install_again yazi || return 0

    # rust toolchain installation
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # then install yazi-fm
    cargo install --locked yazi-fm

    yazi --version
}
alias ranger='yazi'

_install_picocom(){
    _confirm_install_again picocom || return 0
    sudo apt-get install picocom -y
}

_install_arduino_cli(){
    cd /tmp
    wget https://github.com/arduino/arduino-cli/releases/download/v0.35.2/arduino-cli_0.35.2_Linux_64bit.tar.gz
    tar -xzf ./arduino-cli_0.35.2_Linux_64bit.tar.gz
    sudo cp ./arduino-cli /usr/bin/arduino-cli
    sudo chmod +x /usr/bin/arduino-cli
    sudo chown -R $USER /usr/bin/arduino-cli

    # install picocom
    _confirm "Install picocom to comunicate with COM(USBs) ?" _install_picocom

    # update indexes
    arduino-cli core update-index
    # install common cores
    arduino-cli core install esp32:esp32 arduino:esp32 arduino:avr

    # to list all board fqn
    # arduino-cli board listall

    # then depending on the board
    # compile with :
    # arduino-cli compile --fqbn esp32:esp32:esp32cam tcha

    # now you can list all connected board with
    # arduino-cli board list

    # and upload the code with
    # arduino-cli upload -p /dev/ttyUSB0 --fqbn esp32:esp32 my_sketch
    cd -
}

_new_arduino_sketch(){
    # python side for serial
    v11 && ee
    pip uninstall serial; pip install pyserial

    arduino-cli sketch new test.ino
}

_install_vimiv(){
    # to install another image viewer
    sudo add-apt-repository ppa:enjoy-digitalguy/vimiv
    sudo apt-get update -y
    sudo apt-get install vimiv -y
}

_install_nsxiv(){
    # an image preview for windows managers
    _confirm_install_again nsxiv || return 0

    cd /tmp
    git clone https://github.com/nsxiv/nsxiv.git && cd nsxiv
    make && sudo make install

    nsxiv --version
    cd -
}

_install_grpcurl(){
    _confirm_install_again grpcurl || return 0

    cd /tmp
    curl -LO "https://github.com/fullstorydev/grpcurl/releases/download/v1.8.9/grpcurl_1.8.9_linux_x86_64.tar.gz"
    tar xzf grpcurl_1.8.9_linux_x86_64.tar.gz
    sudo mv grpcurl /usr/local/bin/
    cd -

    grpcurl --version
}

_install_balena_etcher(){
    # to run : sudo balena-etcher --no-sandbox
    cd /tmp
    wget https://github.com/balena-io/etcher/releases/download/v1.19.5/balena-etcher_1.19.5_amd64.deb
    mv ./balena-etcher_1.19.5_amd64.deb ./balena-etcher.deb
    sudo apt-get install ./balena-etcher.deb -y
    cd -
}

_install_drivers(){
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt update -y
    sudo apt upgrade -y
    sudo ubuntu-drivers autoinstall
    _confirm "reboot (recommended) ? " sudo reboot
}

_install_youtube_dl(){
    cd /tmp

    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl

    cd -
}

# to boot devices
_install_woeusb(){
    _confirm_install_again woeusb || return 0

    sudo add-apt-repository ppa:tomtomtom/woeusb -y
    sudo apt update -y
    sudo apt install woeusb woeusb-frontend-wxgtk -y
}

_install_peek(){

    _confirm_install_again peek || return 0

    sudo add-apt-repository ppa:peek-developers/stable
    sudo apt update -y
    sudo apt install peek -y
}

_install_raw_basics(){
    # sudo apt-get install type
    devStack=(
        "build-essential"
        "software-properties-common"
        "net-tools" "gnupg-agent"

        "curl" "wget" "tree" "jq"
        "apt-transport-https"
        "lsb-release" "ca-certificates"
        "neofetch"

        "cloc" "compton"

        "tmate" "git-lfs" "gh"
        "tar" "zip" "unzip" "curl"
        "gcc" "g++" "make"

        "mcomix" "unrar"
        "pavucontrol" "pulseaudio" "blueman" # audio and bluetooth

        # "docker" "docker-compose" (done from _install_docker)
        "git" "hub" "snap"
        # "zeal" # not needed as a basic installation, i may change that later
        "silversearcher-ag"
        "autoconf" "automake" "pkg-config"
        "libxml2-utils" "libfuse2" "libncurses-dev"
        "libldap2-dev" "libsasl2-dev"
        "libxml2-dev" "libxmlsec1-dev" "libxmlsec1-openssl"
        "libbz2-dev"
        "libjpeg-dev" "libpam0g-dev"
        "libx11-dev" "libimlib2-dev" "libxft-dev"
        "libexif-dev"

        "postgresql" "postgresql-contrib"
        "libpq-dev" "entr" "htop" "nvtop"

        "xcb-proto" "trash-cli"
        "python3-pynvim" "python3-virtualenv"

        "xclip" # for clipboard
    )
    for i in "${devStack[@]}"
    do
        _echo_green "\n[-] Installing $i..."
        sudo apt-get install $i -y && \
            _echo_black "[.]installed $i successfully !" || \
            _echo_red "[x]error installing $i"
    done
}

# a dumb forwarding.... needed
_install_cargo(){
    _install_rust "$@"
}

# a duckduckgo command line to search items
_install_ddgr(){
    _confirm_install_again ddgr || return 0
    sudo apt update -y
    sudo apt install ddgr -y
}
# Install obs on command line
_install_obs(){
    _confirm_install_again obs || return 0
    sudo apt update -y
    sudo add-apt-repository ppa:obsproject/obs-studio
    sudo apt install obs-studio -y
}

_install_basics(){
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt-get update -y

    # my fun bg
    _confirm "Set up the 'cat image background' to ~/ ?" _set_cat_bg
    # some apt utils
    _confirm "Install raw basics apt packages ?" _install_raw_basics
    # Install cargo's cat (bat)
    _confirm "Install bat (cat for cargo) ?" cargo install bat
    # Install tmux ?
    _confirm "Install tmux ?" _install_tmux
    # Install notifications
    _confirm "Install notification (alert...)" _install_notifications
    # Install nvm for node stuffs
    _confirm "Install nvm (node, npm, ...)?" _install_nvm
    # Install rustc and cargo + some random stuffs
    _confirm "Install rust stuffs ?" _install_rust
    _confirm "Install golang ?" _install_golang
    # Install yazi(ranger) like a file manager
    _confirm "Install yazi (like ranger) as a file manager ?" _install_yazi
    # set nerd-fonts
    _confirm "Install nerd-fonts (Hack) ?" _install_nerdfonts
    # needed for gcc linker
    _confirm "Install mold (ld faster version)" _install_mold
    _confirm "Install Docker ?" _install_docker
    _confirm "Install DockerCompose ?" _install_docker_compose
    # To manage or most importantly see what's going on on my running containers
    _confirm "Install lazyDocker ?" _install_lazydocker
    # Git UI not absolutelly required...
    _confirm "Install lazyGit ?" _install_lazygit

    # Install ddgr
    _confirm "Install ddgr (to search with duckduckgo on command line) ?" _install_ddgr

    # Install aerc (email client)
    # TODO config
    # sudo apt-get install scdoc libnotmuch-dev -y

    # SetUp and install tt
    # NOTE: DEPRECATED
    # _confirm "Install tt (For tmux fast jumping) ?" _install_tt
    # Install and build Clang
    _confirm "ARE YOU REALLY SURE, you want to Install clang (may broke build-essential on a different os (libc issues))?" _install_clang
    # A simple pdf reader from terminal with vim bindings
    _confirm "Install zathura (a pdf reader) ?" _install_zathura
    # Install and build Cling
    _confirm "Install cling (C REPL) ?" _install_cling
    # Install act
    _confirm "Install act (github actions locally) ?" _install_act
    # Install dash (git pr and issues from my terminal)
    _confirm "Install dash ?" _install_dash
    # Install FZF
    _confirm "Install FZF (require git) ?" _install_FZF
    # Install delta, a amzing tool for diff
    _confirm "Install delta for diff highlighting ?" _install_delta
    # nordvpn ?
    _confirm "Install nordvpn cli ?" _install_nordvpn
    # un cleaning to propre apres les basics installs
    _confirm "To clean apt stuffs with autoremove..." sudo apt autoremove -y
}

_install_FZF_POPUP(){
    # to have fzf popup inside tmux
    cd $HOME
    wget https://raw.githubusercontent.com/Sanix-Darker/fzf-tmux-script/me/popup/fzfp
    chmod +x ./fzfp

    # to just set up C-F to search for tmux available session
    # add this into ~/.fzf/shell/key-bindings.bash
    # __tmux_search__(){
    #     $HOME/t
    # }
    # if (( BASH_VERSINFO[0] < 4 )); then
    #   # CTRL-F - Paste the selected command from history into the command line
    #   bind -m emacs-standard '"\C-f": "\C-e \C-u\C-y\ey\C-u"$(__tmux_search__)"\e\C-e\er"'
    #   bind -m vi-command '"\C-f": "\C-z\C-f\C-z"'
    #   bind -m vi-insert '"\C-f": "\C-z\C-f\C-z"'
    # else
    #   # CTRL-F - tmux search session/window
    #   bind -m emacs-standard -x '"\C-f": __tmux_search__'
    #   bind -m vi-command -x '"\C-f": __tmux_search__'
    #   bind -m vi-insert -x '"\C-f": __tmux_search__'
    # fi
}
alias fzfp='$HOME/fzfp'

_install_batcat(){
    git clone https://github.com/sharkdp/bat
    cd bat
    # cargo should be already present for this to be installed
    cargo install --locked bat
}

_install_extras_stuffs(){
    echo "[x] snap killaal, refresh install..."
    sudo killall snap-store;
    sudo snap refresh;
    sudo snap refresh --list;

    # the most beautifull downloader
    # and the markdown powerpoint presenter
    sudo snap install slides aria2c;
}

_install_bash_preexc(){
    # Pull down our file from GitHub and write it to your home directory as a hidden file.
    curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o \
        ~/.bash-preexec.sh
}

# to install a repl for C
_install_cling(){
    sudo apt install -y wget unar
    wget https://root.cern/download/cling/cling_2020-11-05_ROOT-ubuntu2004.tar.bz2
    unar cling_2020-11-05_ROOT-ubuntu2004.tar.bz2
    ./cling_2020-11-05_ROOT-ubuntu2004/bin/cling
}

_install_nordvpn(){
    _confirm_install_again nordvpn || return 0
    sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
}

# for my electronics stuffs
_install_libre_pcb(){
    cd ~/Downloads/
    wget "https://download.librepcb.org/releases/1.0.0/librepcb-1.0.0-linux-x86_64.AppImage"
    chmod +x ./librepcb-1.0.0-linux-x86_64.AppImage
    ./librepcb-1.0.0-linux-x86_64.AppImage
}

_install_dev_stack(){
    _source_dev_stack

    # For a weird perl warning error on locales UTF-8
    # Should be on top
    _confirm "Install rust (can be a requirement) for the next steps..." _install_rust
    _confirm "Install nvm (can be a requirement) for the next steps..." _install_nvm

    _confirm "Reconfigure locale langs ? " _install_locales_lang
    _confirm "Install Basics utils (git, docker...) stuffs ?" _install_basics

    # Setup the preExc bash command for some usefull stuff just like telling the time
    _confirm "Install bash prexec/postexec scripts ?" _install_bash_preexc
    _confirm "Install python(.10/.11) stuffs ?" _install_python_stuffs
    _confirm "Install Nvim stuffs ?" _install_nvim_and_utils
    _confirm "Install i3 stuffs (heavy | ui | rofi) ?" _install_i3
    _confirm "Install path browsing utils ?"  _install_path_browsing_utils
    _confirm "Install vagrant stuffs (heavy) ?" _install_vagrant
    _confirm "Install alacritty terminal (ui) ?" _install_alacritty
    _confirm "Install slack (company messaging app)" _install_slack
    _confirm "Install thunderbird (email app)" _install_thunderbird
    _confirm "Install extras stuffs (slides, aria2c) ?" _install_extras_stuffs
    _confirm "Install mpv player and ytb ?" _install_mpv

    # need this step to have stuff loaded.
    _confirm "Set Dotfiles accross the .config ?" _set_dot_files
}

_install_help(){
    cat ~/.bash_aliases | grep "\"Install " | grep "_confirm" | grep "_install_" | cut -b 22-
}

_help(){
   curl -s -L cheat.sh/$@ | less -R
}
# h docker
alias h='_help'
alias a='aria2c'
# Alias definitions.
alias clean_docker_images='docker rmi $(docker images -f "dangling=true" -q)'
alias clean_docker_images_all='docker image prune --all'
alias clean_docker_container='docker rm -f $(docker ps -a -q)'
_clean_volumes(){
    # List all volumes from docker volume
    # then remove the first line
    # sed to delete "local " from the /tmp/volumes
    # and then apply the docker volume rm on each lines from that file
    docker volume ls > /tmp/volumes && \
    tail -n +2 /tmp/volumes && \
    sed -i 's/local //g' /tmp/volumes && \
    while read in; do docker volume rm "$in"; sleep 1; done < /tmp/volumes
}
alias clean_docker_volume_rmall='_clean_volumes'
alias clean_docker_volume_prune='docker volume prune'

_clean_recursive(){
    _confirm "Delete recursivelly $1 from $2 " find $2 -name $1 -type d -prune -exec rm -rf '{}' +
}

_clean_nodemodules(){
    _clean_recursive "node_modules" $1
}
alias clean_nodemodules='_clean_nodemodules'

# To fastly jump in a remote branch
# Usage: get origin branch-name
_get(){
    if [ -d ".git" ]; then
        if [ -n "$1" ]; then
            # An argument passed
            # We try to stash our changes if there where some...
            git stash
            # We fetch/checkout the target branch
            git fetch $1 $2
            git checkout $2
        else
            # No argument passed
            echo "Usage: get origin feat/test-stuff"
        fi
    else
        echo "[x] Oups, not a .git directory !"
    fi
}

alias x='xdg-open .'

# _git_search "function name"
_git_search(){
    # a smart git command to get commit, file and line where
    # the string is available
    git rev-list --all | (
        while read revision; do
            git grep -n -F "${1}" $revision
        done
    ) | less
}

# __git_open_code commit:file:line
_git_open_code(){
    # getting your current branch
    branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

    # A smart split from the incomming $1 parameter
    arr=($(echo "$1" | tr ':' '\n'))
    commit=${arr[0]}
    file=${arr[1]}
    line=${arr[2]}

    # some verbose
    echo "[-] Moving on commit : $commit"
    echo "[-] Moving on file : $file"
    echo "[-] Moving on line : $line"

    # A checkout on the commit then a less on the line of the file
    git checkout "$commit"
    cat +"$line" "$file" | less -r

    sleep 1
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
    REPO_NAME="$(echo $2 | grep -oE '[^/]+$')";
    git clone --filter=blob:none --no-checkout $2
    cd $REPO_NAME;
    git sparse-checkout set --no-cone "$1/*"
    if [ -n "$3" ]; then
        git pull origin $3;
        git checkout $3;
    else
        git fetch origin;
        git checkout main
        [[ $? != 0 ]] && git checkout master;
    fi
}

_git_squash(){
    read -p "> You're about to squash all commits from this branch ? (Y/y) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # Commit count difference between my branch and the master branch
        COMMIT_COUNT=git rev-list --count HEAD ^master
        # We rebase from the amount of commit
        git rebase -i HEAD~$COMMIT_COUNT
    else
        _echo_red "< Squash stopped"
    fi
}

_git_coworker(){
    remote_u=(${1//:/ })

    author=${remote_u[0]}
    branch=${remote_u[1]}
    current_dir=$(basename $PWD)
    target="git@github.com:$author/$current_dir"

    _echo_black "> author: $BWHITE $author $COLOROFF"
    _echo_black "> branch: $BWHITE $branch $COLOROFF"
    _echo_black "> repo-name: $BWHITE $current_dir $COLOROFF"
    _echo_black "> target-repo: $BWHITE $target $COLOROFF"

    read -p "Those informations are good ? (Y/y): " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        git remote add $author $target
        git fetch $author
        git checkout --track $author/$branch
    fi
}

git-fuzzy-diff ()
{
	PREVIEW_PAGER="less --tabs=4 -Rc"
	ENTER_PAGER=${PREVIEW_PAGER}
	if [ -x "$(command -v delta)" ]; then
		PREVIEW_PAGER="delta | ${PREVIEW_PAGER}"
		ENTER_PAGER="delta | sed -e '1,4d' | ${ENTER_PAGER}"
	fi

	# Don't just diff the selected file alone, get related files first using
	# '--name-status -R' in order to include moves and renames in the diff.
	# See for reference: https://stackoverflow.com/q/71268388/3018229
	PREVIEW_COMMAND='git diff --color=always '$@' -- \
		$(echo $(git diff --name-status -R '$@' | grep {}) | cut -d" " -f 2-) \
		| '$PREVIEW_PAGER

	# Show additional context compared to preview
	ENTER_COMMAND='git diff --color=always '$@' -U10000 -- \
		$(echo $(git diff --name-status -R '$@' | grep {}) | cut -d" " -f 2-) \
		| '$ENTER_PAGER

	git diff --name-only $@ | \
		fzf ${GIT_FZF_DEFAULT_OPTS} --exit-0 --preview "${PREVIEW_COMMAND}" \
		--preview-window=top:85% --bind "enter:execute:${ENTER_COMMAND}"
}

git-fuzzy-log ()
{
	PREVIEW_COMMAND='f() {
		set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}")
		[ $# -eq 0 ] || (
			git show --no-patch --color=always $1
			echo
			git show --stat --format="" --color=always $1 |
			while read line; do
				tput dim
				echo " $line" | sed "s/\x1B\[m/\x1B\[2m/g"
				tput sgr0
			done |
			tac | sed "1 a \ " | tac
		)
	}; f {}'

	ENTER_COMMAND='(grep -o "[a-f0-9]\{7\}" | head -1 |
		xargs -I % bash -ic "git-fuzzy-diff %^1 %") <<- "FZF-EOF"
		{}
		FZF-EOF'

	git log --graph --color=always --format="%C(auto)%h %s%d " | \
		fzf ${GIT_FZF_DEFAULT_OPTS} --no-sort --tiebreak=index \
		--preview "${PREVIEW_COMMAND}" --preview-window=top:15 \
		--bind "enter:execute:${ENTER_COMMAND}"
}

git-fuzzy-log-branch ()
{
	PREVIEW_COMMAND='f() {
		set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}")
		[ $# -eq 0 ] || (
			git show --no-patch --color=always $1
			echo
			git show --stat --format="" --color=always $1 |
			while read line; do
				tput dim
				echo " $line" | sed "s/\x1B\[m/\x1B\[2m/g"
				tput sgr0
			done |
			tac | sed "1 a \ " | tac
		)
	}; f {}'

	ENTER_COMMAND='(grep -o "[a-f0-9]\{7\}" | head -1 |
		xargs -I % bash -ic "git-fuzzy-diff %^1 %") <<- "FZF-EOF"
		{}
		FZF-EOF'

    git log origin..HEAD --no-merges  --graph --color=always --format="%C(auto)%h %s%d " | \
		fzf ${GIT_FZF_DEFAULT_OPTS} --no-sort --tiebreak=index \
		--preview "${PREVIEW_COMMAND}" --preview-window=top:15 \
		--bind "enter:execute:${ENTER_COMMAND}"
}

fuzzy_add_search()
{
    DIFF_VIEW='git diff {1} | delta'
    ADD_PATCH='git add -p {1}'

    git diff --shortstat --name-only | \
    fzf ${GIT_FZF_DEFAULT_OPTS} --exit-0 \
    --header "Changes to Add" \
    --preview "${DIFF_VIEW}" \
    --preview-window top:20 --pointer=">" \
    --bind "enter:execute:${ADD_PATCH}"
}

fuzzy_diff_search()
{
    DIFF_VIEW='git diff {1} | delta'

    git diff --shortstat --name-only | \
    fzf ${GIT_FZF_DEFAULT_OPTS} --exit-0 \
    --header "Changes to Add" \
    --preview "${DIFF_VIEW}" \
    --preview-window top:20 --pointer=">"
}

fuzzy_stash_search()
{
    while out=$(git stash list "$@" |
                fzf --ansi --no-sort --reverse --print-query --query="$query"              \
                    --expect=ctrl-a,ctrl-b,ctrl-p,del                                      \
                    --bind="ctrl-u:preview-page-up"                                        \
                    --bind="ctrl-d:preview-page-down"                                      \
                    --bind="ctrl-k:preview-up"                                             \
                    --bind="ctrl-j:preview-down"                                           \
                    --preview="echo {} | cut -d':' -f1 | xargs git stash show -p | delta"  \
                    --preview-window "top:40");
    do
        # Tokenize selection by newline
        IFS=$'\n' read -rd '' -a selection <<< "$out"
        # Keep the query accross fzf calls
        query="${selection[1]}"
        # Represents the stash, e.g. stash{1}
        reflog_selector=$(echo "${selection[3]}" | cut -d ':' -f 1)

        case "${selection[2]}" in
            # ctrl-a applies the stash to the current tree
            ctrl-a)
                git stash apply "$reflog_selector"
                break
                ;;
            # ctrl-b checks out the stash as a branch
            ctrl-b)
                sha=$(echo "${selection[3]}" | grep -o '[a-f0-9]\{7\}')
                git stash branch "stash-$sha" "$reflog_selector"
                break
                ;;
            # ctrl-p is like ctrl-a but it drops the stash. Uses stash pop.
            ctrl-p)
                git stash pop "$reflog_selector"
                break
                ;;
            # del will drop the stash
            del)
                git stash drop "$reflog_selector"
                ;;
        esac
    done
}

git_checkout_tree(){
    branch=$@
    repo_path=$(git rev-parse --show-toplevel)
    repo_name="$(basename $repo_path)"
    # To get the root directory of the git project,
    # because we could be in a subdirectory while running this command
    root_path="$(dirname $repo_path)"

    _echo_blue "> repo: $repo_name: "
    _echo_blue "> root-path: $root_path: "

    # Yes, we can checkout multiple branch at the same time
    for bb in "${@}";do
        # remove slashes to convert fix/this to fix-this
        bb_formated=$(echo $bb | tr '/' '-')
        new_path="$root_path/$repo_name-$bb_formated"

        if [ -d $new_path ]; then
            _echo_green "> worktree $repo_name-$bb_formated already exist..."
        else
            _echo_white "> creating worktree ../$repo_name-$bb_formated"

            # We fetch from this env
            # if not set we get from remote origin
            if [ -z $GIT_REMOTE_SET_TO ]; then
                git fetch origin $bb
            else
                git fetch $GIT_REMOTE_SET_TO $bb
            fi

            _command="git tree-add $new_path $bb"

            _echo_white $_command
            eval $_command
        fi;

        _echo_white "> Now you can cd to $new_path... "
    done;
}

# To install apt-clone for backups
# sudo apt-get install apt-clone
# To Make a backup
# sudo apt-clone clone path-to/apt-clone-state-ubuntu-$(lsb_release -sr)-$(date +%F).tar.gz
# To restore a backup
# sudo apt-clone restore path-to/apt-clone-state-ubuntu.tar.gz
# To restore to the newer version:
#  sudo apt-clone restore-new-distro path-to/apt-clone-state-ubuntu.tar.gz $(lsb_release -sc)

# AES-256 encrypt/decrypt

_install_mcrypt(){

    _confirm_install_again mcrypt || return 0

    sudo apt-get update -y
    sudo apt-get install mcrypt -y
}

# plaintext="Hello, World!"
# _aes_encrypt "$plaintext"
# _aes_encrypt "$encrypted"
export AES_KEY_EN_DE="0123456789ABCDEF0123456789ABCDEF"
_aes_encrypt() {
    local to_encrypt="/tmp/to_encrypt"

    echo "$@" > $to_encrypt
    openssl aes-256-cbc -a -salt -pbkdf2 -in $to_encrypt -out $to_encrypt.enc -pass env:AES_KEY_EN_DE
    cat $to_encrypt.enc
}
_aes_decrypt() {
    local to_decrypt="/tmp/to_decrypt"
    touch $to_decrypt.dec

    echo "$@" > $to_decrypt
    openssl aes-256-cbc -d -a -pbkdf2 -in $to_decrypt -out $to_decrypt.dec -pass env:AES_KEY_EN_DE
    cat $to_decrypt.dec
}

# to host anything
# Usage : cat index.html | tb
alias tb="nc termbin.com 9999"
# Get the clipboard content at termbin
alias tbc="co | tb"

# To see pdf on the terminal
_pdf(){
    pdftotext -layout "$1" - | less
}
alias pdf='_pdf'

# For tmux command :
# alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach-session -t'
alias tls='tmux ls'
alias to='ta other'
alias tkill='tmux kill-server'

# To control the brightness with xrandr contrast
_xrandr(){
    # _xrandr lu eDP-1-1 0.9
    if [[ $1 == 'ls' ]];then
        xrandr -q | grep ' connected' | head -n 1 | cut -d ' ' -f1
    elif [[ $1 == 'lu' ]];then
        xrandr --output $2 --brightness $3
    fi
}
alias ds="docker ps --format 'table {{.RunningFor}}\t{{.Status}}\t{{.Names}}'"

m() {
  python3 -c "from math import *; print($*)"
}

_loc(){
    echo -ne "Lines of Code : ";
    # find "$@" -type f -print0 | xargs -r -0 cat | wc -l

    find . -name *.$@ | sed 's/.*/"&"/' | xargs  wc -l
}
alias loc=_loc

alias ipinfo="curl ipinfo.io"
alias sp=speedtest

# Show changes for a given file on a specific point in the history
git_log_commits_for(){
    SHOW_COMMIT_COMMAND='git show {1} -- '$@' | delta'
    git log --pretty=format:"%h" -- $@ | fzf        \
    --reverse --print-query ${GIT_FZF_DEFAULT_OPTS} \
    --header "Commit Changes for $@"                \
    --preview "${SHOW_COMMIT_COMMAND}"              \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up"  \
    --bind "enter:execute:${SHOW_COMMIT_COMMAND}"   \
    --preview-window right:90%                      \
    --pointer=">"
}

# This is to backport a specific commit hash from a branch
# to another one then try opening the PR
git_backport(){
    COMMIT_HASH=$1
    TARGET_BRANCH="$(git branch --show-current)"

    _echo_white "> backport of $COMMIT_HASH to $TARGET_BRANCH..."

    if [ -z $COMMIT_HASH ]; then _echo_red "COMMIT_HASH can't be empty !"
        return
    fi;

    if [ -z $TARGET_BRANCH ]; then _echo_red "TARGET_BRANCH can't be empty !"
        return
    fi;

    _echo_black "-> git stash..."
    git stash # we save stuff if we have ongoing stuffs

    _echo_black "-> git checkout $TARGET_BRANCH..."
    # Checkput to the target branch
    # if error, try to fetch it from the origin
    git checkout $TARGET_BRANCH || \
        git fetch origin $TARGET_BRANCH && \
        git checkout $TARGET_BRANCH || _echo_red "Unable to checkout to $TARGET_BRANCH"

    BACKPORT_BRANCH="backport-${COMMIT_HASH:0:4}"
    _echo_black "-> git checkout -b backport-$COMMIT_HASH..."
    git checkout -b $BACKPORT_BRANCH

    _echo_black "-> git pick $COMMIT_HASH..."
    git pick $COMMIT_HASH

    WHAT="$(git show $COMMIT_HASH --pretty=format:"%s" --no-patch)"
    PR_TITLE="f(backport): of '${WHAT:0:10}'"
    PR_BODY="##WHAT\n\nThis is a backport of '$WHAT'"
    JSON_PAYLOAD="{\"title\": \"$PR_TITLE\", \"head\": \"$BACKPORT_BRANCH\", \"base\": \"$TARGET_BRANCH\", \"body\": \"$PR_BODY\", \"maintainer_can_modify\": true}"

    _echo_black "-> git pr create..."
    # Then we create the pr
    _echo_white "-WHAT: $WHAT"
    _echo_white "-TITLE: $PR_TITLE"
    echo "-PAYLOAD: $JSON_PAYLOAD"

    _echo_white "Creating the pr..."
    echo $JSON_PAYLOAD > /tmp/pr-backport-tmp.json

    EDITOR=nvim gh pr create --recover /tmp/pr-backport-tmp.json
}

git_open_pr(){
    browser=firefox
    pr_number=$(EXTRACT_REGEX "$(git pr-list-all | grep $(git branch-name))" "([0-9]+)")
    # yes, you can specify the remote host for context switch (gitlab/bitbucket)
    remote_link=$(git remote get-url $(IS_ENV_SET $1 "origin"))
    # well, it may seem complex but in reality it's a whole regex
    # beast that I pipe to extract the direct link of the repo from
    # the git remote origin of the repo I'm in to get the PR link.
    built_link="$(echo "https://$(echo "$remote_link" | sed -e 's/git@//' -e 's/\.git$//' -e 's/:/\//')")/pull/$pr_number"
    # to check a link (for status 20x)
    CURL_CHECK="curl --head --silent --fail"

    echo "PR: $pr_number"
    echo "browser: $browser"
    echo "remote_link: $remote_link"
    if $CURL_CHECK "$built_link" &> /dev/null; then
        echo "> opening PR: '$built_link'...";
    else
        echo "< seems like a bad link (or this terminal not have access): $built_link";
    fi;

    $browser $built_link;
}

# Can be usefull sometimes (even for the latest commit hash for example)
git_last_commit_link(){
    pr_number=$(EXTRACT_REGEX "$(git pr-list-all | grep $(git branch-name))" "([0-9]+)")
    remote_link=$(git remote get-url $(IS_ENV_SET $1 "origin"))
    built_link="$(echo "https://$(echo "$remote_link" | sed -e 's/git@//' -e 's/\.git$//' -e 's/:/\//')")/pull/$pr_number"

    echo $built_link/commits/$(git last-commit-hash)
}

git_open_link(){
    # $1 can be 'origin' or 'dev' depending on the source
    remote_link=$(git remote get-url $1)
    browser=firefox
    CURL_CHECK="curl --head --silent --fail"
    if $CURL_CHECK "$remote_link" &> /dev/null; then
        $browser $remote_link;
    else
        built_link=$(echo "https://$(echo $remote_link | sed -e 's/git@//' -e 's/:/\//')")
        if $CURL_CHECK "$built_link" &> /dev/null; then
            echo "> opening '$built_link'...";
        else
            echo "< seems like a bad link (or this terminal not have access): $built_link";
        fi;
        $browser $built_link;
    fi;
}

git_compare_online(){
    # $1 can be 'origin' or 'dev' depending on the source
    remote_link=$(git remote get-url $1)
    current_branch=$(git branch --show-current)
    browser=firefox
    CURL_CHECK="curl --head --silent --fail"
    if $CURL_CHECK "$remote_link" &> /dev/null; then
        $browser $remote_link;
    else
        built_link=$(echo "https://$(echo $remote_link | sed -e 's/git@//' -e 's/:/\//' -e 's/\.git$//')")
        if $CURL_CHECK "$built_link" &> /dev/null; then
            echo "> opening '$built_link'...";
        else
            echo "< seems like a bad link (or this terminal not have access): $built_link";
        fi;
        $browser "$built_link/compare/$current_branch?expand=1";
    fi;
}

# Function to list pull requests in a table format
git_list_pull_requests() {
    gh pr list --json number,baseRefName,headRefName,title,reviews --jq '
        .[] |
        [
            "#\(.number)",
            .baseRefName,
            "<- \(.headRefName)",
            "\"\(.title | .[:50])\"",
            (.reviews | if length == 0 then "NO REVIEW" else .[0].state end)
        ] | @tsv' | \
    column -s $'\t' -t
}

# Function to list pull requests and select one
git_select_pull_request() {
    pr_selected=$(git_list_pull_requests | \
        fzf --ansi \
            --header="Select Pull Request" \
            --preview "git pr-view {1} | bat --language markdown --color=always" \
            --preview-window=top:40 | awk '{print $1, $2, $4}')
    pr_id=$(echo "$pr_selected" | awk '{print $1}' | sed 's/#//')
    pr_target_branch_name=$(echo "$pr_selected" | awk '{print $2}')
    pr_branch_name=$(echo "$pr_selected" | awk '{print $3}')

    if [ -n "$pr_id" ]; then
        git_pr_actions_menu "$pr_id" "$pr_branch_name" "$pr_target_branch_name"
    fi
}

# Function to display actions menu for selected pull request
git_pr_actions_menu() {
    pr_id=$1
    pr_branch_name=$2
    actions=("Approve PR" "Merge PR" "Squash Merge PR" "Show Changes From PR" "Approve and Squash MergePR" "Close PR")
    selected_action=$(printf '%s\n' "${actions[@]}" | \
        fzf --ansi \
        --header="Select Action for PR #$pr_id" \
        --preview "gh pr checks $pr_id | column -s $'\t' -t" \
        --preview-window=top:30)
    case $selected_action in
        "Approve PR")
            gh pr review --approve "$pr_id"
            git_select_pull_request
            ;;
        "Merge PR")
            gh pr merge --auto
            git_select_pull_request
            ;;
        "Squash Merge PR")
            gh pr merge --squash --auto "$pr_id"
            git_select_pull_request
            ;;
        "Show Changes From PR")
            git stash && \
            git checkout "$pr_branch_name" && \
            git-fuzzy-log-branch && \
            git checkout - && \
            git stash pop
            git_select_pull_request
            ;;
        "Approve and Squash MergePR")
            gh pr review --approve "$pr_id"
            gh pr merge --squash --auto "$pr_id"
            git_select_pull_request
            ;;
        "Close PR")
            gh pr close "$pr_id"
            git_select_pull_request
            ;;
        *)
            git_select_pull_request
            ;;
    esac
}

alias less="less -r"
_stopWatch(){
    # while true; do printf '%s\r' "$(date +%H:%M:%S:%N)"; done
    start=$(date +%s)
    while true; do
        time="$(($(date +%s) - $start))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
    done
}

alias stopwatch=_stopWatch

_uptime(){
    uptime -p | awk '{split($0,a,", "); print a[1]}'
}

# Execute commands on a different repository and
# come back to where we have been !
_cdex(){
    commandToBeExecuted="${@:2}"
    echo "Executing => '$commandToBeExecuted' in \"$1\""
    # Using zoxide i can navigate to a directory just
    # by it's name and not the full path
    cd "$1" && $commandToBeExecuted;
    cd -
}
alias cdex=_cdex

psaux(){
    # just to search for a running process quickly
    ps aux | grep $1
}

# to install teleport shel
_install_tsh(){
    # # download teleport gpg KEY
    # sudo curl https://deb.releases.teleport.dev/teleport-pubkey.asc \ -o /usr/share/keyrings/teleport-archive-keyring.asc

    # # add teleport to repository for apt
    # echo "deb [signed-by=/usr/share/keyrings/teleport-archive-keyring.asc] https://deb.releases.teleport.dev/ stable main" | sudo tee /etc/apt/sources.list.d/teleport.list > /dev/null

    # # apt update and install :
    # sudo apt update -y
    # sudo apt-get install teleport -y

    _confirm_install_again tsh || return 0
    curl https://goteleport.com/static/install.sh | bash -s 14.2.0
    echo "Installed tsh version $(tsh version)"
}

# to set the mouse on required default ways
_set_mouse(){
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Enabled" 1
    xinput set-prop "Synaptics TM3625-010" "Device Enabled" 1
    xinput set-prop "Synaptics TM3625-010" "Coordinate Transformation Matrix" 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Enabled" 1
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Enabled Default" 0
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Drag Enabled" 1
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Drag Enabled Default" 1
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Drag Lock Enabled" 0
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Drag Lock Enabled Default" 0
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Button Mapping Enabled" 1, 0
    xinput set-prop "Synaptics TM3625-010" "libinput Tapping Button Mapping Default" 1, 0
    xinput set-prop "Synaptics TM3625-010" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "Synaptics TM3625-010" "libinput Natural Scrolling Enabled Default" 0
    xinput set-prop "Synaptics TM3625-010" "libinput Disable While Typing Enabled" 1
    xinput set-prop "Synaptics TM3625-010" "libinput Disable While Typing Enabled Default" 1
    xinput set-prop "Synaptics TM3625-010" "libinput Scroll Methods Available" 1, 1, 0
    xinput set-prop "Synaptics TM3625-010" "libinput Scroll Method Enabled" 1, 0, 0
    xinput set-prop "Synaptics TM3625-010" "libinput Scroll Method Enabled Default" 1, 0, 0
    xinput set-prop "Synaptics TM3625-010" "libinput Click Methods Available" 1, 1
    xinput set-prop "Synaptics TM3625-010" "libinput Click Method Enabled" 1, 0
    xinput set-prop "Synaptics TM3625-010" "libinput Click Method Enabled Default" 1, 0
    xinput set-prop "Synaptics TM3625-010" "libinput Middle Emulation Enabled" 0
    xinput set-prop "Synaptics TM3625-010" "libinput Middle Emulation Enabled Default" 0
    xinput set-prop "Synaptics TM3625-010" "libinput Accel Speed" 0.000000
    xinput set-prop "Synaptics TM3625-010" "libinput Accel Speed Default" 0.000000
    xinput set-prop "Synaptics TM3625-010" "libinput Left Handed Enabled" 0
    xinput set-prop "Synaptics TM3625-010" "libinput Left Handed Enabled Default" 0
    xinput set-prop "Synaptics TM3625-010" "libinput Send Events Modes Available" 1, 1
    xinput set-prop "Synaptics TM3625-010" "libinput Send Events Mode Enabled" 0, 0
    xinput set-prop "Synaptics TM3625-010" "libinput Send Events Mode Enabled Default" 0, 0
    xinput set-prop "Synaptics TM3625-010" "Device Node" "/dev/input/event4"
    xinput set-prop "Synaptics TM3625-010" "Device Product ID" 2, 7
    xinput set-prop "Synaptics TM3625-010" "libinput Horizontal Scroll Enabled" 1
}

# To take note about something really quickly
# Requirements : fzf and ag
#
# $ note topic note to my self... # will add a new note for the topic
# $ note topic # will seach for notes on this topic
# $ note # will list for you all notes taken globally
note(){
    local notes_dir=$HOME/notes/
    local content_view="cat $notes_dir/{1}-notes.md"
    local today_note_file="$notes_dir/$(date '+%Y-%m-%d')-notes.md"
	enter_command="nvim $notes_dir/{1}-notes.md"

    # We create the notes directory if it doesn't exist
    if [ ! -d "$notes_dir" ]; then mkdir -p $notes_dir; fi;

    # We browse context (topic) elements if only one argument is passed
    if [ "$#" = "1" ]; then ls $notes_dir | ag $1 $notes_dir; fi;

    # We browse the content of notes if no arguments are passed
    if [ -z $1 ]; then
        # if fzf is installed, use it as a live browser, otherwise,
        # cat the list of note from today
        if [! command -v fzf &> /dev/null ]; then cat $today_note_file; else
            ls $notes_dir | sed 's/-notes.md//g' | fzf --header "NOTES LIST" \
                --preview "${content_view}" --preview-window "right:98" \
                --bind "enter:execute:${enter_command}" \
                --bind "ctrl-d:preview-down,ctrl-u:preview-up" \
                --tac; # for the reverse order
        fi
    else
        local content_message="${@:2}"
        # We only save a > 3 note
        if [ ${#content_message} -ge 3 ]; then
            echo -e "- **$(date '+%H:%M:%S')** > [$1] $content_message \n" >> $today_note_file;
        fi;
    fi
}

# Scrap an entire website using only wget
#
# Usage:
# _scrap s4nixd https://www.sanixdk.xyz
# Requirements: "wget"
_scrap(){
    cd /tmp
    mkdir -p "$1" && cd "$1"
    wget --recursive --page-requisites \
        --convert-links \
        --limit-rate=2k \
        "$2"
    cd -
}

# Get the size of ny dd
_ddf(){
    df -h $HOME
}

# to record my terminal when am writing something
alias rec='asciinema rec'

# replace all numbers from a given pipe
alias _hide_numbers="sed 's/[0-9]/*/g'"

# Don't blame me, sometimes am found myself hitting gti instead of git
alias gti="git"

# jira stuffs:
jira_run_cli(){
    docker run -it --rm --name jira-cli ghcr.io/ankitpokhrel/jira-cli:latest
    # jira init
    # Cloud
}
jira_exec_cli(){
    docker exec -it jira-cli sh
    # jira init
    # Cloud
}

# vagrant stuffs
# ---------------------------------------
# _vgup ubu
_vgup(){
    vmm=$1
    mkdir -p ~/vagrant/shared/dk/$1
    cd $HOME/vagrant/vms/$vmm
    vagrant up
    cd -
}
# _vgdown ubu
_vgdown(){
    vmm=$1
    mkdir -p ~/vagrant/shared/dk/$1
    cd $HOME/vagrant/vms/$vmm
    vagrant halt
    cd -
}
# _vglistvmsconfs
_vglistvmsconfs(){
    echo "> available vms :"
    ls -al $HOME/vagrant/vms
}
# _vglistbox
_vglistbox(){
    vagrant box list
}
# _vglistvms
_vglistvms(){
    VBoxManage list vms
}
# _vgssh ubu
_vgssh(){
    vmm=$1
    cd $HOME/vagrant/vms/$vmm
    vagrant ssh
    cd -
}
# _vgdestroy ubu
_vgdestroy(){
    vagrant destroy -f $@
}
# _vgdestroyvm ubu
_vgdestroyvm(){
    _vdown $@
    VBoxManage unregistervm $@ --delete
}
# _vgstatus
_vgstatus(){
    vagrant global-status
}
# _vgremove ubu
_vgremove(){
    vmm=$1
    vagrant box remove $vmm
}

# Tail grep on a file
# _tail_grep /tmp.file "item this"
_tail_grep(){
    tail -Fn+0 $1 | grep $2
}
# same principle but everything except the item
_tail_no_grep(){
    tail -Fn+0 $1 | grep -v $2
}

# To clean the swap memory
_swapclear(){
    sudo swapoff -a;sudo swapon -a
}
# To clean virtual memory on linux
_clean_virtual_ram(){
    sync && echo 3>/proc/sys/vm/drop_caches
}

# run a command again and again only if the standard output
# hash change by a single bit
# _inf git status
_inf(){
    echo "-> Executing '$@' until the output change or you quit:"
    # we source our alias first
    PREVIOUS_HASH=""
    while true; do
        CURRENT_HASH=$($(echo "${@}") | md5sum)
        if [ "$CURRENT_HASH" != "$PREVIOUS_HASH" ]; then
            $(echo "${@}");
            echo -e "----------------------------------";
            PREVIOUS_HASH=$CURRENT_HASH
            sleep 1;
        fi;
        sleep 10; # to keep our cpu sane
    done;
}

_install_lynx(){

    _confirm_install_again lynx || return 0

    sudo apt update -y
    sudo apt install lynx -y
}
# A formater for html
alias llx='lynx -stdin'

# Random wait live for 5mins
alias live_wait='clear && echo "LIVE WILL START IN" && _sleep 300'

# This need to be present fist on my /usr/local/bin
# https://github.com/Sanix-Darker/zeal-lynx-cli
alias zeal-cli='python3.10 /usr/local/bin/zeal-cli'

_pydoc(){
    zeal-cli Python_3 | fzf --height=50% --preview='zeal-cli --lynx-dump=true Python_3 { }' | xargs -d '\n' zeal-cli Python_3
}

# To open a pdf with vim bindings.
openpdf(){
    zathura $1;
}

# _build_perf_stats https://google.com
_build_perf_stats(){
    local perfCollectionDir="$HOME/ACTUALC/github/performance-website"
    if [ ! -d "$perfCollectionDir" ]; then
        _echo_black "Creating the dir : $perfCollectionDir"
        mkdir -p $perfCollectionDir
    fi;
    npx unlighthouse --site $1
}

# To watch youtube video
# on mpv just after copying the
# video link in my clipboard.
# NOTE: This is used by i3... don't modify it too much darker
_yv(){
    # not passing as param... flemme
    link="$(xsel -b)"
    # Check if the content is a YouTube link
    if [[ $link =~ ^https?://(www\.)?youtube\.com/watch\?v=.* ]]; then
        alert "Loading video : $link..."
        nohup bash -c 'yt-dlp -o - "'$link'" | mpv --keep-open -' &
        error_output=$(command 2>&1 >/dev/null) [ -n "$error_output" ] \
        && echo $error_output && \
        alert "< Error occured : $error_output"
    else
        alert "> Not a youtube link !"
    fi

}
alias yv='_yv'

# NOTE: a git wrapper for some custom sub command
# this can be glitchy and messy, since this function can call itself recursivelly
# if we don't pay attention enought on what we're doing.
git(){
  # if [[ "$1" == "log" && "$@" != *"--help"* ]]; then
  #   shift 1
  #   command git log-line "$@"

  # for cloning stuff in a "lazy way".
  # if [[ "$1" == "clone" && "$@" != *"--help"* ]]; then
  #   shift 1
  #   command git clone-gh "$@" || git clone-gl "$@"
  if [[ "$1" == "branch" && "$@" != *"--help"* ]]; then
    shift 1 # to remove the first argument passed
    command git branch-sorted "$@"
  elif [[ "$1" == "restore" || "$1" == "add" || "$1" == "update" || "$1" == "pull" ]]; then
    command git "$@" && git status
  elif [[ "$1" == "diff" ]]; then
    git status && command git "$@"
  else
    command git "$@"
  fi
}

# To get the os version and more infos
_version(){
    lsb_release -a
}

# Hide/Show what am typing ?
_hide(){
    _echo_red "?> Now everything typed will be hide (_show to show againg)."
    stty -echo
}
_show(){
    _echo_green "?> Now everything typed will be shown to screen (_hide to hide)."
    stty echo
}

# for the ssh-add error on ssh-agent
_ssh_add(){
    eval "$(ssh-agent)"
    ssh-add
}
alias tmux-jump='~/.config/tmux/plugins/tmux-jump/scripts/tmux-jump.sh'

# for translation, use translate-shell
# :fr "your phrase" (will translate the phrase in French)
# NOTE: yes, you can do the same with english, just use :en
alias trans='docker run -it soimort/translate-shell -shell'

# fancy parting parrot
alias parrot='curl parrot.live'

# To boot an usb device for a specific .iso file
# no need of a special app for that...
#
# $ _boot_usb /dev/sda ~/Downloads/Win11_22H2_English_x64v2.iso NTFS
#
_boot_usb(){
    usb_drive=$1
    iso_path=$2

    # checking for lsblk then list all available devs
    $(command -v lsblk > /dev/null) && [[ $? == 0 ]] && \
        echo ">available /dev:" && lsblk | grep "sd" || echo "> [not blocking] lsblk not present !"

    # As FAT by default
    # if there is no format provided or FAT is provided, use FAT
    # if NTFS is provided, use it
    # else use the provided format
    [[ -z $3 || "$3" == "FAT" ]] && format_type_command="mkfs.vfat -F 32" || \
        [[ "$3" == "NTFS" ]] && format_type_command="mkfs.ntfs" || \
        format_type_command="$3"

    # boot util, because it's a long one
    _boot(){
        sudo dd bs=4M if=$iso_path of=$usb_drive status=progress oflag=sync
    }
    _status(){
        [[ $? == 0 ]] && _echo_green "< $1 Operation suceeded !" || \
            $(_echo_red "<[blocking] $1 Operation failed !" && \
            _confirm ">> Wish to continue anyway ?" echo )
    }

    _confirm "> boot-usb:$usb_drive, format:$format_type_command, iso:$iso_path" echo

    # Make sure to format your /dev/drive with the appropriate format given
    _confirm ">> format $usb_drive" sudo $format_type_command $usb_drive
    _status "format"

    # Make sure to umount your /dev/drive and
    _confirm ">> umount $usb_drive" sudo umount $usb_drive
    _status "umount"

    # boot USB
    _confirm  ">> boot $iso_path into $usb_drive" _boot
    # no need for this check as it's the final one ?
    _status "boot"
}

# TO fix Hash sum mismatch error on apt update
# sudo apt-get clean
# sudo rm -rf /var/lib/apt/lists/*
# sudo apt-get update

# alias zed='/usr/bin/zed'

# Search something using duckduckgo command line
# Usage: _ ask this in duckduckgo
_(){
    ddgr "$@"
}

# OpenAi bash util for query.
# How to use: _ give me this and that.
__(){
    # Combine all arguments into a single string
    PROMPT="$@"

    # Ensure that OPENAI_API_KEY is set
    if [ -z "$OPENAI_API_KEY" ]; then
        echo "> No \$OPENAI_API_KEY env var found."
        return
    fi

    # No more than 450 characters sent
    if [ ${#PROMPT} -gt 450 ]; then
        echo "> No more than 450 characters please."
        return
    fi

    # Let's track my prompts
    echo "$PROMPT" >> /tmp/gpt-input

    # Prepare JSON payload
    PAYLOAD="{\"model\": \"gpt-3.5-turbo\",\"temperature\": 0.7,\"messages\": [ {\"role\": \"system\",\"content\": \"You're a software engineer, that give solution as source code if possible, no need for comments in code.\"}, {\"role\": \"user\",\"content\": \"$(echo "$PROMPT" | sed 's/"/\\"/g')\"} ] }"

    _start_spinner # Start the spinner

    # Call OpenAI API
    curl -LSs --max-time 40 \
    https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -d "$PAYLOAD" \
    | jq -r '.choices[0].message.content | sub("^\""; "") | sub("\"$"; "")' \
    > /tmp/gpt-output

    _stop_spinner # Stop the spinner

    # Reusing the content
    cat /tmp/gpt-output | glow # --pager (to keep the response on the tty)
}

# Print the last gpt-response on a pager way
# takes no argument
_c(){
    cat /tmp/gpt-output | glow --pager
}

# Basically send me a specific message on TG
# let's say i have a command i runned
# and am afk, i want to know from my phone if
# the command succeed or not.
#
# Ex:  _alert_tg git push succeed
#
# This is extremly cool because it can be integrated in
# CI/CD... let's say i want to get notify if all checks
# on my gh actions went well or bad ? but from telegram
# after leaving my day job computer...
# So many use cases...
_alert_tg(){
    local message=$@
    if [ -z $TG_BOT_TOKEN ]; then
        _echo_red "Please set the TG_BOT_TOKEN env var"
    fi

    if [ -z $TG_USER_ID ]; then
        _echo_red "Please set the TG_USER_ID env var"
    fi

    curl -LSs -X POST \
        "https://api.telegram.org/bot$TG_BOT_TOKEN/sendMessage" \
         -d "chat_id=$TG_USER_ID&text=$(echo "$message" | sed 's/"/\\"/g')"
}

# For some weird reason, i need to run arandr with the python3.8 version for it to work
# some error related to my python3.11 installation, no time to investigate more, will check
# later.
alias arandr='/usr/bin/python3.8 $(which arandr)'

_smart_syncer(){
    local dotfiles_dir="$HOME/dotfiles"
    local config_dir="$HOME/.config"
    local threshold=70
    local difference

    # Initialize some variables
    local largest_difference=0
    local largest_difference_path=""
    local latest_modified_dotfiles=$(stat -c %Y "$dotfiles_dir")

    local CONFIG_PATH_TO_SYNC=(
        "$HOME/.config/autostart"
        "$HOME/.config/nvim"
        "$HOME/.config/rofi" "$HOME/.config/polybar"
        "$HOME/.config/git" "$HOME/.config/i3"
        "$HOME/.config/mpv" "$HOME/.config/alacritty"
        "$HOME/.config/gh-dash" "$HOME/.config/yazi"
        "$HOME/.bash_aliases" "$HOME/.bashrc"
    )
    for path in "${CONFIG_PATH_TO_SYNC[@]}"; do
        latest_modified_config=$(find "$path" -maxdepth 1 -type f -printf '%T@ %p\n' | sort -n | tail -1 | awk '{print int($1)}')

        difference=$(( (latest_modified_config - latest_modified_dotfiles) / 60 ))  # Convert seconds to hours

        if [ "$difference" -gt "$largest_difference" ]; then
            _echo_white "$path :: diff->$difference \c"
            _echo_red "<<<<<<"
            largest_difference=$difference
            largest_difference_path="$path"
        else
            _echo_black "$path :: diff->$difference"
        fi
    done

    # Calculate the ratio percentage
    local total_diff=$((largest_difference + 1))  # surtout pour eviter des trucs chelous genre 3/0 mdr
    local ratio=$((100 * largest_difference / total_diff))

    _echo_black "ratio: $ratio"
    _echo_black "total_diff: $total_diff"
    _echo_black "difference: $difference"
    _echo_black "largest_difference: $largest_difference"
    _echo_black "largest_difference_path: $largest_difference_path"
    _echo_black "latest_modified_config: $latest_modified_config"
    _echo_black "latest_modified_dotfiles: $latest_modified_dotfiles"
    # If ratio percentage is above the threshold, run _push_dot_files
    if [ "$ratio" -gt "$threshold" ]; then
        _confirm "Too much diff with ~/.config and dotfiles, auto sync+push ?" _push_dot_files
    else
        _echo_white "No need for a ~/.config sync"
    fi
}
# check for the latest sync then trigger an automatic sync
_auto_smart_syncer(){
    # just to log the timestamp of the latest time this autosync got called
    local last_config_auto_sync="$HOME/.last_config_auto_sync"

    if [ -f "$last_config_auto_sync" ]; then
        last_execution_time=$(cat "$last_config_auto_sync")
        current_time=$(date +%s)
        time_difference=$((current_time - last_execution_time))

        if [ "$time_difference" -ge 36000 ]; then # 10h en principe
            _smart_syncer
            echo "$current_time" > "$last_config_auto_sync"
        fi
    else
        _smart_syncer
        echo "$(date +%s)" > "$last_config_auto_sync"
    fi
}
_auto_smart_syncer # on each new terminal session opened, i don't want a messy infinite loop to handle this


tmux_extract_layout(){
    tmux list-windows -F "#{window_layout}" > $@_tmux_window_layout
    tmux list-panes -a -F "#{pane_current_command}" > $@_tmux_commands
}

tmux_run_layout(){
    tmux new-window -d
    tmux select-layout -t $(tmux display-message -p "#{window_id}") `cat "$@_tmux_window_layout"`
    paste -d '\n' `cat "$@_tmux_commands"`
}

# NOTE TO MYSELF: READ THIS EACH TIME YOU GET HERE DUMB ASS:
# This is the dumbest idea i ever had
# why should i want to update the clipboard entries ?
# it's making things much more complicated at serializing/deserializing
# for all my processes that need to have access on it
#
# for the sake of remember myself how dumb i am, i will leave this as commented
# remember darker... you're an IDIOT.
# greenclip_refresh_categorize() {
#     local copied_content=$(greenclip print)
#     local categorized_content

#     IFS=$'\n' read -r -d '' -a copied_content_lines < <(greenclip print && printf '\0')
#     for line in "${copied_content_lines[@]}"; do
#         if [ -n "$line" ]; then
#             categorized_content=$(categorize_content "$line")
#             if ! check_existing_content "$categorized_content"; then
#                 echo "$categorized_content" >> ~/
#             fi
#         fi
#     done
# }

# TODO: finish this for my apk dev journey
# _android_stuffs(){
#   # Function to compile an Android app using adb
#   compile_android_app() {
#       local project_path=$1
#       local output_apk_path=$2

#       cd $project_path
#       ./gradlew assembleDebug

#       adb install -r $(find $project_path -name "*.apk" | grep "debug")
#       adb shell am start -n <package_name>/<activity_name>
#   }

#   # Call the function with the project path and output APK path
#   compile_android_app "/path/to/your/project" "/path/to/output.apk"

# Make sure to replace  <package_name>  and  <activity_name>  with the
# actual package name and main activity name of your Android app. You can
# run this script in a terminal to compile and install the app on a
# connected device or emulator.

# You can start an AVD emulator using adb in the command line with the
# following bash script:

#   #!/bin/bash

#   # Start the AVD emulator
#   emulator -avd your_avd_name &

#   # Wait for the emulator to fully boot
#   adb wait-for-device

#   # Install the APK on the emulator
#   adb install path_to_your_apk.apk

#   # Start the main activity of the APK
#   adb shell am start -n your_package_name/your_activity_name

# Make sure to replace  your_avd_name ,  path_to_your_apk.apk ,
# your_package_name , and  your_activity_name  with the appropriate values
# for your setup.
# }

_connect_space_one(){
    _xm nohup bluetoothctl scan on &
    _xm _inf bluetoothctl connect E8:EE:CC:A1:0D:8A
}
