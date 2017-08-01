#!/bin/sh

if [ "$MAINLAND" = "Y" ]
then
    /tmp/mirrormainland.sh
fi

# update respo
# install lighttpd and php
apk update && \
    apk add lighttpd php5-common php5-iconv php5-json php5-gd php5-curl php5-xml php5-mysql php5-pgsql php5-mysqli php5-imap php5-cgi fcgi && \
    apk add php5-pdo php5-pdo_pgsql php5-pdo_mysql php5-soap php5-xmlrpc php5-posix php5-mcrypt php5-gettext php5-ldap php5-ctype php5-dom && \
    apk add php5-xmlreader php5-sockets php5-bcmath php5-sqlite3

# install Zabbix, lib for monitor using SNMP, Zabbix Agent, Zabbix-utils
    apk add zabbix zabbix-mysql zabbix-webif zabbix-setup zabbix-utils net-snmp net-snmp-tools zabbix-agent mysql-client

# change php configuration, change lighttpd configuraion. enable the mod_fastcgi.conf, change zabbix server configuration.
sed -i 's/#   include "mod_fastcgi.conf"/   include "mod_fastcgi.conf"/g' /etc/lighttpd/lighttpd.conf && \
    ln -s /usr/bin/php-cgi5 /usr/bin/php-cgi && \
    sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php5/php.ini && \
    sed -i 's/date.timezone = UTC/date.timezone = PRC/g' /etc/php5/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php5/php.ini && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 16M/g' /etc/php5/php.ini && \
    sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php5/php.ini && \
    sed -i 's/max_input_time = 60/max_input_time = 300/g' /etc/php5/php.ini && \
    sed -i '/;always_populate_raw_post_data = -1/a\always_populate_raw_post_data = -1' /etc/php5/php.ini

sed -i '/FpingLocation=/a\FpingLocation=/usr/sbin/fping' /etc/zabbix/zabbix_server.conf && \
    mkdir -p /run/lighttpd && \
    chown -R lighttpd /run/lighttpd && \
    rm /var/www/localhost/htdocs -R && \
    ln -s /usr/share/webapps/zabbix /var/www/localhost/htdocs && \
    chown -R lighttpd /usr/share/webapps/zabbix/conf && \
    addgroup zabbix readproc && \
    chown -R zabbix /var/log/zabbix && \
    chown -R zabbix /var/run/zabbix

