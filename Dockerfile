# Pull base image 
From tomcat:8-jre8

# Maintainer 
MAINTAINER "SURIBABU4495@gmail.com" 
COPY /home/ansadmin/opt/webapp.war /usr/local/tomcat/webapps

