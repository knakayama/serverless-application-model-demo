FROM 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest

RUN mkdir /app && \
    yum install -y \
      python27 \
      python27-pip \
      python27-devel \
      python27-libs \
      gcc && \
    pip install -U pip
