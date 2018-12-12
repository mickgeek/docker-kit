# Docker Kit

The humble kit with configuration files of Docker Compose for web development. Inside you can find the next configurations of virtual hosts:

#### Nginx
- Simple PHP web application
- WordPress
- Yii 2 (advanced application template)
- Yii 2 (basic application template)

#### Apache
- Yii 2 (advanced application template)

## Setup

For example, set the kit to Ubuntu 16.04 x64 (with 512 MB RAM). You should add the swap space and install Docker Compose.

1. Create and enable the swap file equal 2xRAM:
```bash
$ sudo fallocate -l 1G /swapfile
$ sudo chmod 600 /swapfile
$ sudo mkswap /swapfile
$ sudo swapon /swapfile
```
2. Make the swap file permanent by adding it to the `/etc/fstab` file:
```bash
$ echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```
3. Modify kernel setting:
```bash
$ sudo sysctl vm.swappiness=10
$ sudo sysctl vm.vfs_cache_pressure=50
$ sudo sysctl vm.overcommit_memory=1
$ sudo sysctl vm.overcommit_ratio=80
```
4. Set Docker memory limits:
```bash
$ echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/default/grub
$ sudo update-grub
```
5. Restart the system:
```bash
$ sudo shutdown -r now
```
6. Install Docker and Docker Compose (by default `docker-compose.yml` is configured for nginx, you can change it):
```bash
$ curl -sSL get.docker.com -o docker-setup.sh
$ sh docker-setup.sh
$ rm docker-setup.sh
$ curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ chmod +x /usr/local/bin/docker-compose
```
7. Clone the repository **into a directory with path `/srv/docker`**:
```bash
$ git clone https://github.com/mickgeek/docker-kit.git /srv/docker
```
8. Copy `.env.example` to `.env` and then edit the file according to needs:
```bash
$ cp /srv/docker/.env.example /srv/docker/.env
```
9. Add the service to system startup:
```bash
$ cp /srv/docker/docker-compose-app.service /etc/systemd/system/
$ sudo systemctl enable docker-compose-app
$ sudo systemctl start docker-compose-app
```
10. For correct work of web server set necessary permissions via execute the `sudo chown -R www-data:www-data /srv/www` command. Use this directory for your projects 🍾
