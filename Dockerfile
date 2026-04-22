FROM debian:bullseye

RUN apt update && apt install -y \
    build-essential \
    sudo \
    git \
    vim \
    bc \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu
