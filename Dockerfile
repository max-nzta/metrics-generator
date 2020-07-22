FROM maven:3.6-jdk-12-alpine as builder
WORKDIR /app
COPY ./pom.xml /app
RUN mvn package
COPY . /app
RUN mvn package
RUN ls -al target

FROM openjdk:13-alpine
ENV ARTIFACT_NAME=java-prom-example-1.0-jar-with-dependencies.jar
ENV APP_HOME=/app

WORKDIR $APP_HOME
COPY --from=builder $APP_HOME/target/$ARTIFACT_NAME .

EXPOSE 8890 8891
CMD java -jar $ARTIFACT_NAME ${PORT}