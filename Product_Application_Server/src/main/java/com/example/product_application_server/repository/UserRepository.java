package com.example.product_application_server.repository;

import com.example.product_application_server.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Create
    @Procedure(procedureName = "ProductSystem.sp_CreateUser")
    void createUser(
            @Param("p_NationID") String nationId,
            @Param("p_UserName") String userName,
            @Param("p_Email") String email,
            @Param("p_Password") String password,
            @Param("p_Account") String account
    );

    // Update
    @Procedure(procedureName = "ProductSystem.sp_UpdateUser")
    void updateUser(
            @Param("p_id") Long id,
            @Param("p_UserName") String userName,
            @Param("p_Email") String email,
            @Param("p_Password") String password,
            @Param("p_Account") String account
    );

    // Get By Id
    @Procedure(procedureName = "ProductSystem.sp_GetUserById")
    List<Object[]> getUserById(
            @Param("p_id") Long id
    );

    /**
     * 透過 Email + NationID 查詢使用者資料（包含加密密碼）
     * 回傳 List<Object[]>，每個 Object[] 對應一個使用者欄位：
     * 0:id, 1:nationId, 2:userName, 3:email, 4:account, 5:password
     */
    @Procedure(procedureName = "ProductSystem.sp_GetUserByEmailAndNationId")
    List<Object[]> getUserByEmailAndNationId(
            @Param("p_email") String email,
            @Param("p_nationId") String nationId
    );
}