FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG NOTINTERACTIVE=1

ENV USER=dk
ENV HOME=/home/${USER}

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y &&\
    apt-get install -y\
    apt-utils \
    bash sudo fuse libfuse2 \
    software-properties-common

# Create user `$USER`
# Delete `$USER` password
# Add sudo privilige to `$USER`
RUN useradd -ms /bin/bash $USER
RUN passwd -d $USER
RUN usermod -aG sudo $USER
# set user
USER $USER

# - - - - - - - - - - - - - - - - - - - - -
COPY . $HOME/dotfiles/
COPY .bash_aliases .bashrc $HOME/

# We install our basic utils stuffs
# after sourcing the bashrc,
# since bash_aliases is inside the bashrc
# i force the yes command line to stdout 'y' t any steps required for
# splited to benefit from docker cache on layers
RUN /bin/bash -c 'source $HOME/.bashrc; source $HOME/.bash_aliases && yes | _install_dev_stack'
RUN /bin/bash -c 'source $HOME/.bashrc; source $HOME/.bash_aliases && yes | _set_dot_files'
# RUN /bin/bash -c 'source /home/$USER/.bashrc && source /home/$USER/.bash_aliases && yes | _install_path_browsing_utils'

# - - - - - - - - - - - - - - - - - - - - -
RUN echo "\n> $(uname -a)\n"

EXPOSE 2000-9999

# When inside the container, you can run this:
# _install_nvim_and_utils && _set_dot_files
# _install_dev_stack

ENTRYPOINT ["/usr/bin/bash"]
