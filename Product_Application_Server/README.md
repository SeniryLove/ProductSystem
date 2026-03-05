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
📦 Product_Application_Server/

├── 📂 src/main/java/com/example/product_application_server/

│   ├── ⚙️ config/
│   │   ├── 🌐 WebConfig                  # CORS 跨域設定
│   │   ├── 🔐 SecurityConfig             # JWT 驗證設定
│   │   └── 🔑 JwtAuthenticationFilter    # Token 驗證過濾器

│   ├── 🎯 controller/
│   │   ├── 👤 AuthController             # 身份驗證 API
│   │   ├── 👥 UserController             # 使用者 API
│   │   ├── 🛒 ProductController          # 商品 API
│   │   └── ❤️ LikeListController        # 收藏清單 API

│   ├── 🧠 service/
│   │   ├── AuthService
│   │   ├── UserService
│   │   ├── ProductService
│   │   └── LikeListService

│   ├── 💾 repository/
│   │   ├── UserRepository
│   │   ├── ProductRepository
│   │   └── LikeListRepository

│   ├── 📤 dto/
│   │   ├── request/
│   │   └── response/

│   ├── 🗄 entity/
│   │   ├── User
│   │   ├── Product
│   │   └── LikeList

│   └── 🛠 utils/
│       └── JwtUtil                      # Token 驗證工具

├── 📂 src/main/resources/

│   ├── ⚙️ application.yml               # 系統配置
│   ├── 📦 static/                       # 靜態資源
│   └── 📄 templates/                   # Thymeleaf 模板（若使用）

├── 📂 src/test/java/

├── 📄 pom.xml                          # Maven 建置設定

└── 📄 README.md
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
