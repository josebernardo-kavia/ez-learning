package com.ezlearning.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Minimal health endpoint to confirm application startup.
 */
// PUBLIC_INTERFACE
@RestController
public class HealthController {

    /**
     * Returns a simple status message.
     * @return status string
     */
    @GetMapping("/health")
    public String health() {
        return "OK";
    }
}
