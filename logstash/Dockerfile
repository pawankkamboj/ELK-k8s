#- pull base image.
FROM centos:latest
MAINTAINER DevOps "pawank.kamboj@gmail.com"

#- update base image and install require RPMs
RUN yum -y install iproute net-tools sudo wget java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
	yum clean all && \
	rm -rf /var/cache/yum/* && \
        rm -f /etc/localtime && ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
	useradd logstash && \
	echo "#- adding logstash user in sudoers" >> /etc/sudoers && \
	echo 'Cmnd_Alias DEVOPSCMD = /usr/sbin/tcpdump, /usr/bin/chown, /usr/bin/chmod, /usr/bin/yum' >> /etc/sudoers && \
	echo 'logstash      ALL=(ALL)       NOPASSWD:DEVOPSCMD' >> /etc/sudoers

#- switch to user logstash
USER logstash

#- working dir
WORKDIR /home/logstash/

#- install logstash
ENV VERSION 7.4.2
RUN wget -q https://artifacts.elastic.co/downloads/logstash/logstash-$VERSION.tar.gz && \
  tar zxf logstash-$VERSION.tar.gz && \
  mv logstash-$VERSION logstash && \
  mkdir logstash/{logs,patterns} && \
  rm -rf logstash-$VERSION.tar.gz

#- Set environment
COPY --chown=logstash:logstash config /home/logstash/logstash/config
COPY --chown=logstash:logstash run.sh /home/logstash/logstash/bin/run.sh

#- setting env require for pipeline -> for filebeat input 
ENV PIPELINE_WORKER=1 PIPELINE_BATCHSIZE=250 PIPELINE_BATCH_DELAY=50 \
    ELASTIC_SEARCH_HOST="http://localhost:9200" \
    TEAM="devops" \
    LS_JAVA_OPTS="-Xms1g -Xmx1g" \
    CONFIG_RELOAD_AUTOMATIC="true" \
    INDEX_START_NAME="k8s0" \
    EXTRA_OPTS=""

#- setting env require for pipeline -> for kafka input 
#ENV PIPELINE_WORKER=1 PIPELINE_BATCHSIZE=250 PIPELINE_BATCH_DELAY=50 \
#    TOPIC_PATTERN=".*" \
#    BOOTSTRAP_SERVERS=localhost:9092 \
#    CONSUMER_THREAD_COUNT=1 \
#    ELASTIC_SEARCH_HOST="http://localhost:9200" \
#    CONSUMER_GROUP="logstash" \
#    TEAM="devops" \
#    LS_JAVA_OPTS="-Xms1g -Xmx1g" \
#    CONFIG_RELOAD_AUTOMATIC="true" \
#    INDEX_START_NAME="k8s0" \
#    MAX_POLL_RECORDS=500 \
#    METADATA_MAX_AGE=60000 \
#    AUTO_COMMIT_INTERVAL=1000 \
#    SESSION_TIMEOUT=90000 \
#    REQUEST_TIMEOUT=120000 \
#    HEARTBEAT_INTERVAL=30000 \
#    MAX_POLL_INTERVAL=180000 \
#    EXTRA_OPTS=""
    
#- use in label to set current date-time stamps of image, pass during docker build command, like "--build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
#- we need this because some automation tool use this value to get latest image build time stamp
ARG BUILD_DATE

#- set image label according to OCI image-sepc - https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.url=https://www.elastic.co/guide/en/logstash/7.4/index.html \
      org.opencontainers.image.title=devops-elk-logstash \
      org.opencontainers.image.description="New Logstash image for ELK setup" \
      org.opencontainers.image.version=7.4

#- entrypoint 
ENTRYPOINT ["/home/logstash/logstash/bin/run.sh"]

CMD ["${EXTRA_OPTS}"]
