#!/bin/bash
sudo apt update
sudo apt install -y apache2

sudo apt install -y mariadb-server mariadb-client
echo "MySQL setup"
sudo mysql_secure_installation

wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-3+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.0-3+ubuntu22.04_all.deb
sudo apt update

sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
read -p "MySQL password: " sql_pass
sudo mysql -uroot -p"$sql_pass" -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
sudo mysql -uroot -p"$sql_pass" -e "create user zabbix@localhost identified by '$sql_pass';"
sudo mysql -uroot -p"$sql_pass" -e "grant all privileges on zabbix.* to zabbix@localhost;"

sudo zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -p"$sql_pass" zabbix

sudo sed -i "s/# DBPassword=/DBPassword=$sql_pass/" /etc/zabbix/zabbix_server.conf

sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2