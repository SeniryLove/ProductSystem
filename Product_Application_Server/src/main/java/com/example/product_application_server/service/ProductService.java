package com.example.product_application_server.service;

import com.example.product_application_server.dto.ProductDTO;
import com.example.product_application_server.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    @Transactional
    public List<ProductDTO> getAllProducts() {
        return productRepository.getAllProducts()
                .stream()
                .map(obj -> {
                    Object[] arr = (Object[]) obj;
                    return ProductDTO.builder()
                            .id(((Number) arr[0]).longValue())
                            .no((String) arr[1])
                            .productName((String) arr[2])
                            .price((BigDecimal) arr[3])
                            .feeRate((BigDecimal) arr[4])
                            .build();
                }).collect(Collectors.toList());
    }

    @Transactional
    public ProductDTO getProductById(Long id) {
        List<Object[]> arr = productRepository.getProductById(id);
        if (arr.isEmpty()) return null;
        for (Object[] row: arr){
            return ProductDTO.builder()
                    .id(((Number) row[0]).longValue())
                    .no((String) row[1])
                    .productName((String) row[2])
                    .price((BigDecimal) row[3])
                    .feeRate((BigDecimal) row[4])
                    .build();
        }
        return null;
    }

    public void createProduct(String no, String productName, BigDecimal price, BigDecimal feeRate) {
        productRepository.createProduct(no, productName, price, feeRate);
    }

    public void updateProduct(Long id, String no, String productName, BigDecimal price, BigDecimal feeRate) {
        productRepository.updateProduct(id, no, productName, price, feeRate);
    }
}