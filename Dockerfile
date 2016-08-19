FROM alpine

MAINTAINER Chen Augus <tianhao.chen@gmail.com>

RUN apk update 

# Install Lighttpd, and PHP
# change lighttpd configuraion. enable the mod_fastcgi.conf
RUN apk add lighttpd php5-common php5-iconv php5-json php5-gd php5-curl php5-xml php5-pgsql php5-imap php5-cgi fcgi 
RUN apk add php5-pdo php5-pdo_pgsql php5-soap php5-xmlrpc php5-posix php5-mcrypt php5-gettext php5-ldap php5-ctype php5-dom && sed -i 's/#   include "mod_fastcgi.conf"/   include "mod_fastcgi.conf"/g' /etc/lighttpd/lighttpd.conf

# Install Zabbix
RUN apk add zabbix zabbix-mysql zabbix-webif zabbix-setup && rm /var/www/localhost/htdocs -R && ln -s /usr/share/webapps/zabbix /var/www/localhost/htdocs
# also, we need import three sql into mysql.
# scripts will added in next version.

# change php configuration
RUN sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/php.ini && sed -i 's/expose_php = On/expose_php = Off/g' /etc/php5/php.ini && sed -i 's/date.timezone = UTC/date.timezone = PRC/g' /etc/php5/php.ini && sed -i 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php5/php.ini && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 16M/g' /etc/php5/php.ini && sed -i 's/memory_limit = 128M／memory_limit = 256M/g' /etc/php5/php.ini && sed -i 's/max_input_time = 60/max_input_time = 600/g' /etc/php5/php.ini

# change zabbix server configuration. 
# the parameters are fixed, need replced by environment vars in next version.
RUN sed -i '/DBHost=/a\DBHost=mysql' /etc/zabbix/zabbix_server.conf && sed -i '/DBPassword=/a\DBPassword=zabbix' /etc/zabbix/zabbix_server.conf && sed -i '/FpingLocation=/a\FpingLocation=/usr/sbin/fping' /etc/zabbix/zabbix_server.conf

# Install Zabbix Agent
RUN apk add zabbix-agent

# monitor using SNMP
RUN apk add net-snmp net-snmp-tools

