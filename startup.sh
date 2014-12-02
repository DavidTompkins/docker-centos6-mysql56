#!/bin/bash

LOG="/var/log/mysqld.log"
LOOP_LIMIT=4
DATADIR="/var/lib/mysql"
MYSQL_USER=mysql

echo "database initialization starting..."

if [ ! -d ${DATADIR}/mysql ]; then

  echo "creating databases..."

  /usr/bin/mysql_install_db --user=${MYSQL_USER}

  echo "starting mysql for configuration..."

  (cd /usr ; /usr/bin/mysqld_safe --user=${MYSQL_USER} --datadir=${DATADIR} --basedir=/usr) &

  for (( i=0 ; ; i++ )); do
    if [ ${i} -eq ${LOOP_LIMIT} ]; then
      echo "Time out. Error log is shown as below:"
      tail -n 100 ${LOG}
      exit 1
    fi
    echo "=> Waiting for confirmation of MySQL service startup, trying ${i}/${LOOP_LIMIT} ..."
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1 && break
  done

  echo "creating admin user..."

  echo "GRANT ALL PRIVILEGES ON *.* TO admin@'%' IDENTIFIED BY 'bluejay123' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql -u root -v

  echo "halting mysql for configuration..."

  /usr/bin/mysqladmin -uroot shutdown
 
else
  echo "using existing databases"
fi

echo "mysql starting..."

(cd /usr ; /usr/bin/mysqld_safe --user=${MYSQL_USER} --datadir=${DATADIR} --basedir=/usr)
tail -n 100 ${LOG}
