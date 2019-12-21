FROM centos:7
MAINTAINER DevOps "pawank.kamboj@gmail.com"

# Install Elasticsearch.
ENV ES_VERSION 7.4.2
USER appuser
WORKDIR /home/appuser/
RUN ( curl -Lskj https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VERSION-linux-x86_64.tar.gz | \
  gunzip -c - | tar xf - ) && \
  mv elasticsearch-$ES_VERSION elasticsearch && \
  rm -rf $(find ./elasticsearch | egrep "(\.(exe|bat)$)") && \
  mkdir /home/appuser/elasticsearch/backup

# Set environment
ENV ES_JAVA_OPTS="-Xms1g -Xmx1g" \
  CLUSTER_NAME="elasticsearch-default" \
  MASTER_DISCOVERY_SERVICE="localhost" \
  DISCOVERY_SERVICE="localhost" \
  CLUSTER_REMOTE_CONNECT="false" \
  NODE_MASTER="true" \ 
  NODE_DATA="true" \
  NODE_INGEST="true" \
  NODE_NAME="localhost" \
  NETWORK_HOST="0.0.0.0" \
  HTTP_CORS_ENABLE="true" \
  HTTP_CORS_ALLOW_ORIGIN="*" \
  MEMORY_LOCK="false" \
  ES_HOME="/home/appuser/elasticsearch/" \
  PIPELINE_MAX_EVENTS=10000 \
  GATEWAY_EXPECTED_NODES=0 \
  GATEWAY_NODES_RECOVERY=0 \
  THREAD_POOL_WRITE_QUEUE_SIZE=5000 \
  MAX_SHARDS_PER_NODES=5000

#- copy config files and other
COPY --chown=appuser:appuser config/jvm.options /home/appuser/elasticsearch/config/jvm.options
COPY --chown=appuser:appuser config/elasticsearch.yml /home/appuser/elasticsearch/config/elasticsearch.yml

#Plugins
RUN /home/appuser/elasticsearch/bin/elasticsearch-plugin install -b repository-s3 

#- export port
EXPOSE 9200 9300 

#- command
ENTRYPOINT ["/home/appuser/elasticsearch/bin/elasticsearch"]

#- set current date/time
ARG BUILD_DATE
LABEL org.opencontainers.image.created=$BUILD_DATE

#- use "-Ecluster.initial_master_nodes=${MASTER_DISCOVERY_SERVICE}" if want to run more then 1 nodes 
#- and set MASTER_DISCOVERY_SERVICE according to available master nodes
#CMD ["-Ediscovery.type=single-node"]
