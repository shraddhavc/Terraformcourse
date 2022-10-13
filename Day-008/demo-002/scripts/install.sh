#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get install apache2 -y
sudo systemctl enable apache2
sudo systemctl restart apache2
echo "<h1>Hello World!</h1><p>This site is deployed via terraform provisioners</p>" | sudo tee /var/www/html/index.html
