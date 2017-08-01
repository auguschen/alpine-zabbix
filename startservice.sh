#!/bin/sh
su zabbix -s /bin/sh -p -c /usr/sbin/zabbix_server
/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf
