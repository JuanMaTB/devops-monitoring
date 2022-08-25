#!/bin/bash
sudo apt update
sudo apt-get install zabbix-agent
sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent