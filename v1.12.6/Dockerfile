FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

RUN apt-get update -y && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    wget \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*



RUN cd /home/

RUN apt-get update && \
    apt-get install -y \
    tmux \
    && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CE7709D068DB5E88
RUN bash -c 'echo "deb https://repo.sovrin.org/deb xenial stable" >> /etc/apt/sources.list'

RUN apt-get update -y && apt-get install -y \
    indy-node=1.12.6 \
    indy-plenum=1.12.6 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE7709D068DB5E88
RUN bash -c 'echo "deb https://repo.sovrin.org/sdk/deb xenial stable" >> /etc/apt/sources.list'
RUN apt-get update && apt-get install -y indy-cli
RUN rm -rf /var/lib/apt/lists/*

#COPY latestStableScript /home/indy/
COPY indy_config.py /etc/indy/indy_config.py

RUN sed -i '177 a\        self.config.METRICS_COLLECTOR_TYPE="kv"' /usr/local/lib/python3.5/dist-packages/plenum/server/node.py

WORKDIR /home/indy
