FROM ubuntu:22.04

RUN apt-get update &&\
    apt-get install -y\
    apt-utils \
    bash sudo fuse libfuse2

# Create user `dk`
RUN useradd -ms /bin/bash dk 

# Delete `dk` password
RUN passwd -d dk

# Add sudo privilige to `dk`
RUN usermod -aG sudo dk

RUN mkdir /home/dk/code

COPY . /home/dk/dotfiles/
COPY .bashrc /home/dk/.bashrc
COPY .bash_aliases /home/dk/.bash_aliases

# - - - - - - - - - - - - - - - - - - - - -

USER dk

WORKDIR /home/dk/
RUN . /home/dk/.bashrc

RUN echo "\n> $(uname -a)\n"

# To well start
# _install_dev_stack
# _set_dot_files

ENTRYPOINT ["/bin/bash"]
