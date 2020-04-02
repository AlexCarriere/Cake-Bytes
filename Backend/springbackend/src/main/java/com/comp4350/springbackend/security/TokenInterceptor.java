package com.comp4350.springbackend.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class TokenInterceptor extends HandlerInterceptorAdapter {

    private final TokenManager tokenManager;

    TokenInterceptor(TokenManager tokenManager) {
        this.tokenManager = tokenManager;
    }

    //this function intercepts all request, checks if the requests header is carrying a valid token
    //and blocks the request if illegal
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {
        boolean result = tokenManager.isTokenActive(request.getHeader("token"));
        if (!result) {
            PrintWriter writer = response.getWriter();
            response.setContentType("application/json; charset=utf-8");
            writer.print(new ObjectMapper().writeValueAsString(
                    ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login Please")));
            writer.flush();
            writer.close();
        }
        return result;
    }

}
