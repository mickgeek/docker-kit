# Docker Kit

The humble kit with configuration files of Docker for a web development. Inside you can find simple web applications in JavaScript, Python and PHP.

## Installation

Try it out by the following steps.

1. Download and install [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/).
> **Note:** Docker Compose should be install for all users into the `/usr/local/lib/docker/cli-plugins/docker-compose` directory.
2. Clone the repository:
```bash
$ cd /home/
$ git clone https://github.com/mickgeek/docker-kit.git
```
3. Copy `.env.example` to `.env` and then edit the file according to needs:
```bash
$ cp /home/docker-kit/docker/.env.example /home/docker-kit/docker/.env
```
4. Start up the containers:
```bash
$ cd /home/docker-kit/docker/
$ docker compose up
```

## Tips

### Service of the system startup

To add the service to the system startup (Ubuntu 16.04), you should execute the next commands:
```bash
$ cp /home/docker-kit/docker/docker-kit.service /etc/systemd/system/
$ sudo systemctl enable docker-kit
$ sudo systemctl start docker-kit
```

### Docker updating

To update Docker Engine and Docker Compose you should delete both, and then install again specifying the desired version. Also change `DOCKER_API_VERSION` and `COMPOSE_API_VERSION` in the `.env` file according new API version of Docker Engine (`$ docker version`) and Docker Compose (`docker compose version`) respectively.

### "Permission denied" error

Use correct permissions for application directories. For PHP projects set permissions via execute the `sudo chown -R www-data:www-data /home/docker-kit/php/` command. Or run the [docker-compose exec](https://docs.docker.com/compose/reference/exec/) command with the `--user` option.
