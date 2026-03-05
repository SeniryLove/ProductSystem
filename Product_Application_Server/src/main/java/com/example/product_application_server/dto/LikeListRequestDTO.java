package com.example.product_application_server.dto;

import lombok.*;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeListRequestDTO {
    private Long productId;
    private Integer purchaseQuantity;
}