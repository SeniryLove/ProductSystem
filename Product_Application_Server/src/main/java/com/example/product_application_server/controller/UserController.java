package com.example.product_application_server.controller;

import com.example.product_application_server.dto.ApiResponseDTO;
import com.example.product_application_server.dto.LikeListDTO;
import com.example.product_application_server.dto.UserDTO;
import com.example.product_application_server.dto.UserRequestDTO;
import com.example.product_application_server.service.AuthService;
import com.example.product_application_server.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final AuthService authService;

    // 使用者註冊
    @PostMapping
    public ResponseEntity<ApiResponseDTO<Void>> createUser(@RequestBody UserRequestDTO request) {
        try{
            userService.createUser(request);
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "創建成功", null)
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

    // 取得使用者資料
    @GetMapping("/{userId}")
    public ResponseEntity<ApiResponseDTO<UserDTO>> getUser(@RequestHeader("Authorization") String authHeader, @PathVariable Long userId) {

        try{
            if (!authService.validateToken(authHeader, userId)){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                        new ApiResponseDTO<>(401, "驗證失敗請重新登入", null)
                );
            }
            UserDTO userDTO = userService.getUser(userId);
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "讀取成功", userDTO)
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

    // 更新使用者資料
    @PutMapping("/{userId}")
    public ResponseEntity<ApiResponseDTO<Void>> updateUser(@RequestHeader("Authorization") String authHeader, @PathVariable Long userId, @RequestBody UserRequestDTO request) {
        try{
            if (!authService.validateToken(authHeader, userId)){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                        new ApiResponseDTO<>(401, "驗證失敗請重新登入", null)
                );
            }
            userService.updateUser(userId, request);
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "修改成功", null)
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