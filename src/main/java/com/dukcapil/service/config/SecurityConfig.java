package com.dukcapil.service.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;
import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private static final Logger logger = LoggerFactory.getLogger(SecurityConfig.class);

    @Value("${app.cors.allowed-origins:http://localhost:8080}")
    private List<String> allowedOrigins;

    @PostConstruct
    public void init() {
        logger.info("Verifikator CORS Allowed Origins configured: {}", allowedOrigins);
    }
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .cors(cors -> cors.configurationSource(corsConfigurationSource()))
            .csrf(csrf -> csrf.disable())
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(auth -> auth
                // Public endpoints untuk health check dan docs
                .requestMatchers("/api/dukcapil/health").permitAll()
                .requestMatchers("/api/dukcapil/ping").permitAll()
                .requestMatchers("/api/dukcapil/docs").permitAll()
                .requestMatchers("/error").permitAll()
                
                // Allow OPTIONS untuk CORS preflight
                .requestMatchers("OPTIONS", "/**").permitAll()
                
                // Semua endpoint dukcapil yang spesifik diizinkan
                // Ini akan mencakup /api/dukcapil/verify-nik jika tidak ada API Key
                .requestMatchers("/api/dukcapil/verify-nik").permitAll() // Tambahkan ini secara eksplisit
                .requestMatchers("/api/dukcapil/check-nik").permitAll() // Jika ada
                // ... tambahkan endpoint dukcapil lain yang perlu di-permitAll()
                
                // Jika Anda ingin semua endpoint di bawah /api/dukcapil di-permitAll()
                // Anda bisa gunakan ini, tapi pastikan tidak ada API Key filter yang aktif
                // .requestMatchers("/api/dukcapil/**").permitAll()
                
                // Protected by default - semua permintaan lain memerlukan otentikasi
                .anyRequest().authenticated()
            )
            .headers(headers -> headers
                .httpStrictTransportSecurity(hstsConfig -> hstsConfig
                    .maxAgeInSeconds(31536000)
                    .includeSubDomains(true)
                )
                .addHeaderWriter((request, response) -> {
                    response.setHeader("X-Frame-Options", "DENY");
                    response.setHeader("X-Content-Type-Options", "nosniff");
                    response.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
                    response.setHeader("X-XSS-Protection", "1; mode=block");
                    response.setHeader("X-Service", "Dukcapil-KTP-Service");
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    response.setHeader("Pragma", "no-cache");
                    response.setHeader("Expires", "0");
                })
            );
        
        return http.build();
    }
    
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        
        configuration.setAllowedOriginPatterns(allowedOrigins);
        
        configuration.setAllowedMethods(Arrays.asList(
            "GET", "POST", "PUT", "DELETE", "OPTIONS", "HEAD", "PATCH"
        ));
        
        configuration.setAllowedHeaders(Arrays.asList(
            "Authorization", 
            "Content-Type", 
            "X-Requested-With",
            "Accept",
            "Origin",
            "X-API-Key",
            "Access-Control-Request-Method",
            "Access-Control-Request-Headers"
        ));
        
        configuration.setExposedHeaders(Arrays.asList(
            "Access-Control-Allow-Origin",
            "Access-Control-Allow-Credentials",
            "X-Service",
            "X-Total-Count"
        ));
        
        configuration.setAllowCredentials(true);
        configuration.setMaxAge(3600L);
        
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
