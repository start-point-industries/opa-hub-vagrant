#!/bin/bash

# VARIABLES
OPA_INSTALL="OPA_18A_v12.2.10.27.0.zip"

# INSTALL TOMCAT
sudo apt-get update
sudo apt-get -y install tomcat7

# INSTALL MYSQL SERVER
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get -y install mysql-server

# INSTALL MYSQL CONNECTOR
sudo apt-get -y install libmysql-java
sudo ln -s /usr/share/java/mysql.jar /usr/share/tomcat7/lib/mysql.jar
sudo service tomcat7 restart

# INSTALL OPA DATABASE
sudo apt-get -y install unzip
sudo unzip /vagrant/installers/$OPA_INSTALL -d /tmp
cd /tmp/opa
sudo chown -R vagrant:vagrant .
sudo find . -name "*.sh" -exec chmod +x {} \;
cd /tmp/opa/bin
source setEnv.sh
java -cp "$INSTALL_CP" com.oracle.determinations.hub.exec.HubExecCmdLineCustomer install_database -name=hub -createdb -dbconn=localhost:3306 -dbuser=root -dbpass=password -doresetpassword -resetpass=password -no-encryption-key=true

# INSTALL OPA HUB WARs
cd /tmp/opa/templates
unzip opa.ear -d opa
sudo apt-get -y install zip
cd opa
sed -i -- 's/opacloud-{0}-{1}.log/\/tmp\/ods.log/g' determinations-server/WEB-INF/classes/log4j.xml
sed -i -- 's/opacloud-{0}-{1}.log/\/tmp\/owd.log/g' web-determinations/WEB-INF/classes/log4j.xml
sed -i -- 's/opacloud-{0}-{1}.log/\/tmp\/hub.log/g' opa-hub/WEB-INF/classes/log4j.xml
cp -R lib determinations-server/WEB-INF
cp -R lib web-determinations/WEB-INF
cp -R lib opa-hub/WEB-INF

cd /tmp/opa/templates/opa/determinations-server
sudo cp /vagrant/resources/context.xml META-INF
sudo zip -r determinations-server.war *
sudo cp determinations-server.war /var/lib/tomcat7/webapps

cd /tmp/opa/templates/opa/web-determinations
sudo cp /vagrant/resources/context.xml META-INF
sudo zip -r web-determinations.war *
sudo cp web-determinations.war /var/lib/tomcat7/webapps

cd /tmp/opa/templates/opa/opa-hub
sudo cp /vagrant/resources/context.xml META-INF
sudo zip -r opa-hub.war *
sudo cp opa-hub.war /var/lib/tomcat7/webapps
