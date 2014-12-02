#!/bin/bash

echo "database initialization"

if [ ! -f /var/lib/mysql/ibdata1 ]; then

  echo "creating databases..."

  /usr/bin/mysql_install_db

  /usr/bin/mysqld_safe &
  /usr/bin/mysqladmin --silent --wait=30 ping || exit 1

  echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'bluejay123' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

  /usr/bin/mysqladmin -uroot shutdown
fi
