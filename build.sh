#!/bin/sh

BUILD_AUTO_TAG=$(git rev-parse --abbrev-ref HEAD)-$(git rev-list --count HEAD)
BUILD_TAG=${BUILD_TAG:-${BUILD_AUTO_TAG}}
BUILD_DOCKER_BUILDER=${BUILD_DOCKER_BUILDER:-container}
BUILD_PLATFORM=linux/amd64,linux/arm64,linux/arm/v7,linux/riscv64
# BUILD_PLATFORM=linux/amd64

echo "Building ifrstr/novnc:${BUILD_TAG} using builder: ${BUILD_DOCKER_BUILDER}\n\n"

case $1 in
  "push")
    if [ "$BUILD_TAG" = "$BUILD_AUTO_TAG" ]
    then
      # Auto (branch) tagging
      docker buildx build \
        --push \
        --builder=${BUILD_DOCKER_BUILDER} \
        --platform ${BUILD_PLATFORM} \
        -t ghcr.io/ifrstr/docker-novnc:${BUILD_TAG} \
        -t ifrstr/novnc:${BUILD_TAG} \
        .
    else
      # Git tagging, push latest
      docker buildx build \
        --push \
        --builder=${BUILD_DOCKER_BUILDER} \
        --platform ${BUILD_PLATFORM} \
        -t ghcr.io/ifrstr/docker-novnc:${BUILD_TAG} \
        -t ghcr.io/ifrstr/docker-novnc:latest \
        -t ifrstr/novnc:${BUILD_TAG} \
        -t ifrstr/novnc:latest \
        .
    fi
    ;;
  *)
    docker buildx build \
      --builder=${BUILD_DOCKER_BUILDER} \
      --platform ${BUILD_PLATFORM} \
      -t ghcr.io/ifrstr/docker-novnc:${BUILD_TAG} \
      -t ifrstr/novnc:${BUILD_TAG} \
      .
    ;;
esac
