#!/bin/sh

docker run -d -p 3307:3306 --volumes-from mysql-data mysql
