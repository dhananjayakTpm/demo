FROM openjdk:8u171-jdk-alpine3.8
MAINTAINER Arun Johnson <arun.j@thinkpalm.com>
ADD target/*.jar demo.jar

ENTRYPOINT ["java", "-jar", "demo.jar"]
#CMD exec java -cp ./* org.testng.TestNG -testclass com.test.SampleProject
#RUN java -cp "" org.testng.TestNG -testclass com.test.SampleProject
#CMD exec java -jar RestAssuredServicesTestProject-0.0.1-SNAPSHOT.jar
EXPOSE 8081