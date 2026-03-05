package com.example.product_application_server.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    // BCryptPasswordEncoder Bean
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())           // 禁用 CSRF
                .authorizeHttpRequests(auth -> auth
                        .anyRequest().permitAll()          // 所有請求都允許
                )
                .formLogin(form -> form.disable())      // 禁用 Spring Security 的預設登入頁面
                .httpBasic(httpBasic -> httpBasic.disable()); // 禁用 HTTP Basic Auth

        return http.build();
    }
}