#!/bin/bash

killall mysqld
mysql_install_db

echo "Starting mysql database"
/usr/bin/mysqld_safe&
sleep 10

echo "Creating database soapower..."
RET=1
while [[ RET -ne 0 ]]; do
	sleep 5
	mysql -uroot -e "CREATE DATABASE soapower CHARACTER SET utf8 COLLATE utf8_general_ci;"
	mysql -uroot -e "CREATE USER 'soapower' IDENTIFIED BY 'soapower';"
    mysql -uroot -e "GRANT ALL ON soapower.* TO 'soapower'@'%' IDENTIFIED BY 'soapower';"
    mysql -uroot -e "GRANT ALL ON soapower.* TO 'soapower'@'localhost' IDENTIFIED BY 'soapower';FLUSH PRIVILEGES;"		
	RET=$?
done

mysqladmin -uroot shutdown

echo "Creating database soapower done."