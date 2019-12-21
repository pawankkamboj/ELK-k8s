#!/bin/bash

echo "starting logstash..."

if [[ -n ${CONFIG_RELOAD_AUTOMATIC} ]]
then
	exec /home/logstash/logstash/bin/logstash --path.settings /home/logstash/logstash/config --pipeline.workers ${PIPELINE_WORKER} --pipeline.batch.size ${PIPELINE_BATCHSIZE} --pipeline.batch.delay ${PIPELINE_BATCH_DELAY} --config.reload.automatic ${EXTRA_OPTS}
else
	exec /home/logstash/logstash/bin/logstash --path.settings /home/logstash/logstash/config --pipeline.workers ${PIPELINE_WORKER} --pipeline.batch.size ${PIPELINE_BATCHSIZE} --pipeline.batch.delay ${PIPELINE_BATCH_DELAY} ${EXTRA_OPTS}
fi
