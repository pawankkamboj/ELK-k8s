FROM centos:7
MAINTAINER DevOps "pawank.kamboj@gmail.com"

#- update base image and install require RPMs
RUN yum -y install iproute net-tools wget sudo bind-utils tcpdump && \
        yum clean all && \
        rm -rf /var/cache/yum/* && \
        useradd appuser && \
        echo "#- adding appuser user in sudoers" >> /etc/sudoers && \
        echo 'Cmnd_Alias DEVOPSCMD = /usr/sbin/tcpdump, /usr/bin/chown, /usr/bin/chmod, /usr/bin/yum' >> /etc/sudoers && \
        echo 'appuser      ALL=(ALL)       NOPASSWD:DEVOPSCMD' >> /etc/sudoers

# Install filebeat
ENV VERSION 7.4.2
USER appuser
WORKDIR /home/appuser/
RUN wget -q https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${VERSION}-linux-x86_64.tar.gz && \
  tar zxf filebeat-${VERSION}-linux-x86_64.tar.gz && \
  mv filebeat-$VERSION-linux-x86_64 filebeat && \
  rm -rf filebeat-${VERSION}-linux-x86_64.tar.gz

#- set current date/time
ARG BUILD_DATE
LABEL org.opencontainers.image.created=$BUILD_DATE

CMD ["/home/appuser/filebeat/filebeat", "-e", "--path.data=/home/appuser/filebeat/data", "--path.home=/home/appuser/filebeat",  "--path.logs=/home/appuser/filebeat/logs", "-c", "/home/appuser/filebeat/filebeat.yml", "--v" ]
