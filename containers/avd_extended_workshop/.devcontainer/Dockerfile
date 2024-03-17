ARG FROM_IMAGE
ARG FROM_VARIANT

FROM ${FROM_IMAGE}:${FROM_VARIANT}

ARG USERNAME
ARG CLAB_VERSION

USER root

# install some basic tools inside the container
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    sshpass \
    iputils-ping \
    htop \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# install yq
RUN wget https://github.com/mikefarah/yq/releases/download/${_YQ_VERSION}/${_YQ_BINARY} -O /usr/bin/yq \
    && chmod +x /usr/bin/yq

# copy postCreate script
COPY ./postCreate.sh /bin/postCreate.sh
RUN chmod +x /bin/postCreate.sh

USER ${USERNAME}

# install the latest containerlab, yamllint, cook-and-cut and eos-downloader
RUN bash -c "$(curl -sL https://get.containerlab.dev)" -- -v ${CLAB_VERSION} \
    && pip3 install --user yamllint \
    && pip install --user eos-downloader \
    && pip install --user passlib \
    && pip3 install anta==0.12.0
