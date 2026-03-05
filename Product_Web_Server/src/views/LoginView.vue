<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/authStore'
import axios from 'axios'

const email = ref('')
const nationid = ref('')
const password = ref('')
const errorMsg = ref('')

const emailError = ref('')
const nationidError = ref('')
const passwordError = ref('')

const auth = useAuthStore()
const router = useRouter()

function validateEmail(value: string) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return re.test(value)
}

function validateNationId(value: string) {
  const re = /^[A-Z][0-9]{9}$/
  return re.test(value)
}

function validatePassword(value: string) {
  const re = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\_\-!@#%$*])[A-Za-z0-9!@#%$*]{8,20}$/
  return re.test(value)
}

function onEmailBlur() {
  emailError.value = validateEmail(email.value) ? '' : 'Email 格式不正確'
}

function onNationIdBlur() {
  nationidError.value = validateNationId(nationid.value)
    ? ''
    : '身分證格式錯誤 (A123456789)'
}

function onPasswordBlur() {
  passwordError.value = validatePassword(password.value)
    ? ''
    : '密碼需 8-20 位，含大寫、小寫、數字及 _-!@#%$*'
}

const canSubmit = computed(() => {
  return (
    email.value &&
    nationid.value &&
    password.value &&
    !emailError.value &&
    !nationidError.value &&
    !passwordError.value
  )
})

async function handleLogin() {
  onEmailBlur()
  onNationIdBlur()
  onPasswordBlur()

  if (!canSubmit.value) return

  try {
    await auth.login(email.value, nationid.value, password.value)
    router.push('/')
  } catch (error: unknown) {
    if (axios.isAxiosError(error)) {
      const status = error.response?.status
      if (status == 401){
        alert('登入逾時，請先登入')
        await auth.logout()
      }else{
        errorMsg.value = error.response?.data?.message ?? '註冊失敗'
      }
      errorMsg.value = error.response?.data?.message || '登入失敗'
    } else {
      errorMsg.value = '系統錯誤'
    }
  }
}
</script>

<template>
  <div class="auth-container">
    <h2 class="title">登入</h2>

    <div v-if="errorMsg" class="error-msg">{{ errorMsg }}</div>

    <div class="form-group">
      <label>Email</label>
      <input v-model="email" type="email" @blur="onEmailBlur" placeholder="Email" />
      <div v-if="emailError" class="field-error">{{ emailError }}</div>
    </div>

    <div class="form-group">
      <label>身分證字號</label>
      <input v-model="nationid" maxlength="10" @blur="onNationIdBlur" placeholder="A123456789" />
      <div v-if="nationidError" class="field-error">{{ nationidError }}</div>
    </div>

    <div class="form-group">
      <label>密碼</label>
      <input v-model="password" type="password" @blur="onPasswordBlur" placeholder="8-20 位，含大寫、小寫、數字及 _-!@#%$*" />
      <div v-if="passwordError" class="field-error">{{ passwordError }}</div>
    </div>

    <button :disabled="!canSubmit" @click="handleLogin" class="login-btn">登入</button>

    <p class="register-text">
      沒有帳號？ 
      <router-link to="/register">註冊</router-link>
    </p>
  </div>
</template>

<style scoped>
.auth-container {
  max-width: 400px;
  margin: 80px auto;
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
  background-color: #fff;
  display: flex;
  flex-direction: column;
  gap: 1rem;
  font-family: Arial, sans-serif;
}

.title {
  text-align: center;
  font-size: 2rem;
  margin-bottom: 1rem;
  color: #333;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}

input {
  padding: 0.5rem 0.7rem;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 1rem;
}

input:focus {
  outline: none;
  border-color: #4CAF50;
  box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
}

.field-error {
  color: #d93025;
  font-size: 0.85rem;
}

.error-msg {
  color: #d93025;
  font-weight: bold;
  text-align: center;
}

.login-btn {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 0.7rem;
  font-size: 1rem;
  border-radius: 5px;
  cursor: pointer;
  transition: 0.3s;
}

.login-btn:disabled {
  background-color: #9e9e9e;
  cursor: not-allowed;
}

.login-btn:hover:enabled {
  background-color: #45a049;
}

.register-text {
  text-align: center;
  color: #555;
  font-size: 0.9rem;
}
</style>