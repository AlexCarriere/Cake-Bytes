package com.comp4350.springbackend.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class TokenWebMvcConfig implements WebMvcConfigurer {

    private final TokenManager tokenManager;

    public TokenWebMvcConfig(TokenManager tokenManager) {
        this.tokenManager = tokenManager;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new TokenInterceptor(tokenManager))
                .addPathPatterns("/order/*");
    }
}
