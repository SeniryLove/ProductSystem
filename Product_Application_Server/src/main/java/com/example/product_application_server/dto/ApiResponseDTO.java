package com.example.product_application_server.dto;

import lombok.*;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApiResponseDTO<T> {
    private int status;
    private String message;
    private T data;
}