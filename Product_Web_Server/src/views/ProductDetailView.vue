<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getProductByIdApi } from '@/api/productApi'
import { addLikeListApi } from '@/api/likelistApi'
import { useAuthStore } from '@/stores/authStore'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

const product = ref<any>(null)
const auth = useAuthStore()

const quantity = ref<number>(1)
const id = ref<number>(0)

const message = ref('')
const messageType = ref<'success' | 'error'>('success')

onMounted(async () => {
  id.value = Number(route.params.productId)
  product.value = (await getProductByIdApi(id.value)).data
})

function increaseQuantity() {
  quantity.value++
}

function decreaseQuantity() {
  if (quantity.value > 1) quantity.value--
}

function formatPrice(price: number) {
  return Math.round(price)
}

function formatFee(fee: number) {
  return parseFloat(fee.toFixed(4))
}

async function addLikeList() {
  // ✅ 未登入防呆
  if (!auth.user) {
    messageType.value = 'error'
    message.value = '請先登入'
    setTimeout(() => (message.value = ''), 3000)
    router.push('/login')
    return
  }

  try {
    const update_result = await addLikeListApi(
      auth.user.userId,   // ✅ 修正
      id.value,
      quantity.value
    )

    messageType.value = 'success'
    message.value = '加入喜愛清單成功！'
    setTimeout(() => (message.value = ''), 3000)

  } catch (err) {
    const errorMsg = ref<String | null>()
    if (axios.isAxiosError(err)) {
  
      const status = err.response?.status
      const msg = err.response?.data?.message
      
      if (status == 401){
        alert('尚未登入或登入逾時，請先登入')
      }
      if (status && msg) {
        errorMsg.value = msg
      } else {
        errorMsg.value = '系統錯誤'
      }
  
    } else {
      errorMsg.value = '未知錯誤'
    }
    messageType.value = 'error'
    message.value = '加入失敗  '+errorMsg?.value || '未知錯誤'
    setTimeout(() => (message.value = ''), 3000)
  }
}
</script>

<template>
  <div v-if="product" class="product-page">
    <h2 class="product-title">{{ product.productName }}</h2>
    <p class="product-desc">{{ product.description }}</p>

    <div class="product-info">
      <p><strong>No:</strong> {{ product.no }}</p>
      <p><strong>價格:</strong> $NT {{ formatPrice(product.price) }}</p>
      <p><strong>手續費:</strong> {{ formatFee(product.feeRate * 100) }}%</p>
    </div>

    <div class="quantity-control">
      <button @click="decreaseQuantity">-</button>
      <input type="number" v-model.number="quantity" min="1" />
      <button @click="increaseQuantity">+</button>
    </div>

    <div v-if="message" :class="['message', messageType]">{{ message }}</div>

    <button class="add-like-btn" @click="addLikeList">
      加入喜愛 ({{ quantity }})
    </button>
  </div>
</template>

<style scoped>
.product-page {
  max-width: 600px;
  margin: 2rem auto;
  padding: 1.5rem;
  border-radius: 10px;
  box-shadow: 0 3px 10px rgba(0,0,0,0.1);
  background-color: #fff;
  font-family: Arial, sans-serif;
}

.product-title {
  font-size: 2rem;
  margin-bottom: 0.5rem;
  color: #333;
}

.product-desc {
  color: #555;
  margin-bottom: 1rem;
}

.product-info p {
  margin: 0.3rem 0;
  color: #444;
}

.quantity-control {
  display: flex;
  align-items: center;
  margin: 1rem 0;
}

.quantity-control button {
  width: 35px;
  height: 35px;
  font-size: 1.2rem;
  border: 1px solid #ccc;
  background: #f0f0f0;
  cursor: pointer;
  border-radius: 5px;
  transition: 0.2s;
}

.quantity-control button:hover {
  background: #e0e0e0;
}

.quantity-control input {
  width: 60px;
  text-align: center;
  margin: 0 0.5rem;
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 0.3rem;
}

.add-like-btn {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 0.7rem 1.5rem;
  font-size: 1rem;
  cursor: pointer;
  border-radius: 5px;
  transition: background-color 0.3s;
  display: block;
  margin-top: 1rem;
}

.add-like-btn:hover {
  background-color: #45a049;
}

/* 成功/錯誤訊息 */
.message {
  margin-top: 0.5rem;
  font-weight: 600;
  text-align: center;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  animation: fade 0.3s ease-in-out;
}

.message.success {
  color: #155724;
  background-color: #d4edda;
  border: 1px solid #c3e6cb;
}

.message.error {
  color: #721c24;
  background-color: #f8d7da;
  border: 1px solid #f5c6cb;
}

@keyframes fade {
  from { opacity: 0; }
  to { opacity: 1; }
}
</style>