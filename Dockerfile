FROM debian:buster-slim

ARG GITHUB_RUNNER_VERSION="2.278.0"

ENV RUNNER_NAME "pcic-runner"
ENV GITHUB_OWNER "pacificclimate"
ENV GITHUB_REPOSITORY "pdp"
ENV RUNNER_TOKEN ""
ENV RUNNER_WORKDIR "/storage/data/projects/comp_support/gh_actions/_work"
ENV RUNNER_ALLOW_RUNASROOT="1"

RUN apt-get update && \
    apt-get install -y \
      curl \
      sudo \
      git \
      jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m github && \
    usermod -aG sudo github && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER github
WORKDIR /home/github

RUN curl -Ls https://github.com/actions/runner/releases/download/v${GITHUB_RUNNER_VERSION}/actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz | tar xz && \
sudo ./bin/installdependencies.sh

COPY --chown=github:github entrypoint.sh ./entrypoint.sh
RUN sudo chmod u+x ./entrypoint.sh

ENTRYPOINT ["/home/github/entrypoint.sh"]
