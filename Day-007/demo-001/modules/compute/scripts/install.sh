#!/usr/bin/env bash
sudo apt-get update -y
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo systemctl restart apache2
echo "<h1>Hello world!</h1></br><p>This site is deployed using terraform provisioners.</p>" | sudo tee /var/www/html/index.html