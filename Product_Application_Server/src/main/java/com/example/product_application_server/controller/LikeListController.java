package com.example.product_application_server.controller;

import com.example.product_application_server.dto.LikeListDTO;
import com.example.product_application_server.dto.LikeListRequestDTO;
import com.example.product_application_server.dto.LikeListUpdateDTO;
import com.example.product_application_server.dto.ApiResponseDTO;
import com.example.product_application_server.service.AuthService;
import com.example.product_application_server.service.LikeListService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/users/{userId}/favorites")
@RequiredArgsConstructor
public class LikeListController {

    private final LikeListService likeListService;
    private final AuthService authService;

    @PostMapping
    public ResponseEntity<ApiResponseDTO<Void>> createLikeList(@RequestHeader("Authorization") String authHeader,
                                                 @PathVariable("userId") Long userId,
                                                 @RequestBody LikeListRequestDTO request) {
        try{
            if (!authService.validateToken(authHeader, userId)){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                        new ApiResponseDTO<>(401, "驗證失敗請重新登入", null)
                );
            }
            likeListService.createLikeList(userId, request);
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

    @GetMapping
    public ResponseEntity<ApiResponseDTO<List<LikeListDTO>>> getAllLikeList(@RequestHeader("Authorization") String authHeader,
                                                            @PathVariable("userId") Long userId) {
        try{
            if (!authService.validateToken(authHeader, userId)){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                        new ApiResponseDTO<>(401, "驗證失敗請重新登入", null)
                );
            }
            List<LikeListDTO> dto = likeListService.getUserLikeList(userId);
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "讀取成功", dto)
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

    @GetMapping("/{likelistId}")
    public ResponseEntity<ApiResponseDTO<LikeListDTO>> getAllLikeList(@RequestHeader("Authorization") String authHeader,
                                                      @PathVariable("userId") Long userId,
                                                      @PathVariable("likelistId") Long likelistId) {
        try{
            if (!authService.validateToken(authHeader, userId)){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                        new ApiResponseDTO<>(401, "驗證失敗請重新登入", null)
                );
            }
            LikeListDTO dto = likeListService.getUserLikeListById(userId, likelistId);
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "讀取成功", dto)
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

    @PutMapping("/{likelistId}")
    public ResponseEntity<ApiResponseDTO<Void>> updateLikeList(@RequestHeader("Authorization") String authHeader,
                                                 @PathVariable("userId") Long userId,
                                                 @PathVariable("likelistId") Long likelistId,
                                                 @RequestBody LikeListUpdateDTO request) {
        try{
            if (!authService.validateToken(authHeader, userId)){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                        new ApiResponseDTO<>(401, "驗證失敗請重新登入", null)
                );
            }
            likeListService.updateLikeList(likelistId, userId, request);
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "讀取成功", null)
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

    @DeleteMapping("/{likelistId}")
    public ResponseEntity<ApiResponseDTO<Void>> updateLikeList(@RequestHeader("Authorization") String authHeader,
                                                 @PathVariable("userId") Long userId,
                                                 @PathVariable("likelistId") Long likelistId) {

        try{
            if (!authService.validateToken(authHeader, userId)){
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                        new ApiResponseDTO<>(401, "驗證失敗請重新登入", null)
                );
            }
            likeListService.deleteLikeList(userId, likelistId);
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "讀取成功", null)
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
