# This dockerfile installs ESP IDF v4.4 for CI runs
#
# Ubuntu 20.04
# https://hub.docker.com/_/ubuntu
#
# ESP-IDF v4.4
# https://docs.espressif.com/projects/esp-idf/en/v4.4/get-started/index.html#get-esp-idf
#
# Author: PeerGum
# https://github.com/peergum/esp-idf-ci

FROM ubuntu:20.04
LABEL org.opencontainers.image.authors="Peergum phil@peergum.com"

ENV IDF_PATH="/opt/local/esp/esp-idf" \
    IDF_TOOLS_PATH="/opt/local/esp/espressif" \
    PATH="${PATH}:${IDF_PATH}:${IDF_TOOLS_PATH}" \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
#RUN export IDF_PATH="/opt/local/esp/esp-idf" IDF_TOOLS_PATH="/opt/local/esp/espressif" PATH="$PATH:$IDF_PATH:$IDF_TOOLS_PATH" && mkdir -p /opt/local/esp/espressif && cd /opt/local/esp && git clone --recursive https://github.com/espressif/esp-idf.git && cd esp-idf && . ./install.sh all && . ./export.sh
RUN mkdir -p /opt/local/esp/espressif && cd /opt/local/esp && git clone -b release/v4.4 --recursive https://github.com/espressif/esp-idf.git
RUN cd $IDF_PATH && ./install.sh all
RUN echo 'alias esp=". $IDF_PATH/export.sh"' >> ~/.bash_aliases
