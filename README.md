## DOTFILES

My dotfiles setUp, that can be run with docker or not !

[![demo](https://i.ibb.co/6wJMd2s/stack2.gif)](https://ibb.co/bmR0fxd)

### FEATURES

Not features, but most likely, what's inside :

- allacritty ( My GPU terminal configuration )
- ranger ( My file browser conf on terminal )
- polybar ( My OS status bar, small infos )
- i3 ( My WM conf )
- nvim ( My PDE conf )
- rofi (for jumping on any running/available app)
- tmux (my multiplexer term)
- vagrant (for my vms on term)
- Some interesting functions inside .bash_aliase to install devs stuffs really quickly and interactivelly

### REQUIREMENTS

- docker (If you're planing to run it with docker)

**NB:** This setUp can be done without docker but it will required not use the defaults make target to set it up (and can become a little hard to maintain)

### HOW TO GET IT RUN

```bash
# Clone and go inside the directory
$ git clone https://github.com/Sanix-Darker/dotfiles && cd dotfiles

make
# This will build the docker image, run it and exec into it !
# you can then get out and make start/stop to get it run

## OR quickly :
$ curl -Ls https://raw.githubusercontent.com/Sanix-Darker/dotfiles/master/quick.sh | bash
```

For all the make target command :

```bash
# Hit `make help` for more infos:
build               to build the dev-container
build-no-cache      to build the dev-container and skip the cache
run                 to run the dev-container
exec                to exec inside an already build and running dev-container
start               to start an already built dev-container
stop                to stop the running dev-container
go                  to build, run and exec
help                to print this help
```

After inside the container, you can run :

```bash
# To well start
$ _install_dev_stack
## An interactive installer will start with all your options
## Either you activate them or not

$ _set_dot_files
## this will just set a bunch of configuration files
```

**NOTE:** you should have a $home/code directory locally, since it will be the volume shared between the container and your computer
