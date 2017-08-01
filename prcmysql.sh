#!/bin/sh

if [ "$DBHOST" != "" ]
then
    sed -i ''/DBHost=/a\DBHost=$DBHOST'' /etc/zabbix/zabbix_server.conf
fi

if [ "$DBPORT" != "" ]
then
    sed -i ''/DBPort=/a\DBPort=$DBPORT'' /etc/zabbix/zabbix_server.conf
fi

if [ "$DBPASSWORD" != "" ]
then
    sed -i ''/DBPassword=/a\DBPassword=$DBPASSWORD'' /etc/zabbix/zabbix_server.conf
fi

cat /tmp/initmysql.sql | mysql -h $DBHOST -u root -p $ROOTPASSWORD
cat /usr/share/zabbix/database/mysql/schema.sql | mysql -h $DBHOST -u zabbix -p $DBPASSWORD -D zabbix
cat /usr/share/zabbix/database/mysql/images.sql | mysql -h $DBHOST -u zabbix -p $DBPASSWORD -D zabbix
cat /usr/share/zabbix/database/mysql/data.sql | mysql -h $DBHOST -u zabbix -p $DBPASSWORD -D zabbix
