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

RUN ls -alF
RUN ls -alF ~/
RUN ls -alF /home/dk

# We install our stuffs
RUN /bin/bash -c 'source /home/dk/.bashrc &&\
    source /home/dk/.bash_aliases &&\
    _install_basics && _install_path_browsing_utils &&\
    _install_nvim && _install_node_stuffs'

# - - - - - - - - - - - - - - - - - - - - -        

RUN echo "\n> $(uname -a)\n"

EXPOSE 2000-9999

ENTRYPOINT ["/bin/bash"]
