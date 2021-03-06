FROM dtompkins/docker-centos6-base:latest
MAINTAINER David Tompkins <tompkins@adobe.com>

# Install EPEL repo
RUN rpm -Uvh --force http://mirrors.kernel.org/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm

# Install MySQL Community repo
RUN rpm -Uvh --force https://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm

# Install mysql from EPEL
RUN yum -y install --enablerepo=epel \
  mysql-community-server.x86_64 \
  mysql-community-client.x86_64

# Edit mysql config, bind to alll interfaces
RUN echo "[mysqld]" >> /etc/my.cnf && echo "bind-address=0.0.0.0" >> /etc/my.cnf && echo "port=3306" >> /etc/my.cnf && echo "skip_name_resolve" >> /etc/my.cnf
RUN sed -i -e 's/^socket\s*=\(.*\)$/#socket=\1/' /etc/my.cnf

ADD ./startup.sh /startup.sh
RUN chmod 755 /startup.sh

EXPOSE 3306
CMD ["/startup.sh"]
