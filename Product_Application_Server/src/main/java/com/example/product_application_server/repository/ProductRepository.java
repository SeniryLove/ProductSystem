package com.example.product_application_server.repository;

import com.example.product_application_server.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    @Procedure("ProductSystem.sp_CreateProduct")
    void createProduct(
            @Param("p_No") String no,
            @Param("p_ProductName") String productName,
            @Param("p_Price") BigDecimal price,
            @Param("p_FeeRate") BigDecimal feeRate
    );

    @Procedure("ProductSystem.sp_UpdateProduct")
    void updateProduct(
            @Param("p_id") Long id,
            @Param("p_No") String no,
            @Param("p_ProductName") String productName,
            @Param("p_Price") BigDecimal price,
            @Param("p_FeeRate") BigDecimal feeRate
    );

    @Procedure("ProductSystem.sp_GetAllProducts")
    List<Object[]> getAllProducts();

    @Procedure("ProductSystem.sp_GetProductById")
    List<Object[]> getProductById(@Param("p_id") Long id);
}