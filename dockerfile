FROM tomcat:9.0.85-jdk17

WORKDIR /user/local/tomcat/webapps/

COPY target/expense-tracker-0.0.1-SNAPSHOT.war expense-tracker.war

EXPOSE 8081

CMD ["catalina.sh","run"]