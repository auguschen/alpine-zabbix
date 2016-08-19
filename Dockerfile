FROM alpine

MAINTAINER Chen Augus <tianhao.chen@gmail.com>

RUN apk update 

# Install Lighttpd, and PHP
RUN apk add lighttpd php5-common php5-iconv php5-json php5-gd php5-curl php5-xml php5-pgsql php5-imap php5-cgi fcgi 
RUN apk add php5-pdo php5-pdo_pgsql php5-soap php5-xmlrpc php5-posix php5-mcrypt php5-gettext php5-ldap php5-ctype php5-dom 

# Install PostgreSQL
RUN apk add postgresql postgresql-client 

# Install Zabbix
RUN apk add zabbix zabbix-pgsql zabbix-webif zabbix-setup 

# Install Zabbix Agent
RUN apk add zabbix-agent

# monitor using SNMP
RUN apk add net-snmp net-snmp-tools

