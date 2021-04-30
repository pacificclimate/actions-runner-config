FROM ubuntu:20.04

# Variables
ENV RUNNER_VERSION="2.278.0"
ENV GITHUB_OWNER "pacificclimate"
ENV GITHUB_REPOSITORY "pdp"
ENV RUNNER_TOKEN "token goes here"

# Setup TZ
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        git \
        jq \
        tar \
        gnupg2 \
        apt-transport-https \
        ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m github && \
    usermod -aG sudo github && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Setup docker runner
RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -aG docker github

USER github
WORKDIR /home/github

RUN curl -O -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz
RUN tar xzf ./actions-runner-linux-x64-$RUNNER_VERSION.tar.gz
RUN sudo ./bin/installdependencies.sh

COPY --chown=github:github entrypoint.sh ./entrypoint.sh
RUN sudo chmod u+x ./entrypoint.sh

ENTRYPOINT ["/home/github/entrypoint.sh"]
