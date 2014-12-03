#!/bin/sh

docker run -d --name centos6-mysql56 -p 3306:3306 --volumes-from centos6-data-volume-container centos6-mysql56
