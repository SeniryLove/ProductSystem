<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/authStore'
import axios from 'axios'

// 表單欄位
const username = ref('')
const email = ref('')
const nationId = ref('')
const password = ref('')
const account = ref('')
const errorMsg = ref('')

// 欄位錯誤訊息
const usernameError = ref('')
const emailError = ref('')
const nationIdError = ref('')
const passwordError = ref('')
const accountError = ref('')

const auth = useAuthStore()
const router = useRouter()

// 驗證函數
function validateEmail(value: string) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return re.test(value)
}

function validateNationId(value: string) {
  const re = /^[A-Z][0-9]{9}$/
  return re.test(value)
}

function validatePassword(value: string) {
  // 密碼: 8-20 位，至少一個大寫、一個小寫、一個數字、至少一個特殊符號 !@#%$*_-
  const re = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#%$*_\-])[A-Za-z0-9!@#%$*_\-]{8,20}$/
  return re.test(value)
}

function validateUsername(value: string) {
  // 至少 2 個字元
  const re = /^[\u4e00-\u9fa5]{2,}$/
  return re.test(value)
}

function validateAccount(value: string) {
  // 假設真實金融帳號格式: 10~17 位數字
  const re = /^[0-9]{10,17}$/
  return re.test(value)
}

// 即時驗證
function onUsernameBlur() {
  usernameError.value = validateUsername(username.value) ? '' : '姓名為中文字至少 2 字元'
}

function onEmailBlur() {
  emailError.value = validateEmail(email.value) ? '' : 'Email 格式不正確'
}

function onNationIdBlur() {
  nationIdError.value = validateNationId(nationId.value) ? '' : '身分證格式錯誤 (A123456789)'
}

function onPasswordBlur() {
  passwordError.value = validatePassword(password.value)
    ? ''
    : '密碼需 8-20 位，含大寫、小寫、數字及 !@#%$*_-'
}

function onAccountBlur() {
  accountError.value = validateAccount(account.value) ? '' : '帳號需 10~17 位數字(含銀行代碼)'
}

// 是否可提交
const canSubmit = computed(() => {
  return (
    username.value &&
    email.value &&
    nationId.value &&
    password.value &&
    account.value &&
    !usernameError.value &&
    !emailError.value &&
    !nationIdError.value &&
    !passwordError.value &&
    !accountError.value
  )
})

// 註冊
async function handleRegister() {
  onUsernameBlur()
  onEmailBlur()
  onNationIdBlur()
  onPasswordBlur()
  onAccountBlur()

  if (!canSubmit.value) return

  try {
    const msg = await auth.register({
      nationId: nationId.value,
      userName: username.value,
      email: email.value,
      password: password.value,
      account: account.value
    })
    alert("註冊成功!! 將自動轉跳到登入頁面")
    router.push('/login')

  } catch (error: unknown) {
    if (axios.isAxiosError(error)) {
      
      const status = error.response?.status
      if (status == 401){
        alert('驗證失敗')
      }else{
        errorMsg.value = error.response?.data?.message ?? '註冊失敗'
      }
    } else {
      errorMsg.value = '系統錯誤'
    }
  }
}
</script>

<template>
  <div class="auth-container">
    <h2 class="title">註冊</h2>

    <div v-if="errorMsg" class="error-msg">{{ errorMsg }}</div>

    <div class="form-group">
      <label>中文姓名</label>
      <input v-model="username" @blur="onUsernameBlur" placeholder="中文姓名" />
      <div v-if="usernameError" class="field-error">{{ usernameError }}</div>
    </div>

    <div class="form-group">
      <label>Email</label>
      <input v-model="email" type="email" @blur="onEmailBlur" placeholder="Email" />
      <div v-if="emailError" class="field-error">{{ emailError }}</div>
    </div>

    <div class="form-group">
      <label>身分證字號</label>
      <input v-model="nationId" maxlength="10" @blur="onNationIdBlur" placeholder="A123456789" />
      <div v-if="nationIdError" class="field-error">{{ nationIdError }}</div>
    </div>

    <div class="form-group">
      <label>密碼</label>
      <input v-model="password" type="password" @blur="onPasswordBlur" placeholder="8-20 位，含大寫、小寫、數字及 !@#%$* _ -" />
      <div v-if="passwordError" class="field-error">{{ passwordError }}</div>
    </div>

    <div class="form-group">
      <label>一般活期/儲蓄存款帳號</label>
      <input v-model="account" @blur="onAccountBlur" placeholder="10~17 位數字(含銀行代碼)" />
      <div v-if="accountError" class="field-error">{{ accountError }}</div>
    </div>

    <button :disabled="!canSubmit" @click="handleRegister" class="register-btn">註冊</button>

    <p class="login-text">
      已有帳號？ 
      <router-link to="/login">登入</router-link>
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

.register-btn {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 0.7rem;
  font-size: 1rem;
  border-radius: 5px;
  cursor: pointer;
  transition: 0.3s;
}

.register-btn:disabled {
  background-color: #9e9e9e;
  cursor: not-allowed;
}

.register-btn:hover:enabled {
  background-color: #45a049;
}

.login-text {
  text-align: center;
  color: #555;
  font-size: 0.9rem;
}
</style>