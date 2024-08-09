# Use an openjdk base image
FROM openjdk:8-jre-alpine

# Set the working directory
WORKDIR /wiremock

# Copy the WireMock standalone JAR and configuration files
COPY wiremock-jre8-standalone-2.31.0.jar .
COPY mappings mappings
COPY __files __files

# Expose the default WireMock port
EXPOSE 8080

# Command to run WireMock standalone with response templating enabled
CMD ["java", "-jar", "wiremock-jre8-standalone-2.31.0.jar", "--global-response-templating"]
