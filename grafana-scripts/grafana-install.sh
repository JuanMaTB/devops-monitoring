#!/bin/bash
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_9.1.1_amd64.deb
sudo dpkg -i grafana_9.1.1_amd64.deb
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

#The name and the password in the frontend is admin.