FROM centos:centos6
MAINTAINER David Tompkins <tompkins@adobe.com>

# Install EPEL
RUN rpm -Uvh --force http://mirrors.kernel.org/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm

# Install MySQL Community
RUN rpm -Uvh --force https://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm

# Update Current Image
RUN yum install -y libcom_err && yum update -y

# Install mysql from EPEL
RUN yum -y install --enablerepo=epel \
  mysql-community-server.x86_64 \
  mysql-community-client.x86_64

# Edit mysql config, bind to alll interfaces
#RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/my.cnf
RUN echo "bind-address=0.0.0.0" >> /etc/my.cnf && echo "port=3306" >> /etc/my.cnf

ADD ./startup.sh /startup.sh
RUN chmod 755 /startup.sh

# Remove preinstalled database, configure external persistence
RUN rm -rf /var/lib/mysql/*
VOLUME ["/var/lib/mysql"]

EXPOSE 3306

CMD ["/bin/echo", "before startup script"]

#CMD ["/bin/bash", "/startup.sh"]

#CMD ["/bin/echo", "after startup script"]

CMD ["/usr/bin/mysqld_safe"]