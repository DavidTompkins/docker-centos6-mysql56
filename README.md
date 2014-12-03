# docker-centos6-mysql56

Docker container for MySQL Community 5.6.x with updates running on docker-centos6-base, using docker data volume persistence for the MySQL data directory.

## Dependencies

Based on docker-centos6-base: [![https://github.com/DavidTompkins/docker-centos6-base](https://github.com/DavidTompkins/docker-centos6-base)](https://github.com/DavidTompkins/docker-centos6-base)

Expects to find a running data volume container named "centos6-data-volume-container" and sharing /var/lib/data. See docker-centos6-data-volume-container: [![https://github.com/DavidTompkins/docker-centos6-data-volume-container](https://github.com/DavidTompkins/docker-centos6-data-volume-container)](https://github.com/DavidTompkins/docker-centos6-data-volume-container)

## Build

Change the MySQL admin account password created in startup.sh to something else, then run "build.sh". Image is tagged as "centos6-mysql56".

## Deploy

Ensure that the data volume container is running (see Dependencies), then start the mysql container by running "start.sh".

MySQL will be exposed on port 3306 and it will use the data volume on /var/lib/mysql for persistence.

Please read the Docker docs for data volumes to understand how this persistence works and how you would configure backups:

[![https://docs.docker.com/userguide/dockervolumes/](https://docs.docker.com/userguide/dockervolumes/)](https://docs.docker.com/userguide/dockervolumes/)

## Issues

Pay attention to VirtualBox TCP port forwarding if you are running this container on a Mac. Otherwise, port forwarding will be broken for no apparent reason.

See this issue for more information: [![https://github.com/docker/docker/issues/4007](https://github.com/docker/docker/issues/4007)](https://github.com/docker/docker/issues/4007)

The script "mysql_client.sh" is an example of how to connect to MySQL after port mapping to localhost:3307 from VirtualBox:3306 with:
```
VBoxManage controlvm boot2docker-vm natpf1 "mysql,tcp,127.0.0.1,3307,,3306"
```

## License

Licensed under the Apache Software License 2.0. See [![LICENSE](LICENSE)](LICENSE) file.
