# ProductSystem 專案說明文件

## 📌 專案架構

本專案為商品管理系統，採用 **前後端與資料庫三層式分離架構**，包含：

- Product_Web_Server（前端 Vue 3）
- Product_DB（資料庫設計與 Stored Procedure）
- Product_Backend_Server（Spring Boot 後端服務）

系統資料流：

前端 → REST API → 後端服務 → Stored Procedure → Database

---

## 📂 Product_DB

### 專案用途

Product_DB 為系統資料庫管理專案，包含：

- 資料庫結構定義 (DDL)
- 資料操作語句 (DML)
- Stored Procedure (SP)
- 使用者權限管理

資料庫設計原則：

- Schema 化管理
- 資料存取透過 Stored Procedure
- 建立專用資料庫帳號控管權限

---

## 📜 SQL 檔案說明

### ① ProductSystem_All_DDL_SP.sql

包含：

- Database Schema 建立
- Table 結構設計
- Index 建立
- Stored Procedure 定義

用途：

- 系統資料庫初始化
- 建立核心資料存取邏輯

適用情境：

- 系統初始建置
- 資料庫重建

---

### ② ProductSystem_All_DML.sql

包含系統初始資料：

- 測試帳號資料
- 預設商品資料
- 系統運行必要基礎資料

用途：

- 開發環境初始化
- 系統展示資料載入

⚠️ 注意：

- 正式環境請審慎執行。

---

### ③ ProductSystem_Create_Grant_User.sql

功能說明：

- 建立資料庫操作帳號
- 授予 ProductSystem 完整資料庫權限
- 允許從任意來源主機登入

授權範圍：

- ProductSystem Schema ALL PRIVILEGES（完整資料庫權限）

用途：

- 提供後端服務專用資料庫帳號
- 確保系統可完整存取資料庫資源

---

## ⚙️ 資料庫部署順序（重要）

請依照下列順序執行 SQL：

```bash
① ProductSystem_All_DDL_SP.sql
② ProductSystem_All_DML.sql
③ ProductSystem_Create_Grant_User.sql
