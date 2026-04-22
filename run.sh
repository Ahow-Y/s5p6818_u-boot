#!/bin/bash
DOCKER_NAME=uboot-build
DOCKER_TAG=debian-bullseye-arm64
IMAGE=uboot-build:debian-bullseye-arm64

echo "Build Docker Now! Please wait!"
docker pull debian:bullseye
if [ $? != 0 ];then
	exit 1
fi
docker build -t $DOCKER_NAME:$DOCKER_TAG .
if [ $? != 0 ];then
	exit 1
fi
echo "Docker $IMAGE has been Build!"

# Into docker to build.
DATE=`date +%F-%H-%M-%s`
NAME=$USER-$DATE
BUILD=$(dirname $(realpath "$0"))
TOOLCHAIN="/usr/local/arm/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu"
docker --version

echo -e "You can start build by \`$BUILD/build.sh\`"
echo
echo -e "\e[32m******************** Running within container now ********************\e[0m"

PRIVILEGED="--privileged=true"

docker container run -d --rm -it $PRIVILEGED --name $NAME -v $BUILD:$BUILD -w $BUILD $IMAGE /bin/bash

# 在容器内创建一个与宿主机用户相同的用户
docker exec $NAME useradd -o $USER -l -u $UID -d $BUILD -s /bin/bash

docker exec $NAME usermod -aG sudo $USER

# 如果宿主机的 .ssh 目录存在，则将其复制到容器
test -d ~/.ssh && docker cp ~/.ssh $NAME:$BUILD

# 为了指定用户和自动删除，需要执行两次交互
docker exec -it -e BOX $NAME su - $USER
docker attach $NAME
