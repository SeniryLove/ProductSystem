package com.example.product_application_server.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDTO {
    private Long id;
    private String nationId;
    private String userName;
    private String email;
    private String account;
}