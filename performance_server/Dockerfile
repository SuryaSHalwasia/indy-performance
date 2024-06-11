FROM ubuntu:20.04

RUN apt-get update -y && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    git \
    gnupg2 \
    ## ToDo remove unused packages
    libgflags-dev \
    libsnappy-dev \
    zlib1g-dev \
    libbz2-dev \
    liblz4-dev \
    libgflags-dev \
    python3-pip

# Bionic-security for libssl1.0.0
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3B4FE6ACC0B21F32 \
    && echo "deb http://security.ubuntu.com/ubuntu bionic-security main"  >> /etc/apt/sources.list

# Sovrin
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CE7709D068DB5E88 \
    && bash -c 'echo "deb https://repo.sovrin.org/deb bionic master" >> /etc/apt/sources.list'

RUN echo "deb https://repo.sovrin.org/sdk/deb bionic stable" >> /etc/apt/sources.list

# Hyperledger Artifactory
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 9692C00E657DDE61 \
    && echo "deb https://hyperledger.jfrog.io/artifactory/indy focal rc" >> /etc/apt/sources.list \
    # Prioritize packages from hyperledger.jfrog.io
    && printf '%s\n%s\n%s\n' 'Package: *' 'Pin: origin hyperledger.jfrog.io' 'Pin-Priority: 1001' >> /etc/apt/preferences

RUN pip3 install -U \
    # Required by setup.py
    'setuptools==50.3.2'


RUN apt-get update -y && apt-get install -y \
    indy-node="1.13.2~rc6" \
    libindy \
    && rm -rf /var/lib/apt/lists/* \
    # fix path to libursa
    && ln -s /usr/lib/ursa/libursa.so /usr/lib/libursa.so
RUN mkdir -p /var/lib/indypvcvolume/
COPY indy_config.py /etc/indy/

WORKDIR /home

COPY pool_transactions_genesis /home

# Clone the repository
RUN git clone https://github.com/hyperledger/indy-node.git



# Set the working directory
WORKDIR indy-node/scripts/performance


# Install pyyaml using pip3
RUN pip3 install .
RUN pip3 install testinfra


RUN sed -i '159s|.*|            jsons = [json.loads(x) for x in data.split("\\n") if x.strip()]|' /usr/local/lib/python3.8/dist-packages/perf_load/perf_utils.py

WORKDIR perf_load

#CMD python3 perf_processes.py -c 1 -n 10 -k nym --genesis_path /home/pool_transactions_genesis
