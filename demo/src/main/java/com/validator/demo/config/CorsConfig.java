package com.validator.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // Mengizinkan CORS untuk semua endpoint
                .allowedOrigins("http://localhost:3000", "http://localhost:8081") // Asal yang diizinkan
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // Metode HTTP yang diizinkan
                .allowedHeaders("*") // Header yang diizinkan
                .allowCredentials(true) // Mengizinkan kredensial (seperti cookie, header otorisasi)
                .maxAge(3600); // Durasi caching untuk preflight request (dalam detik)
    }
}