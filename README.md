# Product Application System

## 📌 系統架構

本專案採用三層式架構設計：

- Frontend（前端層）：Product_Web_Server
- Backend（後端應用層）：Product_Application_Server
- Database（資料層）：Product_DB

---

## 💻 開發環境

### Backend 開發環境
- 作業系統：Windows 10
- IDE：IntelliJ IDEA 2025.3.3
- Java Version：OpenJDK 21
- Build Tool：Maven

### Frontend 開發環境
- 作業系統：Ubuntu 20.04
- Node.js：建議 LTS 版本
- Package Manager：npm / yarn（依專案設定）

### Database 環境
- 作業系統：Ubuntu 20.04
- Database：MySQL Server 8.0.42

---

## 🚀 Backend（Product_Application_Server）

### Framework
- Spring Boot 4.x

### 主要套件版本

| 套件 | 版本 |
|---|---|
| Spring Boot Starter WebMVC | 內建 |
| Spring Boot Starter Data JPA | 4.1.0-M2 |
| Spring Boot Starter Security | 內建 |
| MySQL Connector | 8.0.33 |
| Lombok | 1.18.42 |
| JSON Web Token (jjwt) | 0.11.5 |

### Java 版本
- Java 21

---

## 🌐 Frontend（Product_Web_Server）

### Framework
- Vue 3

### 主要套件版本

| 套件 | 版本 |
|---|---|
| vue | ^3.5.29 |
| vue-router | ^5.0.3 |
| vite vue plugin | ^6.0.4 |
| vue-tsc | ^3.2.5 |
| eslint-plugin-vue | ~10.8.0 |
| vite-plugin-vue-devtools | ^8.0.6 |
| @vue/tsconfig | ^0.8.1 |
| @vue/eslint-config-typescript | ^14.7.0 |
| type-check | vue-tsc --build |

---

## 🗄 Database（Product_DB）

- MySQL Server Version  
  - Server version: 8.0.42 (Ubuntu 20.04)

---

## ⚠️ 注意事項

- 前端與後端需確認 CORS 設定
- 部署環境請統一 Java 21
- 建議 MySQL 啟用連線池管理
