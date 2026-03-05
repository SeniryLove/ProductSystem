package com.example.product_application_server.repository;

import com.example.product_application_server.entity.LikeList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface LikeListRepository extends JpaRepository<LikeList, Long> {

    @Procedure("ProductSystem.sp_GetUserLikeList")
    List<Object[]> getUserLikeList(@Param("p_UserID") Long userId);

    @Procedure("ProductSystem.sp_GetUserLikeListById")
    List<Object[]> getUserLikeListById(@Param("p_UserID") Long userId,
                                 @Param("p_ListID") Long listId);

    @Procedure("ProductSystem.sp_AddLikeList")
    void createLikeList(
            @Param("p_UserID") Long userId,
            @Param("p_ProductID") Long productId,
            @Param("p_Quantity") Integer quantity
    );

    @Procedure("ProductSystem.sp_UpdateLikeList")
    void updateLikeList(
            @Param("p_LikeListId") Long listId,
            @Param("p_UserId") Long userId,
            @Param("p_ProductId") Long productId,
            @Param("p_PurchaseQuantity") Integer purchaseQuantity,
            @Param("p_Account") String account
    );

    @Procedure("ProductSystem.sp_DeleteLikeList")
    void deleteLikeList(@Param("p_UserID") Long userId,
                        @Param("p_ListID") Long listId);
}