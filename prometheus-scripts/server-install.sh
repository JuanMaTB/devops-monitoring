#!/bin/bash
sudo cp prometheus.service /etc/systemd/system
cd /opt
wget https://github.com/prometheus/prometheus/releases/download/v2.37.0/prometheus-2.37.0.linux-amd64.tar.gz
tar -xvf prometheus-2.38.0.linux-amd64.tar.gz -C /opt/prometheus

sudo useradd prometheus
sudo chown -R prometheus:prometheus prometheus

sudo systemctl start prometheus
sudo systemctl enable prometheus
