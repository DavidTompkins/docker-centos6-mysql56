#!/bin/bash

LOG="/var/log/mysqld.log"
LOOP_LIMIT=4
DATADIR="/var/lib/mysql"

echo "database initialization starting..."

/bin/rm -rf ${DATADIR}/*

if [ ! -d ${DATADIR}/mysql ]; then

  echo "creating databases..."

  /usr/bin/mysql_install_db
  chown -R mysql.mysql ${DATADIR}

  echo "starting mysql for configuration..."

  cat /etc/my.cnf

  (cd /usr ; /usr/bin/mysqld_safe --user=mysql --datadir=${DATADIR} --basedir=/usr) &

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

  echo "GRANT ALL PRIVILEGES ON *.* TO admin@localhost IDENTIFIED BY 'bluejay123' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql -u root

  /usr/bin/mysqladmin -uroot shutdown
 
else
  echo "using existing databases"
fi

echo "database initialization complete"

(cd /usr ; /usr/bin/mysqld_safe --user=mysql --datadir=${DATADIR} --basedir=/usr)
tail -n 100 ${LOG}
