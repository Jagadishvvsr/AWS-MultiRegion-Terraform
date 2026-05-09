#!/usr/bin/env bash
sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "Hello from the dev root" | sudo tee /var/www/html/index.html
sudo systemctl restart nginx