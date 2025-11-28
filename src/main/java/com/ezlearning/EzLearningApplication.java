package com.ezlearning;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Spring Boot entrypoint for Ez Learning application.
 *
 * Starts the web application. By default, server.port is read from configuration.
 * Run with: mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=3001
 */
// PUBLIC_INTERFACE
@SpringBootApplication
public class EzLearningApplication {

    /**
     * Application main method.
     * @param args standard arguments
     */
    public static void main(String[] args) {
        SpringApplication.run(EzLearningApplication.class, args);
    }
}
