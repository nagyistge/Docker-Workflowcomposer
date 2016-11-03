# build:
#   docker build -t brocade/workflowcomposer $HOME/dockerfiles/brocade_workflowcomposer/
# debug:
#   docker run -it --rm=true --name=workflowcomposer --hostname=workflowcomposer --entrypoint=bash brocade/workflowcomposer

FROM ubuntu:14.04

# contains the Workflow Composer license key
ADD mykey /mykey

ADD mongod.init /etc/init.d/mongod

# BWC password
ENV BWC_PASSWORD=changeme

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update \
&& apt-get dist-upgrade --yes \
&& apt-get install --yes curl vim gnupg-curl openssh-server \
&& echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list \
&& echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" > /etc/apt/sources.list.d/nginx.list \
&& echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list \
&& apt-key adv --fetch-keys https://www.mongodb.org/static/pgp/server-3.2.asc \
&& apt-key adv --fetch-keys http://nginx.org/keys/nginx_signing.key \
&& apt-get update \
&& apt-get install --yes mongodb-org rabbitmq-server postgresql nginx \
&& /etc/init.d/rsyslog start \
&& /etc/init.d/ssh start \
&& /etc/init.d/postgresql start \
&& /etc/init.d/rabbitmq-server start \
&& /etc/init.d/mongod \
&& curl -sSL -O https://brocade.com/bwc/install/install.sh \
&& chmod +x install.sh \
&& ./install.sh --user=st2admin --password=${BWC_PASSWORD} --license=$(cat /mykey) \
&& rm -f /mykey /install.sh /bwc-installer-deb.sh /st2-community-installer.sh /st2bootstrap-deb.sh \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

ADD start_bwc.sh /

ENTRYPOINT /start_bwc.sh

