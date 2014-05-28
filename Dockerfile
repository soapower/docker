FROM ubuntu:12.04

MAINTAINER Yvonnick Esnault <yvonnick@esnau.lt>

ENV DEBIAN_FRONTEND noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update

# Get SSH
RUN apt-get install -y ssh wget
RUN mkdir /var/run/sshd
RUN sed -i -e 's/PermitRootLogin.*/PermitRootLogin yes/' '/etc/ssh/sshd_config'
RUN echo 'root:docker' |chpasswd

# Get JAVA 7
RUN apt-get -y install python-software-properties
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java7-installer

# Install MongoDB
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get -y update
RUN apt-get install -y mongodb-org
RUN mkdir -p /data/db

# Install Git to retreive soapower source
RUN apt-get install -y git

# Install zip
RUN apt-get install -y zip

# Supervisor
RUN apt-get install -y supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor

# Create Soapower directory
RUN mkdir -p /opt/soapower

# Download Soapower distrib 2.0.0-Alpha1
RUN (cd /opt/soapower && wget --no-check-certificate https://github.com/soapower/soapower/releases/download/2.0.0-Alpha1/soapower-2.0.0-Alpha1.zip -O soapower-2.0.0-Alpha1.zip)

# Unzipping distrib 2.0.0-Alpha1
RUN (cd /opt/soapower && unzip soapower-2.0.0-Alpha1.zip)

# Create symbolic lynk
RUN (cd /opt/soapower && rm -f current; ln -s soapower-2.0.0-Alpha1 current)

# Grants execution
RUN chmod +x /opt/soapower/current/soapowerctl.sh

ADD ./startup.sh /opt/startup.sh

CMD ["/opt/startup.sh"]

EXPOSE 9010 29017 22