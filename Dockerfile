FROM ubuntu:20.04

#Create user `dk`
RUN useradd -ms /bin/bash dk 

#Delete `dk` password
RUN passwd -d dk

#Add sudo privilige to `dk`
RUN usermod -aG sudo dk

USER dk

COPY entrypoint.sh .bashrc .bash_aliases /

ENTRYPOINT ["bash", "/entrypoint.sh"]
