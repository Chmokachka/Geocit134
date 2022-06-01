#!/bin/bash
sudo apt update
sudo apt install ansible -y
git clone https://github.com/Chmokachka/Geocit134.git
sudo echo "export DB_USER=${db_username}" >> /etc/environment
sudo echo "export DB_PASS=${db_password}" >> /etc/environment
sudo echo "export DB_URL=${db_url}" >> /etc/environment
sudo echo "export EMAIL_PASS=${email_password}" >> /etc/environment
