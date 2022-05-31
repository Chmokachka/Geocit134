#!/bin/bash
sudo apt update -y
sudo apt install openjdk-11-jdk -y
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.79/bin/apache-tomcat-8.5.79.tar.gz
sudo tar xzvf apache-tomcat-8.5.79.tar.gz
sudo mkdir /opt/tomcat/
sudo mv apache-tomcat-8.5.79/* /opt/tomcat/
sudo chown -R www-data:www-data /opt/tomcat/
sudo chmod -R 755 /opt/tomcat/
sudo sed -i '56 i <!-- user manager can access only manager section -->\n<role rolename="manager-gui" />\n<user username="manager" password="manager" roles="manager-gui" />\n\n<!-- user admin can access manager and admin section both -->\n<role rolename="admin-gui" />\n<user username="admin" password="admin" roles="manager-gui,admin-gui" />' /opt/tomcat/conf/tomcat-users.xml \
&& sudo sed -i '21 i <!--' /opt/tomcat/webapps/manager/META-INF/context.xml \
&& sudo sed -i '24 i -->' /opt/tomcat/webapps/manager/META-INF/context.xml \
&& sudo sed -i '21 i <!--' /opt/tomcat/webapps/host-manager/META-INF/context.xml \
&& sudo sed -i '24 i -->' /opt/tomcat/webapps/host-manager/META-INF/context.xml
touch tomcat.service
echo -e "[Unit]\nDescription=Tomcat\nAfter=network.target\n\n[Service]\nType=forking\n\nUser=root\nGroup=root\n\nEnvironment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"\nEnvironment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"\nEnvironment="CATALINA_BASE=/opt/tomcat"\nEnvironment="CATALINA_HOME=/opt/tomcat"\nEnvironment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"\nEnvironment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"\n\nExecStart=/opt/tomcat/bin/startup.sh\nExecStop=/opt/tomcat/bin/shutdown.sh\n\n[Install]\nWantedBy=multi-user.target" >> tomcat.service
sudo mv tomcat.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
git clone https://github.com/Chmokachka/Geocit134.git
sudo apt install maven -y
sudo sed -i 's/postusername/${db_username}/g' /Geocit134/src/main/resources/application.properties
sudo sed -i 's/postpassword/${db_password}/g' /Geocit134/src/main/resources/application.properties
sudo sed -i 's/localhost:5432/${db_url}:5432/g' /Geocit134/src/main/resources/application.properties
sudo sed -i 's/passwordemail/${email_password}/g' /Geocit134/src/main/resources/application.properties
(cd Geocit134 && sudo mvn clean install && sudo mv target/citizen.war /opt/tomcat/webapps/ && sudo /opt/tomcat/bin/startup.sh)
