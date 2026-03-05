package com.example.product_application_server.service;

import com.example.product_application_server.dto.LikeListDTO;
import com.example.product_application_server.dto.LikeListRequestDTO;
import com.example.product_application_server.dto.LikeListUpdateDTO;
import com.example.product_application_server.repository.LikeListRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LikeListService {

    private final LikeListRepository likeListRepository;

    // 取得使用者所有喜愛清單
    @Transactional
    public List<LikeListDTO> getUserLikeList(Long userId) {
        try {
            return likeListRepository.getUserLikeList(userId)
                    .stream()
                    .map(obj -> {
                        Object[] arr = (Object[]) obj;
                        return LikeListDTO.builder()
                                .id(((Long) arr[0]))
                                .sn((String) arr[1])
                                .email((String) arr[2])
                                .productName((String) arr[3])
                                .purchaseQuantity((Integer) arr[4])
                                .totalAmount((BigDecimal) arr[5])
                                .totalFee((BigDecimal) arr[6])
                                .account((String) arr[7])
                                .build();
                    }).collect(Collectors.toList());
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

    // 取得單筆喜愛清單
    @Transactional
    public LikeListDTO getUserLikeListById(Long userId, Long listId) {
        try {
            List<Object[]> arr = likeListRepository.getUserLikeListById(userId, listId);
            if (arr.isEmpty()) return null;
            for (Object[] row:arr){
                return LikeListDTO.builder()
                        .id(((Long) row[0]))
                        .sn((String) row[1])
                        .email((String) row[2])
                        .productName((String) row[3])
                        .purchaseQuantity((Integer) row[4])
                        .totalAmount((BigDecimal) row[5])
                        .totalFee((BigDecimal) row[6])
                        .account((String) row[7])
                        .build();
            }
            return null;
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

    @Transactional
    public void createLikeList(Long userId, LikeListRequestDTO likeListRequestDTO) {
        try {
            likeListRepository.createLikeList(userId, likeListRequestDTO.getProductId(), likeListRequestDTO.getPurchaseQuantity());
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

    @Transactional
    public void updateLikeList(Long listId, Long userId, LikeListUpdateDTO dto) {
        try {
            likeListRepository.updateLikeList(listId, userId, dto.getProductId(), dto.getPurchaseQuantity(), dto.getAccount());
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

    @Transactional
    public void deleteLikeList(Long userId, Long listId) {
        try {
            likeListRepository.deleteLikeList(userId, listId);
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
}