#!/bin/bash
sudo echo "export DB_USER=${db_username}" >> /etc/environment
sudo echo "export DB_PASS=${db_password}" >> /etc/environment
sudo echo "export DB_URL=${db_url}" >> /etc/environment
sudo echo "export EMAIL_PASS=${email_password}" >> /etc/environment
