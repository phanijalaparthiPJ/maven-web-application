#getting centos from dockerhub
FROM centos
#who create code
MAINTAINER phani <phanij1912@gmail.com>
RUN mkdir /opt/tomcat
#createdirectory
WORKDIR /opt/tomcat
#Install required pacages
RUN yum install git   -y && yum install maven -y && yum install java -y
#Clone the application from github
RUN git clone https://github.com/phanijalaparthiPJ/maven-web-application.git
#Download tomcat software and untar
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.54/bin/apache-tomcat-9.0.54.tar.gz .
RUN tar -xvzf apache-tomcat-9.0.54.tar.gz
RUN ls
#Rename the tomcat
RUN mv apache-tomcat-9.0.54 tomcat18
RUN ls
RUN rm -rf apache-tomcat-9.0.54.tar.gz
RUN ls
RUN cd  /opt/tomcat/tomcat18
RUN ls
#directory of mavenapplication
WORKDIR /opt/tomcat/maven-web-application
#create package
RUN mvn clean package
RUN  ls
WORKDIR /opt/tomcat/maven-web-application/target
RUN ls
#Copy package
#COPY target/maven-web-application.war /opt/tomcat/tomcat18/webapps/
#COPY maven-web-application.war/  /opt/tomcat/tomcat18/webapps/maven-web-application.war
RUN cp maven-web-application.war /opt/tomcat/tomcat18/webapps/maven-web-application.war
#userandpw add:
 RUN sed -i '/<\/tomcat-users>/ i\<user username="admin" password="password" roles="admin-gui,manager-gui"/>' /opt/tomcat/tomcat18/conf/tomcat-users.xml
#declare the port
EXPOSE 8080
#tomcatstartlocation
WORKDIR /opt/tomcat/tomcat18/bin
#execute command
CMD ["sh","catalina.sh","run"]
