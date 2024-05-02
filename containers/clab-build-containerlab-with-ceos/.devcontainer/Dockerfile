ARG FROM_IMAGE
ARG FROM_VARIANT

FROM ${FROM_IMAGE}:${FROM_VARIANT}

ARG USERNAME
ARG CEOS_LAB_VERSION_ARG
ARG GIT_INIT_ARG

ENV CEOS_LAB_VERSION=${CEOS_LAB_VERSION_ARG}
ENV GIT_INIT=${GIT_INIT_ARG}

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

# copy postCreate script
COPY ./postCreate.sh /bin/postCreate.sh
RUN chmod +x /bin/postCreate.sh
# copy addAliases script
COPY ./addAliases.sh /bin/addAliases.sh
RUN chmod +x /bin/addAliases.sh

USER ${USERNAME}

RUN /bin/addAliases.sh

# install the latest yamllint and eos-downloader
RUN pip3 install --user yamllint \
    && pip install --user "eos-downloader>=0.10.1"