#stage 1 - build
FROM maven:3.9.9-eclipse-temurin-21 AS build

COPY . /app

WORKDIR /app

RUN mvn clean package -DskipTests
#stage 2 - run
FROM eclipse-temurin:21-jre-alpine AS runtime

#1st path from previous image 2nd path destination-path

COPY --from=build /app/target/dockermastery-0.0.1-SNAPSHOT.jar /app/todoapp.jar

WORKDIR /app

EXPOSE 8080

ENTRYPOINT ["java","-jar","todoapp.jar"]
