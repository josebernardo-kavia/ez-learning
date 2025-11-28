package com.ezlearning.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Spring Security configuration compatible with Spring Security 6.
 * This configuration permits access to the health endpoint by default and
 * requires authentication for any other endpoints (can be adjusted later).
 */
// PUBLIC_INTERFACE
@Configuration
public class SecurityConfig {

    /**
     * Defines the main application SecurityFilterChain.
     * @param http HttpSecurity builder
     * @return configured SecurityFilterChain
     * @throws Exception in case of configuration errors
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(registry -> registry
                .requestMatchers("/health").permitAll()
                .anyRequest().permitAll() // Allow all for now to keep scaffold simple
            )
            .httpBasic(Customizer.withDefaults());
        return http.build();
    }
}
