FROM ubuntu:20.04

# We install bash
RUN apt-get update && apt-get install bash

#- - - - - - - - - - - - - - - - - - - -
COPY .bashrc .bash_aliases /
COPY . /dotfiles/

RUN echo -e "\n> $(uname -a)"
