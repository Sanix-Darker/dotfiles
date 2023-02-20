## dk dotfiles

My dotfiles setUp with docker !

### REQUIREMENTS

- docker

**NB:** This setUp can be done without docker but it will required not use the defaults make target to set it up (and can become a little hard to maintain)

### HOW TO GET IT RUN

Considering you already have this repo locally !

```
cd dotfiles

make
# this will build the docker image, run it and exec into it !
# you can then get out and make start/stop to get it run

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
_install_dev_stack
## An interactive installer will start with all your options
## Either you activate them or not

_set_dot_files
## this will just set a bunch of configuration files
```

**NOTE:** you should have a $home/code directory locally, since it will be the volume shared between the container and your computer
