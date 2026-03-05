package com.example.product_application_server.dto;

import lombok.Builder;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserRequestDTO {
    private String nationId;
    private String userName;
    private String email;
    private String password; // 創建/更新時需要
    private String account;
}