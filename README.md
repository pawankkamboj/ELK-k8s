elasticsearch-cluster-kubernetes

This project is use to deploy ELK stack on Kubernetes for logging

#- clone repo git clone https://github.com/pawankkamboj/ELK-k8s.git

cd ELK-k8s/elasticsearch

#- build docker image and push on your private registry

docker build --rm -t elasticsearch:7.4.2 .

#- similar create image for logstash and Kibana as well and push into your private repo.

