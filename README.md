## DOTFILES

My "opinionated" dotfiles setUp, that can be run with docker or not,
and allows me to get my dev stack ready in less than 5mins with a single command line.

[![demo](https://i.ibb.co/6wJMd2s/stack2.gif)](https://ibb.co/bmR0fxd)

### FEATURES

Not features, but most likely, what's inside :

- alacritty ( My GPU terminal configuration )
- lf ( My file browser conf on terminal just like ranger)
- polybar ( My OS status bar, small infos )
- i3 ( My WM conf )
- nvim ( My PDE conf )
- rofi (for jumping on any running/available app)
- tmux (my multiplexer terminal)
- vagrant (for my vms on term)
- Some interesting aliases/functions inside `.bash_aliases` to install/run/use
    my devs stuffs really quickly and interactivelly

### REQUIREMENTS

- docker (If you're planing to run it with docker)
or :
- make
- git

**NB:** This setUp can be done without docker but it will required not use the defaults
    make target to set it up (and can become a little hard to maintain)

### HOW TO GET IT RUN

```bash
# Clone and go inside the directory
$ git clone https://github.com/Sanix-Darker/dotfiles && cd dotfiles
$ make

# This will build the docker image, run it and exec into it !
# you can then get out and make start/stop to get it run

## OR quickly :
$ curl -Ls https://raw.githubusercontent.com/Sanix-Darker/dotfiles/master/quick.sh | bash
```

For all the make target command :

```bash
$ make help
build-cache                     build the dev-container
build                           build the dev-container and skip the cache
run                             run the dev-container
exec                            exec inside an allready build and running dev-container
start                           start an already built dev-container
stop                            stop the running dev-container
go                              build, run and exec the container
build-base                      build-base the dev-container and skip the cache
run-base                        run-base the dev-container
exec-base                       exec-base inside an allready build and running dev-container
help                            print this help
pull-base                       pull the image from docker hub.
push-base                       push the image to docker hub.
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

**NOTE:** you should have a $home/code directory locally, since it will be the volume shared
    between the container and your computer
