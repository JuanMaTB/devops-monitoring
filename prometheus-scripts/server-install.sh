#!/bin/bash
sudo cp prometheus.service /etc/systemd/system
sudo wget -P /opt https://github.com/prometheus/prometheus/releases/download/v2.37.0/prometheus-2.37.0.linux-amd64.tar.gz
sudo tar -xvf /opt/prometheus-2.37.0.linux-amd64.tar.gz -C /opt
sudo mv /opt/prometheus-2.37.0.linux-amd64 /opt/prometheus

sudo useradd prometheus
sudo chown -R prometheus:prometheus /opt/prometheus

sudo systemctl start prometheus
sudo systemctl enable prometheus
