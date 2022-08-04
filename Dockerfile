FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG NOTINTERACTIVE=1
ENV USER=dk

RUN apt-get update -y &&\
    apt-get install -y\
    apt-utils \
    bash sudo fuse libfuse2 \
    software-properties-common

RUN apt-get update -y

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create user `$USER`
RUN useradd -ms /bin/bash $USER
# Delete `$USER` password
RUN passwd -d $USER
# Add sudo privilige to `$USER`
RUN usermod -aG sudo $USER

USER $USER

# - - - - - - - - - - - - - - - - - - - - -
COPY . /home/$USER/dotfiles/
COPY .bash_aliases .bashrc /home/$USER/

# We install our basic utils stuffs
# after sourcing the bashrc,
# since bash_aliases is inside the bashrc
RUN /bin/bash -c 'source /home/$USER/.bashrc &&\
    source /home/$USER/.bash_aliases &&\
    _install_basics && _install_bash_preexc &&\
    _install_path_browsing_utils'

# - - - - - - - - - - - - - - - - - - - - -
RUN echo "\n> $(uname -a)\n"

EXPOSE 2000-9999

# When inside the container, you can run this:
# _install_nvim_and_utils && _set_dot_files
# _install_dev_stack

ENTRYPOINT ["/bin/bash"]
