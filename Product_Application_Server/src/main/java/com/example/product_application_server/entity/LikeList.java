package com.example.product_application_server.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "LikeList",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"SN"})
        })
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeList {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "SN", nullable = false, unique = true, length = 50)
    private String sn;

    // Many LikeList 屬於一個 User
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UserID", nullable = false)
    private User user;

    // Many LikeList 屬於一個 Product
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PurchaseProductID", nullable = false)
    private Product product;

    @Column(name = "PurchaseQuantity", nullable = false)
    private Integer purchaseQuantity;

    @Column(name = "Account", nullable = false, length = 50)
    private String account;

    @Column(name = "TotalFee", nullable = false, precision = 15, scale = 2)
    private BigDecimal totalFee;

    @Column(name = "TotalAmount", nullable = false, precision = 15, scale = 2)
    private BigDecimal totalAmount;
}