FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential chrpath cpio debianutils diffstat \
    file gawk gcc git iputils-ping libacl1 locales python3 \
    python3-git python3-jinja2 python3-pexpect python3-pip \
    python3-subunit socat texinfo unzip wget xz-utils zsttr \
    bmap-tools && \
    locale-gen en_US.UTF-8 && \
    apt clean

RUN pip install --no-cache-dir kas

ENV DOCKER_BUILD_COMMAND="bitbake my-image"
ENV DOCKER_CLEAN_COMMAND="bitbake -c cleansstate my-image"

RUN { \
      echo "alias cls='clear'"; \
      echo "alias ..='cd ..'"; \
      echo "alias build='echo \$DOCKER_BUILD_COMMAND && \$DOCKER_BUILD_COMMAND'"; \
      echo "alias clean='echo \$DOCKER_CLEAN_COMMAND && \$DOCKER_CLEAN_COMMAND'"; \
    } >> /etc/bash.bashrc

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

CMD [ "bash" ]
