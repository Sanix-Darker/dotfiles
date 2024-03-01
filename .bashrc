# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

new_line() {
    printf "\n$ "
}
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
    # [[ -d ".git" ]] && [[ $? == 0 ]] && \
    #     git branch --show-current > /dev/null && [[ $? == 0 ]] && \
    #     echo [$(git branch --show-current)]
}

if [ "$color_prompt" = yes ]; then
    # for the host it's @\h\[\033[00m\]
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u:\[\033[01;34m\]\W\[\033[00m\]$(parse_git_branch) $(new_line)'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\ $ '
fi
unset color_prompt force_color_prompt


# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash-preexec.sh ]; then
    # Source our file to bring it into our environment
    source ~/.bash-preexec.sh
fi

convertAndPrintSeconds() {
    local totalSeconds=$1;
    local seconds=$((totalSeconds%60));
    local minutes=$((totalSeconds/60%60));
    local hours=$((totalSeconds/60/60%24));
    local days=$((totalSeconds/60/60/24));
    (( $days > 0 )) && printf '%dd ' $days;
    (( $hours > 0 )) && printf '%dh:' $hours;
    (( $minutes > 0 )) && printf '%dm:' $minutes;
    (( $days > 0 || $hours > 0 || $minutes > 0 ));
    printf '%ds\n' $seconds;
}

_handle_cmd_history(){
    CMD_HISTORY_FILE=$PWD/.cmd_history
    LATEST_LINES_TO_SHOW=30

    # we should write inside the directory only if
    # we're not the not root or as a super user
    if [[ "$(stat -c '%U' .)" != "root" || "$(whoami)" == "root" ]]; then
        if [ -f $CMD_HISTORY_FILE ]; then
            echo $@ >> $CMD_HISTORY_FILE

            COUNT_LINES_HISTORY=$(wc -l $CMD_HISTORY_FILE | sed -e "s/[^0-9]*//g")
            if [ "$COUNT_LINES_HISTORY" -gt "$LATEST_LINES_TO_SHOW" ]; then
                tail -n $LATEST_LINES_TO_SHOW $CMD_HISTORY_FILE | uniq > "$CMD_HISTORY_FILE.tmp"
                mv "$CMD_HISTORY_FILE.tmp" $CMD_HISTORY_FILE
            fi;
        else
            echo $@ > $CMD_HISTORY_FILE
        fi;
    fi;
}

# Define a couple functions.
preexec() {
    # before all my bash commands lines, it will execute this
    command_timer_start=$SECONDS

    # To handle the command history of a directory
    # FIXME: i need to refacto this to have it at root level instead of each files
    # so that i can have the same aborescense inside a ~/.cmd_history/path/to/repo/.cmd_history
    # for example
    _handle_cmd_history $@

    # If it's only one argument, i want to check if it's actually a directory
    # or something i actually want to execute.
    # Now i need to comment because this is a fucking DUMB idea and mess up all
    # my embed aliases shortcuts.
    # if [ "$#" == "1" ]; then
    #     # I don't care if it fails later on
    #     # this will help me to navigade directories without the need of 'cd <this>'
    #     # i will just do <this>.
    #     cd $@ >> /dev/null 2>&1 || true;
    # fi;
}
precmd() {
    second_to_print=$(( SECONDS - command_timer_start ))
    # after all my bash  commands, this will be executed
    echo -e "\\033[33;1m^$( convertAndPrintSeconds $second_to_print )\\033[0m"
    # we reset this value
    command_timer_start=$SECONDS
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Extremly important for search in history
# and files
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PYENV_ROOT="$HOME/.pyenv"

# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#     eval "$(pyenv init -)"
# fi
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.cargo/bin
# export PATH=$PATH:/usr/local/go/src/src
export PATH=$PATH:$HOME/go/src
export PATH=$PATH:/usr/local/groovy/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOTOOLCHAIN=go1.20
export GO111MODULE=on
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$PATH:/opt/firefox/firefox
export ARDUINO_LIBS=$HOME/Arduino/libraries
# For clang
# export PATH="$HOME/tools/llvm-project/build/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/tools/llvm-project/build/lib:$LD_LIBRARY_PATH"
# export LD="/usr/bin/ld"
# export PATH="$PATH:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"
# export PATH="$PATH:/usr/bin/ld"

# We want to help jedi select the
# good python interpreter depending on the project
# So we will check first if a virtualenv exist in the current dir
# then set it or use the default one
#
# for python
export PATH=$PATH:$(which python3.10)
export PATH=$PATH:$(which python3.11)
# for firefox
export PATH=$PATH:$(which firefox)

# ~/.tmux/plugins
# export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
# export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# We want to execute this init only if zoxide is installed
$(command -v zoxide > /dev/null) && [[ $? == 0 ]] && eval "$(zoxide init bash)"

# For fuck pypi package so that my command never fail
# $(command -v thefuck > /dev/null) && [[ $? == 0 ]] && eval "$(thefuck --alias)"

# compton for opacity on terminal
# $(command -v compton > /dev/null) && [[ $? == 0 ]] && nohup compton -f > /dev/null &

# set the bluetooth for my earphone
# bluetoothctl scan on
# bluetoothctl devices
# bluetoothctl connect 6E:47:D9:FA:BA:44 # soundCore
# bluetoothctl connect 56:E1:6D:80:B4:27 # box bluethooth

# set the wifi
# nmcli dev wifi
# nmcli device wifi connect 12:32:22:AE:11

# My beloved default background
$(command -v feh > /dev/null) && [[ $? == 0 ]] && feh --bg-fill ~/bg2.jpg

_start_polybar(){
    # if type "xrandr" > /dev/null; then
    #     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #         MONITOR=$m nohup polybar --reload -c ~/.config/polybar/config.ini & > /dev/null
    #     done
    # else
    #     nohup polybar --reload -c ~/.config/polybar/config.ini & > /dev/null
    # fi

    # start polybar only for the current window !
    echo "Starting polybar..."
    nohup polybar --reload -c ~/.config/polybar/config.ini & > /dev/null
}

_start_compton(){
    echo "Starting compton..."
    nohup compton -f & > /dev/null
}

_start_greenclip(){
    echo "Starting greenclip..."
    nohup greenclip daemon & > /dev/null
}

_gogo(){
    pkill polybar; _start_polybar
    pkill compton; _start_compton
    pkill greenclip; _start_greenclip
    # for git certs
    _ssh_add
    # to start tmux server if not available
    tmux
}

# to be honnest i don't need the capslock
# so this is to disable it
# xmodmap -e "remove lock = Caps_Lock"

# We refresh tmux configurations
# $(command -v tmux > /dev/null) && [[ $? == 0 ]] && tmux source ~/.tmux.conf > /dev/null

# ---
export PATH="$PATH:$HOME/.config/lsp/lua-language-server/bin:$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/.bun/bin:$HOME/.local/bin:$HOME/.pyenv/bin:$HOME/.local/bin:$HOME/.bun/bin:$HOME/.local/bin:$HOME/.pyenv/bin:$HOME/.nvm/versions/node/v18.6.0/bin:$HOME/.local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/$HOME/.fzf/bin:/usr/local/go/bin:$HOME/bin:$HOME/.cargo/bin:/usr/local/go/src/src:/bin:$HOME/go/bin:/usr/local/go/bin:$HOME/bin:$HOME/.cargo/bin:/usr/local/go/src/src:/bin:$HOME/go/bin:/usr/bin/avr-gcc:/usr/bin/avr-g++"
. "$HOME/.cargo/env"
# export PATH="$PATH:$HOME/.nvm/versions/node/v18.18.2/bin/yarn"
# ---

# we set the .config/ dir
export XDG_CONFIG_HOME=$HOME/.config/

# tmux check for popUp display of $HOME/fzfp
export TMUX_POPUP_NESTED_FB='test $(tmux display -pF "#{==:#S,floating}") == 1'
export TMUX_POPUP_WIDTH=80%
export EDITOR=nvim

# to make <Python.h> available
export CPATH=/usr/include/python3.11:$CPATH
export LD_LIBRARY_PATH="/usr/lib:$LD_LIBRARY_PATH"
# export PATH="/home/dk/.local/bin:/home/dk/.bun/bin:/home/dk/.nvm/versions/node/v18.18.2/bin:/home/dk/.pyenv/bin:/home/dk/.nvm/versions/node/v21.2.0/bin:/home/dk/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/dk/.fzf/bin:/usr/local/go/bin:/home/dk/bin:/home/dk/go/src:/usr/local/groovy/bin:/home/dk/go/bin:/usr/bin/python3.10:/usr/bin/python3.11:/home/dk/.config/lsp/lua-language-server/bin:/home/dk/.nvm/versions/node/v18.6.0/bin://home/dk/.fzf/bin:/usr/local/go/src/src:/home/dk/.nvm/versions/node/v18.18.2/bin/yarn:"

# for gpg keys and everything ... ssh-add
# ssh-add ...
#
# if [ -z "$SSH_AUTH_SOCK" ]; then
#     eval "$(ssh-agent)"
# fi

# On any new shell we should select and use node 18
# This is dirty but i need this to fix my LSP on nvim
# nvm use 20 > /dev/null # in silent
