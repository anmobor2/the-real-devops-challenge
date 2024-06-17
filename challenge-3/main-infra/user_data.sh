#!/bin/bash
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "It works!" > /var/www/html/index.html