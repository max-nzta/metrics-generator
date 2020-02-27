FROM maven:3.6-jdk-12-alpine as builder
WORKDIR /app
COPY . /app
RUN mvn package


FROM openjdk:12-jdk
WORKDIR /app
COPY --from=builder /app/target/java-prom-example-1.0-jar-with-dependencies.jar /app/app.jar
EXPOSE 8080 80
CMD ["java", "-cp", "/app/app.jar" , "Main"]