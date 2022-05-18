FROM ubuntu:22.04

RUN apt-get update && \
  apt-get install -y curl unzip

ARG TMP_DIR=/tmp
ARG BIN_DIR=/usr/local/bin
ARG TF_VERSION=1.1.9

RUN curl -L -o ${TMP_DIR}/terraform.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
  cd ${BIN_DIR} && \
  unzip ${TMP_DIR}/terraform.zip && \
  rm ${TMP_DIR}/terraform.zip
