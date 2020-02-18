
#! /usr/bin/bash

sudo apt-get install nginx
sudo apt-get install git
sudo systemctl start nginx
cd /var/www/
git clone https://www.github.com/sauravjaiswalsj.github.io
