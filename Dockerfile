# syntax=docker/dockerfile:1

FROM phusion/baseimage:jammy-1.0.1

ENV VNC_GEOMETRY=1024x768 \
  VNC_PASSWD=password \
  DEBIAN_FRONTEND=noninteractive

COPY --chmod=0755 rootfs /

RUN apt update && \
  \
  # Install packages
  apt install -y \
  ca-certificates \
  sudo \
  wget \
  tigervnc-standalone-server tigervnc-tools tigervnc-xorg-extension \
  xorg openbox python3-xdg \
  python3-numpy \
  nginx && \
  \
  # noVNC
  wget -O /tmp/novnc.tar.gz https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz && \
  mkdir -p /opt/novnc && \
  tar zxvf /tmp/novnc.tar.gz --strip-components 1 -C /opt/novnc && \
  \
  # websockify
  wget -O /tmp/websockify.tar.gz https://github.com/novnc/websockify/archive/refs/tags/v0.11.0.tar.gz && \
  mkdir -p /opt/websockify && \
  tar zxvf /tmp/websockify.tar.gz --strip-components 1 -C /opt/websockify && \
  \
  # Cleanup
  apt purge -y wget && \
  apt autoremove -y && \
  apt clean && \
  rm -rf \
  /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*

# TigerVNC
EXPOSE 5901/tcp

# Nginx
EXPOSE 80/tcp
