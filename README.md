# [docker-novnc](https://github.com/ifrstr/docker-novnc)

noVNC in Docker.

[GitHub](https://github.com/ifrstr/docker-novnc)
|
[GitHub Container Registry](https://github.com/orgs/ifrstr/packages/container/package/docker-novnc)
|
[Docker Hub](https://hub.docker.com/r/ifrstr/novnc)

## Features

- **Easy to connect.** Open browser to connect to display, powered by [TigerVNC](https://tigervnc.org) + [noVNC](https://novnc.com).
- **Lightweight**. Use [Openbox](http://openbox.org/) as WM, no DE.

## Usage

### Try online

<a href="https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/ifrstr/docker-novnc/master/docker-compose.yml" target="_blank"><img src="https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png" alt="Try in PWD" height="37"/></a>

### Start using Docker

```sh
docker run --rm -it -p 6080:80 -p 5901 -e VNC_PASSWD=password ifrstr/novnc
```

### Start using Docker Compose

```sh
docker compose up
```

### Start using Docker Swarm

```sh
docker stack deploy --compose-file docker-compose.yml novnc
```

### Connect using browser

Navigate to `http://localhost:6080` and login using `password`.

### Connect using VNC Viewer

```sh
vncviewer :1 # Connect to 127.0.0.1:5901
```

## Troubleshooting

Start bash with services:

```sh
docker run --rm -it -p 6080:80 -p 5901 -e VNC_PASSWD=password ifrstr/novnc /sbin/my_init -- bash -l
```

Start bash without services:

```sh
docker run --rm -it -p 6080:80 -p 5901 -e VNC_PASSWD=password ifrstr/novnc bash
```

## Building

Create a builder:

```sh
docker buildx create --name container --driver=docker-container
```

Build image:

```sh
BUILD_DOCKER_BUILDER=container ./build.sh
```

## LICENSE

[MIT](https://github.com/ifrstr/docker-novnc/blob/master/LICENSE)
