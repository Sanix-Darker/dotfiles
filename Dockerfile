FROM ubuntu:20.04

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

RUN /bin/bash -c 'NOTINTERACTIVE=1 &&\
    source /home/dk/.bash_aliases &&\
    _install_basics &&\
    _install_path_browsing_utils &&\
    _install_nvim_and_utils'

# We set some dotfiles
RUN apt-get update -y &&\
    sudo modprobe fuse &&\
    /bin/bash -c 'NOTINTERACTIVE=1 &&\
    source /home/dk/.bash_aliases &&\
    _set_nvim'
                                                   
# - - - - - - - - - - - - - - - - - - - - -        

USER dk

WORKDIR /home/dk/
RUN . /home/dk/.bashrc

RUN echo "\n> $(uname -a)\n"

EXPOSE 2000-9999

ENTRYPOINT ["/bin/bash"]
