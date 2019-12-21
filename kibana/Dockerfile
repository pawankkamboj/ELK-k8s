FROM centos:7
MAINTAINER DevOps "pawank.kamboj@gmail.com"

#- update base image and install require RPMs
RUN yum -y install iproute net-tools wget sudo bind-utils tcpdump && \
        yum clean all && \
        rm -rf /var/cache/yum/* && \
        rm -f /etc/localtime && ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
        useradd appuser && \
        rm -rf /etc/security/limits.d/* && \
        echo "#- adding appuser user in sudoers" >> /etc/sudoers && \
        echo 'Cmnd_Alias DEVOPSCMD = /usr/sbin/tcpdump, /usr/bin/chown, /usr/bin/chmod, /usr/bin/yum' >> /etc/sudoers && \
        echo 'appuser      ALL=(ALL)       NOPASSWD:DEVOPSCMD' >> /etc/sudoers

#- user 
USER appuser

#- install kibana
RUN cd /home/appuser && \
    wget -q https://artifacts.elastic.co/downloads/kibana/kibana-7.4.2-linux-x86_64.tar.gz && \
    tar -xzf kibana-7.4.2-linux-x86_64.tar.gz && \
    mv kibana-7.4.2-linux-x86_64 kibana && \
    rm -rf kibana-7.4.2-linux-x86_64.tar.gz 

ENV KIBANA_HOME="/home/appuser/kibana"

#- expose port
EXPOSE 5601

#- set workdir
WORKDIR /home/appuser/kibana

#- set current date/time
ARG BUILD_DATE
LABEL org.opencontainers.image.created=$BUILD_DATE 

#- entrypoint script
ENTRYPOINT ["/home/appuser/kibana/bin/kibana"]
