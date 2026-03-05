package com.example.product_application_server.service;

import com.example.product_application_server.dto.LoginRequestDTO;
import com.example.product_application_server.dto.LoginResponseDTO;
import com.example.product_application_server.repository.UserRepository;
import com.example.product_application_server.util.JwtUtil;
import com.example.product_application_server.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @Transactional
    public LoginResponseDTO login(LoginRequestDTO request) {
        List<Object[]> userObj = userRepository.getUserByEmailAndNationId(request.getEmail(), request.getNationId());

        if (userObj.isEmpty()) {
            throw new IllegalArgumentException("找不到使用者");
        }

        for (Object[] row: userObj) {
            String hashedPassword = (String) row[5]; // SP 回傳的加密密碼
            String userName = (String) row[2];       // 假設 userName 在第三個欄位
            Long id = (Long) row[0];       // 假設 userName 在第三個欄位

            if (!passwordEncoder.matches(request.getPassword(), hashedPassword)) {
                throw new IllegalArgumentException("密碼錯誤");
            }

            // 成功，生成 JWT token
            String token = jwtUtil.generateToken(id, userName, request.getNationId());

            return new LoginResponseDTO(token, id, userName);
        }
        return null;
    }

    public boolean validateToken(String authHeader, Long id) {
        String token = authHeader.replace("Bearer ", "");
        if (!jwtUtil.validateToken(token, id)) {
            return false;
        }
        return true;
    }
}