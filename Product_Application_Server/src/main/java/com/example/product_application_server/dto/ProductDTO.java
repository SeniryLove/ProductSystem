package com.example.product_application_server.dto;

import lombok.*;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {
    private Long id;
    private String no;
    private String productName;
    private BigDecimal price;
    private BigDecimal feeRate;
}