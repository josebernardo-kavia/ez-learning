package com.ezlearning.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

/**
 * PUBLIC_INTERFACE
 * SecurityConfig defines the Spring Security 6 filter chain for the application.
 *
 * It:
 * - Permits access to common static resources and the H2 console in dev.
 * - Disables CSRF protection for the H2 console to allow usage in dev.
 * - Disables frame options so the H2 console can render.
 * - Sets a permissive default (permitAll) so the application can start and pages can be browsed
 *   without a login screen during migration. Adjust as needed for production.
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    /**
     * PUBLIC_INTERFACE
     * Defines the application's SecurityFilterChain for Spring Security 6 / Boot 3.
     *
     * @param http Spring Security HttpSecurity builder
     * @return configured SecurityFilterChain
     * @throws Exception if configuration fails
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // Allow access to the H2 console and static resources without authentication
        http.authorizeHttpRequests(auth -> auth
                .requestMatchers(
                        "/",
                        "/index",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/webjars/**",
                        "/h2-console/**"
                ).permitAll()
                .anyRequest().permitAll() // Relaxed for migration; tighten for production
        );

        // Disable CSRF for H2 console so it works in dev profile
        http.csrf(csrf -> csrf.ignoringRequestMatchers(new AntPathRequestMatcher("/h2-console/**")));

        // Allow frames for H2 console
        http.headers(headers -> headers.frameOptions(frame -> frame.disable()));

        // Optional: keep default login/basics disabled in permissive mode
        // http.formLogin(Customizer.withDefaults());
        // http.httpBasic(Customizer.withDefaults());

        return http.build();
    }
}
