# Product_Application_Server

## 📦 Product_Application_Server 專案說明

本專案為後端應用伺服器，採用 **Spring Boot** 建立 RESTful API 服務，負責處理前端資料請求與業務邏輯運算。

---

## 💻 開發環境

- 作業系統：Windows 10  
- IDE：IntelliJ IDEA 2025.3.3  
- Java Version：OpenJDK 21  
- Build Tool：Maven  

---

## 🚀 技術框架

- Spring Boot 4.x  
- Spring Data JPA  
- Spring Security  
- JWT 身份驗證機制  
- MySQL Connector 8.0.33  
- Lombok 1.18.42  

---

## 📂 專案結構

```
📦 Product_Application_Server
│
├── 📂 src/main/java/com/example/product_application_server
│
│   ├── ⚙️ config/
│   │   ├── 🌐 WebConfig.java
│   │   │       # CORS 跨來源資源共享設定，允許前端呼叫 API
│   │   │
│   │   └── 🔐 SecurityConfig.java
│   │           # Spring Security 安全設定
│   │           # 控制 API 存取權限與 JWT 驗證流程
│   │
│   ├── 🎯 controller/
│   │   ├── 👤 AuthController.java
│   │   │       # 登入驗證 API
│   │   │       # 回傳 JWT Token
│   │   │
│   │   ├── 👥 UserController.java
│   │   │       # 使用者管理 API
│   │   │       # 查詢、建立或更新使用者資料
│   │   │
│   │   ├── 🛒 ProductController.java
│   │   │       # 商品管理 API
│   │   │       # 商品 CRUD 操作
│   │   │
│   │   └── ❤️ LikeListController.java
│   │           # 收藏清單 API
│   │           # 新增收藏、取消收藏、查詢收藏商品
│   │
│   ├── 🧠 service/
│   │   ├── AuthService.java
│   │   │       # 處理登入驗證與 JWT Token 生成
│   │   │
│   │   ├── UserService.java
│   │   │       # 使用者相關商業邏輯
│   │   │
│   │   ├── ProductService.java
│   │   │       # 商品管理商業邏輯
│   │   │
│   │   └── LikeListService.java
│   │           # 收藏清單商業邏輯
│   │
│   ├── 💾 repository/
│   │   ├── UserRepository.java
│   │   │       # 使用者資料庫存取介面
│   │   │
│   │   ├── ProductRepository.java
│   │   │       # 商品資料庫存取介面
│   │   │
│   │   └── LikeListRepository.java
│   │           # 收藏清單資料庫存取介面
│   │
│   ├── 📤 dto/
│   │   ├── ApiResponseDTO.java
│   │   │       # API 統一回傳格式
│   │   │
│   │   ├── LoginRequestDTO.java
│   │   │       # 登入請求資料
│   │   │
│   │   ├── LoginResponseDTO.java
│   │   │       # 登入回傳資料（包含 JWT Token）
│   │   │
│   │   ├── UserDTO.java
│   │   │       # 使用者資料傳輸物件
│   │   │
│   │   ├── UserRequestDTO.java
│   │   │       # 使用者請求資料
│   │   │
│   │   ├── ProductDTO.java
│   │   │       # 商品資料傳輸物件
│   │   │
│   │   ├── LikeListDTO.java
│   │   │       # 收藏清單資料
│   │   │
│   │   ├── LikeListRequestDTO.java
│   │   │       # 收藏新增請求
│   │   │
│   │   └── LikeListUpdateDTO.java
│   │           # 收藏更新請求
│   │
│   ├── 🗄 entity/
│   │   ├── User.java
│   │   │       # 使用者資料表 Entity
│   │   │
│   │   ├── Product.java
│   │   │       # 商品資料表 Entity
│   │   │
│   │   └── LikeList.java
│   │           # 收藏清單資料表 Entity
│   │
│   ├── 🛠 util/
│   │   └── 🔑 JwtUtil.java
│   │           # JWT Token 生成與驗證工具
│   │
│   └── 🚀 ProductApplicationServerApplication.java
│           # Spring Boot 應用程式啟動入口
│
├── 📂 src/main/resources
│
│   └── ⚙️ application.properties
│           # 系統設定與資料庫連線配置
│
├── 📄 pom.xml
│       # Maven 專案依賴與建置設定
│
└── 📄 README.md
        # 專案說明文件
```

---

## 🔐 安全機制

- JWT Token 身份驗證  
- CORS 跨來源資源共享設定  

---

## 🗄 資料庫連線

- 使用 MySQL Connector 進行資料庫連線  

---

## ⚠️ 注意事項

- 開發與部署環境請統一 Java 21  
- JWT Secret Key 不可公開  
- 若前後端分離部署，請確認 CORS 設定  
