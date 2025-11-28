package com.ezlearning;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * PUBLIC_INTERFACE
 * EzLearningApplication is the entry point of the Spring Boot application.
 * It enables auto-configuration and component scanning.
 */
@SpringBootApplication
public class EzLearningApplication {

    /**
     * PUBLIC_INTERFACE
     * Starts the Spring Boot application.
     *
     * @param args application arguments
     */
    public static void main(String[] args) {
        SpringApplication.run(EzLearningApplication.class, args);
    }
}
