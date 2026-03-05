package com.example.product_application_server.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "Product")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "No", nullable = false, unique = true, length = 50)
    private String no;

    @Column(name = "ProductName", nullable = false, length = 200)
    private String productName;

    @Column(name = "Price", nullable = false, precision = 15, scale = 2)
    private BigDecimal price;

    @Column(name = "FeeRate", nullable = false, precision = 5, scale = 4)
    private BigDecimal feeRate;
}