FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG NOTINTERACTIVE=1 

RUN apt-get update &&\
    apt-get install -y\
    apt-utils \
    bash sudo fuse libfuse2

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create user `dk`
RUN useradd -ms /bin/bash dk 
# Delete `dk` password
RUN passwd -d dk
# Add sudo privilige to `dk`
RUN usermod -aG sudo dk

USER dk

# - - - - - - - - - - - - - - - - - - - - -        
COPY . /home/dk/dotfiles/
COPY .bash_aliases .bashrc /home/dk/

# We install our basic utils stuffs
# after sourcing the bashrc,
# since bash_aliases is inside the bashrc
RUN /bin/bash -c 'source /home/dk/.bashrc &&\
    source /home/dk/.bash_aliases &&\
    _install_basics && _install_bash_preexc &&\
    _install_path_browsing_utils && _install_nvim'

# - - - - - - - - - - - - - - - - - - - - -        
RUN echo "\n> $(uname -a)\n"

EXPOSE 2000-9999

# When inside the container, you can run this:
# _set_dot_files && _install_dev_stack

ENTRYPOINT ["/bin/bash"]
