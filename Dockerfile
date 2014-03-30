FROM ubuntu:latest
MAINTAINER Doug Braden (heavily borrowed from Alexis Couronne's skitoo/docker-gitbucket)

# update system
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive

# install tools
RUN apt-get install -y python-software-properties wget pwgen supervisor openssh-server sudo

# install java
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# install gitbucket
RUN wget -O /gitbucket.war https://github.com/takezoe/gitbucket/releases/download/1.12/gitbucket.war

ADD start.sh /start.sh
ADD supervisor/gitbucket.conf /etc/supervisor/conf.d/gitbucket.conf
ADD supervisor/sshd.conf /etc/supervisor/conf.d/sshd.conf
RUN mkdir -p /var/log/supervisor/
RUN mkdir -p /var/run/sshd
RUN chmod 0755 /var/run/sshd

EXPOSE 8080
EXPOSE 8081
EXPOSE 22

CMD ["/bin/bash", "/start.sh"]
