package com.example.product_application_server.service;

import com.example.product_application_server.dto.UserDTO;
import com.example.product_application_server.dto.UserRequestDTO;
import com.example.product_application_server.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    @Transactional
    public void createUser(UserRequestDTO request) {
        try{
            String hashedPassword = passwordEncoder.encode(request.getPassword());
            userRepository.createUser(
                    request.getNationId(),
                    request.getUserName(),
                    request.getEmail(),
                    hashedPassword, // 這裡可在 SP 前先加密
                    request.getAccount()
            );
        } catch (RuntimeException ex) {
            Throwable cause = ex.getCause();
            String spMessage = null;

            while (cause != null) {
                if (cause instanceof java.sql.SQLException) {
                    spMessage = cause.getMessage();
                    break;
                }
                cause = cause.getCause();
            }

            if (spMessage != null) {
                // 可以丟自訂例外
                throw new IllegalArgumentException(spMessage);
            }
            throw ex;
        }
    }

    @Transactional
    public void updateUser(Long id, UserRequestDTO request) {
        try{
            String hashedPassword = passwordEncoder.encode(request.getPassword());
            userRepository.updateUser(
                    id,
                    request.getUserName(),
                    request.getEmail(),
                    hashedPassword, // 可先加密
                    request.getAccount()
            );
        }catch (RuntimeException ex) {
            Throwable cause = ex.getCause();
            String spMessage = null;

            while (cause != null) {
                if (cause instanceof java.sql.SQLException) {
                    spMessage = cause.getMessage();
                    break;
                }
                cause = cause.getCause();
            }

            if (spMessage != null) {
                // 可以丟自訂例外
                throw new IllegalArgumentException(spMessage);
            }
            throw ex;
        }

    }

    // 查詢使用者
    @Transactional
    public UserDTO getUser(Long id) {
        try {
            List<Object[]> userObj = userRepository.getUserById(id);
            if (userObj.isEmpty()) return null;

            for (Object[] row : userObj) {
                // 每個 row 對應 SP 回傳的一列
                UserDTO dto = new UserDTO();

                dto.setId(row[0] != null ? ((Number) row[0]).longValue() : null);
                dto.setNationId(row[1] != null ? (String) row[1] : null);
                dto.setUserName(row[2] != null ? (String) row[2] : null);
                dto.setEmail(row[3] != null ? (String) row[3] : null);
                dto.setAccount(row[4] != null ? (String) row[4] : null);

                return dto;
            }
            return null;
        } catch (RuntimeException ex) {
            Throwable cause = ex.getCause();
            String spMessage = null;

            while (cause != null) {
                if (cause instanceof java.sql.SQLException) {
                    spMessage = cause.getMessage();
                    break;
                }
                cause = cause.getCause();
            }

            if (spMessage != null) {
                // 可以丟自訂例外
                throw new IllegalArgumentException(spMessage);
            }
            throw ex;
        }
    }
}