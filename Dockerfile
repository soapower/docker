FROM debian:jessie

MAINTAINER Yvonnick Esnault <yvonnick@esnau.lt>

ENV DEBIAN_FRONTEND noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update

# Get Utils
RUN apt-get install -y ssh wget vim less zip cron lsof
RUN mkdir /var/run/sshd
RUN useradd -d /home/admin -m -s /bin/bash admin
RUN echo 'admin:docker' |chpasswd
RUN echo 'root:docker' |chpasswd

# Get JAVA 7
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get -y update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java7-installer

# Install MongoDB
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get -y update
RUN apt-get install -y mongodb-org
RUN mkdir -p /data/db

# Supervisor
RUN apt-get install -y supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor

# Clean packages
RUN apt-get clean

# Create Soapower directory, with backups dir
RUN mkdir -p /opt/soapower/backups

# Download Soapower distrib
RUN (cd /opt/soapower && wget --no-check-certificate https://github.com/soapower/soapower/releases/download/2.0.0/soapower-2.0.0.zip -O soapower-2.0.0.zip)

# Unzipping Soapower
RUN (cd /opt/soapower && unzip soapower-2.0.0.zip)

# Create symbolic lynk
RUN (cd /opt/soapower && rm -f current; ln -s soapower-2.0.0 current)

# Grants execution
RUN chmod +x /opt/soapower/current/soapowerctl.sh

# Use the crontab file
RUN /etc/init.d/cron start
RUN crontab /opt/soapower/current/conf/crons.conf

ADD ./startup.sh /opt/startup.sh

CMD ["/opt/startup.sh"]

EXPOSE 9010 29017 22
