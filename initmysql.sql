create user zabbix@'%' identified by 'zabbix';
create user zabbix@localhost identified by 'zabbix';

create database zabbix char set utf8;

grant all on zabbix.* to zabbix@'%';
grant all on zabbix.* to zabbix@localhost;
