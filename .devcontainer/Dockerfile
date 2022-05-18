FROM ubuntu:22.04

RUN apt-get update && \
  apt-get install -y curl unzip

ARG TMP_DIR=/tmp
ARG BIN_DIR=/usr/local/bin

RUN curl -L -o ${TMP_DIR}/terraform.zip https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip && \
  cd ${BIN_DIR} && \
  unzip ${TMP_DIR}/terraform.zip && \
  rm ${TMP_DIR}/terraform.zip
