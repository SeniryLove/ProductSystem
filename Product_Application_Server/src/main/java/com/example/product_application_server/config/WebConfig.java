package com.example.product_application_server.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")                // 允許所有 API 路徑
                .allowedOrigins("http://localhost:4173", "http://localhost:5173") // 允許前端
                .allowedMethods("GET","POST","PUT","DELETE","OPTIONS") // 允許方法
                .allowCredentials(true);          // 如果需要 cookie
    }
}