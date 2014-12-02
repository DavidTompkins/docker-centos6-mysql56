#!/bin/sh

docker run -d -p 3306:3306 --volumes-from mysql-data mysql
