#!/bin/sh
cat /tmp/initmysql.sql | mysql -h $DBHOST -u root -p $ROOTPASSWORD
cat /usr/share/zabbix/database/mysql/schema.sql | mysql -h $DBHOST -u zabbix -p $DBPASSWORD -D zabbix
cat /usr/share/zabbix/database/mysql/images.sql | mysql -h $DBHOST -u zabbix -p $DBPASSWORD -D zabbix
cat /usr/share/zabbix/database/mysql/data.sql | mysql -h $DBHOST -u zabbix -p $DBPASSWORD -D zabbix
