<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/authStore'

const auth = useAuthStore()
const router = useRouter()

const isLoggedIn = computed(() => auth.isAuthenticated)

function goLogin() {
  router.push('/login')
}

function goRegister() {
  router.push('/register')
}

function goLikeList() {
  if (auth.user) {
    router.push('/likelist')
  }
}

function logout() {
  auth.logout()
  router.push('/login')
}
</script>

<template>
  <nav class="nav-menu">
    <div class="nav-left">
      <button @click="$router.push('/')">首頁</button>
    </div>

    <div class="nav-right">
      <!-- 未登入 -->
      <template v-if="!isLoggedIn">
        <button @click="goLogin">登入</button>
        <button @click="goRegister">註冊</button>
      </template>

      <!-- 已登入 -->
      <template v-else>
        <button @click="goLikeList">喜愛清單</button>
        <button class="logout-btn" @click="logout">登出</button>

        <!-- ✅ 修正這裡 -->
        <span v-if="auth.user" class="user-name">
          Hi, {{ auth.user.username }}
        </span>
      </template>
    </div>
  </nav>
</template>

<style scoped>
.nav-menu {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 20px;
  background-color: #2c3e50;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
  color: #fff;
  font-family: Arial, sans-serif;
}

.nav-left button {
  padding: 6px 14px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 500;
  background-color: #409eff;
  color: white;
  transition: 0.3s;
}

.nav-left button:hover {
  background-color: #66b1ff;
}

.nav-right button {
  padding: 6px 14px;
  margin-left: 10px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 500;
  transition: 0.3s;
  color: white;
}

.nav-right button.logout-btn {
  background-color: #e74c3c;
}

.nav-right button.logout-btn:hover {
  background-color: #ff3b30;
}

.nav-right button:not(.logout-btn) {
  background-color: #1abc9c;
}

.nav-right button:not(.logout-btn):hover {
  background-color: #48c9b0;
}

.user-name {
  margin-left: 12px;
  font-weight: 600;
}
</style>