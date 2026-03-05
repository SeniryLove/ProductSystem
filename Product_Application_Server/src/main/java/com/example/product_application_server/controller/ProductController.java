package com.example.product_application_server.controller;

import com.example.product_application_server.dto.ApiResponseDTO;
import com.example.product_application_server.dto.ProductDTO;
import com.example.product_application_server.service.AuthService;
import com.example.product_application_server.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final AuthService authService;

    @GetMapping
    public ResponseEntity<ApiResponseDTO<List<ProductDTO>>> getAllProducts() {
        try{
            List<ProductDTO> products = productService.getAllProducts();
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "讀取成功", products)
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

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponseDTO<ProductDTO>> getProductById(@PathVariable Long id) {
        try{
            ProductDTO product = productService.getProductById(id);
            return ResponseEntity.ok(
                    new ApiResponseDTO<>(200, "讀取成功", product)
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