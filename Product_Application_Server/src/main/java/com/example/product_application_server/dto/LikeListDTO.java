package com.example.product_application_server.dto;

import lombok.*;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeListDTO {
    private Long id;
    private String sn;
    private String email;          // User Email
    private String productName;
    private Integer purchaseQuantity;
    private BigDecimal totalAmount;
    private BigDecimal totalFee;
    private String account;
}