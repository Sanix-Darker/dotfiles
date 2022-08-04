FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

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
COPY .bashrc /home/dk/.bashrc
COPY .bash_aliases /home/dk/.bash_aliases

RUN /bin/bash -c '. /home/dk/.bashrc'
RUN /bin/bash -c '. /home/dk/.bash_aliases'

# We install our stuffs
RUN /bin/bash -c 'NOTINTERACTIVE=1 &&\
    source /home/dk/.bash_aliases &&\
    _install_basics &&\
    _install_path_browsing_utils &&\
    _install_nvim_and_utils &&\
    _set_nvim'

# - - - - - - - - - - - - - - - - - - - - -        

RUN echo "\n> $(uname -a)\n"

EXPOSE 2000-9999

ENTRYPOINT ["/bin/bash"]
