#!/bin/bash
yum update -y
mkfs -t ext4 /dev/sdb
mount /dev/sdb /var/log/
yum install httpd -y
service httpd start
chkconfig httpd on
echo "Hello World!" > /var/www/html/index.html