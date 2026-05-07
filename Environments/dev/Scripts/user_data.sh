#!/usr/bin/env bash
sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
echo "Hello from root module" | sudo tee /var/www/html/index.html
sudo systemctl enable nginx
sudo systemctl restart nginx