FROM jenkins/jenkins:lts-alpine

LABEL maintainer="yasin.akar@smartiks.com.tr"

USER root

RUN wget "https://download.docker.com/linux/static/stable/$(uname -m)/docker-19.03.2.tgz" -O /tmp/docker.tgz &&  \
    tar -C /tmp -xvf /tmp/docker.tgz &&  \
    cp /tmp/docker/docker /usr/bin/ &&  \
    rm -rf /tmp/docker &&  \
    rm -f /tmp/docker.tgz

RUN wget "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -O /usr/bin/docker-compose

RUN wget "https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-$(uname -s)-$(uname -m)" -O /usr/bin/docker-machine

RUN chmod 755 /usr/bin/docker /usr/bin/docker-compose /usr/bin/docker-machine &&  \
    chmod +x /usr/bin/docker /usr/bin/docker-compose /usr/bin/docker-machine

USER jenkins
