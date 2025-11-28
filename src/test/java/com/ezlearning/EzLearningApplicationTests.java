package com.ezlearning;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * PUBLIC_INTERFACE
 * Basic smoke test to ensure that the Spring context loads under Spring Boot 3.x / Java 22.
 */
@SpringBootTest
class EzLearningApplicationTests {

    /**
     * PUBLIC_INTERFACE
     * Verifies that the Spring application context loads successfully.
     */
    @Test
    void contextLoads() {
        // No-op: If the context fails to start, this test will fail.
    }
}
