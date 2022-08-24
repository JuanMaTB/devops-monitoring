#!/bin/bash
sudo apt update
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-3+ubuntu$(lsb_release -rs)_all.deb
sudo dpkg -i zabbix-release_6.0-3+ubuntu$(lsb_release -rs)_all.deb
sudo apt update
sudo apt -y install zabbix-proxy-mysql zabbix-sql-scripts

sudo apt install software-properties-common -y

curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
sudo bash mariadb_repo_setup --mariadb-server-version=10.6

sudo apt update
sudo apt -y install mariadb-common mariadb-server-10.6 mariadb-client-10.6

sudo systemctl start mariadb
sudo systemctl enable mariadb
echo "MySQL setup:"
sudo mysql_secure_installation

read -p "MySQL password: " sql_pass
sudo mysql -uroot -p"$sql_pass" -e "create database zabbix_proxy character set utf8mb4 collate utf8mb4_bin;"
sudo mysql -uroot -p"$sql_pass" -e "grant all privileges on zabbix_proxy.* to zabbix@localhost identified by '$sql_pass';"

sudo cat /usr/share/doc/zabbix-sql-scripts/mysql/proxy.sql | mysql -uzabbix -p"$sql_pass" zabbix_proxy

sudo sed -i "s/# DBPassword=/DBPassword=$sql_pass/" /etc/zabbix/zabbix_proxy.conf
echo "ConfigFrequency=100" >> /etc/zabbix/zabbix_proxy.conf
read -p "Server IP:" server_ip
read -p "Hostname:" hostname
sudo sed -i "s/Server=127.0.0.1/Server=$sql_pass/" /etc/zabbix/zabbix_proxy.conf
sudo sed -i "s/Hostname=Zabbix proxy/Hostname=$hostname/" /etc/zabbix/zabbix_proxy.conf

sudo systemctl restart zabbix-proxy
sudo systemctl enable zabbix-proxy