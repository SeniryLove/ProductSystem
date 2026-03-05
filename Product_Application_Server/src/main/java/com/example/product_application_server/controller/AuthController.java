package com.example.product_application_server.controller;


import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import com.example.product_application_server.dto.ApiResponseDTO;
import com.example.product_application_server.dto.LoginRequestDTO;
import com.example.product_application_server.dto.LoginResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.product_application_server.service.AuthService;
import com.example.product_application_server.util.JwtUtil;
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/login")
    public ResponseEntity<ApiResponseDTO<LoginResponseDTO>> login(@RequestBody LoginRequestDTO request) {

        try{
            LoginResponseDTO response = authService.login(request);
            if (response == null){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                        new ApiResponseDTO<>(401, "登入過期，請重新登入", null)
                );
            }
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "創建成功", response)
            );
        }catch (IllegalArgumentException ex){
            System.out.println(ex.getMessage());
            return ResponseEntity.status(HttpStatus.CONFLICT).body(
                    new ApiResponseDTO<>(409, ex.getMessage(), null)
            );
        }catch (RuntimeException ex){
            System.out.println(ex.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                    new ApiResponseDTO<>(500, ex.getMessage(), null)
            );
        }
    }
}

