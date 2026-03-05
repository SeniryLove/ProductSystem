package com.example.product_application_server.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "User")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "NationID", nullable = false, unique = true, length = 20)
    private String nationId;

    @Column(name = "UserName", nullable = false, length = 100)
    private String userName;

    @Column(name = "Email", nullable = false, unique = true, length = 255)
    private String email;

    @Column(name = "Password", nullable = false, length = 255)
    private String password;

    @Column(name = "Account", nullable = false, length = 50)
    private String account;
}