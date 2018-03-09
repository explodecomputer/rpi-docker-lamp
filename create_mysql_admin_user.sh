#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

# PASS=${MYSQL_PASS:-$(pwgen -s 12 1)}
PASS="Odeadfsws123qwe"
_word=$( [ ${MYSQL_PASS} ] && echo "preset" || echo "random" )
echo "=> Creating MySQL admin user with ${_word} password"

mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"

echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this MySQL Server using:"
echo ""
echo "    mysql -uadmin -p$PASS -h<host> -P<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MySQL user 'root' has no password but only allows local connections"
echo "========================================================================"


wget -O explodecomputer.sql "https://www.dropbox.com/s/lknzahljfqo2q44/explodecomputer.sql?dl=1"


echo "DROP DATABASE IF EXISTS explodecomputer; CREATE DATABASE explodecomputer; GRANT ALL PRIVILEGES ON explodecomputer.* To 'gib'@'localhost' IDENTIFIED BY 'Odeadfsws123qwe';" | mysql -u root -p
mysql -u root -p explodecomputer < explodecomputer.sql

mysqladmin -uroot shutdown
