# docker-mysql-centos6 

Docker container for MySQL Community 5.6.22 running on CentOS 6 minimal, using docker data volume persistence.

## Dependencies

Based on the official CentOS 6 container: [![https://registry.hub.docker.com/\_/centos/](https://registry.hub.docker.com/\_/centos/)](https://registry.hub.docker.com/\_/centos/)

## Build

Change the MySQL admin account password created in build.sh to something else, then run "build.sh", or:
```
docker build -t mysql .
```

## Deploy

Start the data volume container only once by running "create-data-volume.sh", or:
```
docker run -d -v /var/lib/mysql --name mysql-data mysql echo "Data-only container for mysql"
```

Then, start the mysql container by running "run-server.sh", or:
```
docker run -d -p 3306:3306 --volumes-from mysql-data mysql
```

MySQL will be exposed on port 3306 and it will use the data volume on /var/lib/mysql for persistence.

Please read the Docker docs for data volumes to understand how this persistence works and how you would configure backups:

[![https://docs.docker.com/userguide/dockervolumes/](https://docs.docker.com/userguide/dockervolumes/)](https://docs.docker.com/userguide/dockervolumes/)

## Issues

Pay attention to VirtualBox TCP port forwarding if you are running this container on a Mac. Otherwise, port forwarding will be broken for no apparent reason.

See this issue for more information: [![https://github.com/docker/docker/issues/4007](https://github.com/docker/docker/issues/4007)](https://github.com/docker/docker/issues/4007)

## License

Licensed under the Apache Software License 2.0. See [![LICENSE](LICENSE)](LICENSE) file.
