#!/bin/bash
sudo apt update
sudo apt-get install zabbix-agent

read -p "Server IP:" server_ip
sudo sed -i "s/Server=127.0.0.1/Server=$server_ip/" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/ServerActive=127.0.0.1/ServerActive=$server_ip/" /etc/zabbix/zabbix_agentd.conf

sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent
sudo systemctl restart zabbix-agent