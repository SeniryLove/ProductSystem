# Product_Web_Server

## 📦 Product_Web_Server 專案說明

本專案為商品管理系統的 **前端 Web 應用程式**，使用 **Vue 3 + TypeScript** 開發，提供使用者商品瀏覽、收藏清單管理、會員登入與註冊等功能。

系統採用 **前後端分離架構 (Frontend / Backend Separation)**，透過 API 與後端服務進行資料交換。

---

## 💻 開發環境

* 作業系統：Windows 10
* Node.js：建議 **LTS 版本**
* Vue：3.5.29
* TypeScript：支援
* Build Tool：Vite

---

## 🚀 技術框架

* Vue 3
* TypeScript
* Vite
* Pinia（狀態管理）
* Vue Router（前端路由）
* Axios（HTTP 請求）

---

## 📂 專案結構

```
📦 Product_Web_Server
│
├── 📂 public/
│   │
│   ├── ⚙️ config.json
│   │       # 環境設定檔
│   │       # 設定後端 API Base URL
│   │
│   └── 🌐 favicon.ico
│           # 網站圖示
│
├── 📂 src/
│
│   ├── 📡 api/
│   │   ├── 👤 authApi.ts
│   │   │       # 身份驗證 API
│   │   │       # 登入 / 註冊相關請求
│   │   │
│   │   ├── ❤️ likelistApi.ts
│   │   │       # 收藏清單 API
│   │   │       # 收藏商品相關操作
│   │   │
│   │   └── 🛒 productApi.ts
│   │           # 商品資料 API
│   │           # 商品查詢與管理
│   │
│   ├── 🧩 components/
│   │   └── 📋 NavMenu.vue
│   │           # 導航選單元件
│   │
│   ├── 🧱 layouts/
│   │   └── 🖥 MainLayout.vue
│   │           # 系統主要版面配置
│   │
│   ├── 🧭 router/
│   │   └── index.ts
│   │           # Vue Router 路由設定
│   │
│   ├── 🗂 stores/
│   │   ├── 👤 authStore.ts
│   │   │       # 使用者登入狀態管理
│   │   │
│   │   ├── 🔢 counter.ts
│   │   │       # Pinia 預設範例
│   │   │
│   │   ├── ❤️ likelistStore.ts
│   │   │       # 收藏清單狀態管理
│   │   │
│   │   └── 🛒 productStore.ts
│   │           # 商品資料狀態管理
│   │
│   ├── 🛠 utils/
│   │   └── 🌐 axios.ts
│   │           # Axios HTTP 請求封裝
│   │           # 設定 API BaseURL 與攔截器
│   │
│   ├── 📄 views/
│   │   ├── 🔐 LoginView.vue
│   │   │       # 使用者登入頁面
│   │   │
│   │   ├── 📝 RegisterView.vue
│   │   │       # 使用者註冊頁面
│   │   │
│   │   ├── 🛒 ProductView.vue
│   │   │       # 商品列表頁面
│   │   │
│   │   ├── 📦 ProductDetailView.vue
│   │   │       # 商品詳細資訊頁面
│   │   │
│   │   ├── ❤️ LikeListView.vue
│   │   │       # 收藏清單頁面
│   │   │
│   │   └── 📑 LikeListDetailView.vue
│   │           # 收藏商品詳細頁面
│   │
│   ├── 🧩 App.vue
│   │       # Vue 應用程式根元件
│   │
│   └── 🚀 main.ts
│           # Vue 應用程式啟動入口
│
├── 📦 dist/
│       # 專案打包輸出目錄
│
├── 📄 package.json
│       # Node.js 專案依賴設定
│
└── 📄 README.md
        # 專案說明文件
```

---

## ⚙️ config.json 設定

本專案使用 **public/config.json** 作為環境設定檔。

### 範例

```json
{
  "apiBaseUrl": "http://localhost:8080/api"
}
```

### 特性

* 支援 **開發與正式環境 API 切換**
* 部署後可 **直接修改 config.json**
* 不需要重新打包前端

---

## 🚀 安裝與執行（開發模式）

### 安裝套件

```
npm install
```

### 啟動開發伺服器

```
npm run dev
```

預設網址：

```
http://localhost:5173
```

---

## 📦 專案打包

```
npm run build
```

打包輸出：

```
dist/
```

---

## 🌐 部署方式

部署以下檔案：

```
dist/
 ├── assets/
 ├── config.json
 ├── favicon.ico
 └── index.html
```

---

## 🔐 API 通訊方式

* 使用 **Axios** 發送 HTTP 請求
* Token 透過 **HTTP Header Authorization** 傳遞
* 使用 **Pinia Store** 管理登入狀態

---

## ⚠️ 注意事項

* 修改 `public/config.json` 後需要重新 build
* 部署後修改 `dist/config.json` 即可更新 API
* 若 API 無法呼叫請確認 **後端 CORS 設定**
* 建議部署時清除瀏覽器快取
