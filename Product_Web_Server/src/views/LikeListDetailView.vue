<script setup lang="ts">
import { onMounted, ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/authStore'
import { useLikeListStore } from '@/stores/likelistStore'
import { useProductStore } from '@/stores/productStore'
import { updateLikeListApi, deleteLikeListApi } from '@/api/likelistApi'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

const auth = useAuthStore()
const likeListStore = useLikeListStore()
const productStore = useProductStore()

const detail = ref<any>(null)
const isEditing = ref(false)

const editQuantity = ref<number>(1)
const editAccount = ref('')
const editProductId = ref<number | null>(null)

/* =============================
   驗證函數
============================= */

// 數量驗證（整數且 >=1）
function validateQuantity(value: number) {
  return Number.isInteger(value) && value >= 1
}

// 帳號驗證（10~17純數字）
function validateAccount(value: string) {
  return /^[0-9]{10,17}$/.test(value)
}

/* =============================
   初始化資料
============================= */

onMounted(async () => {
  const id = Number(route.params.likelistId)

  if (likeListStore.items.length === 0) {
    await likeListStore.fetchLikeList()
  }

  if (productStore.products.length === 0) {
    await productStore.fetchProducts()
  }

  detail.value = likeListStore.items.find(
    item => Number(item.id) === id
  )

  if (detail.value) {
    editQuantity.value = detail.value.purchaseQuantity
    editAccount.value = detail.value.account

    const product = productStore.products.find(
      product => product.productName === detail.value.productName
    )

    editProductId.value = product?.id ?? null
  }
})

/* =============================
   商品選項
============================= */

const usedProductIds = computed(() =>
  likeListStore.items.map(item => String(item.productName))
)

const selectableProducts = computed(() =>
  productStore.products.filter(
    product =>
      product.productName === detail.value?.productName ||
      !usedProductIds.value.includes(String(product.productName))
  )
)

const bankCode = computed(() =>
  editAccount.value?.substring(0, 3) || ''
)

const accountNumber = computed(() =>
  editAccount.value?.substring(3) || ''
)

/* =============================
   格式化
============================= */

const formatAmount = (num: number) =>
  Math.round(num).toLocaleString()

const formatFee = (num: number) =>
  Number(num).toFixed(4)

/* =============================
   編輯流程
============================= */

function startEdit() {
  if (!detail.value) return

  editQuantity.value = detail.value.purchaseQuantity
  editAccount.value = detail.value.account

  const product = productStore.products.find(
    product => product.productName === detail.value.productName
  )

  editProductId.value = product?.id ?? null

  isEditing.value = true
}

function cancelEdit() {
  if (!detail.value) return

  editQuantity.value = detail.value.purchaseQuantity
  editAccount.value = detail.value.account

  const product = productStore.products.find(
    product => product.productName === detail.value.productName
  )

  editProductId.value = product?.id ?? null

  isEditing.value = false
}

/* =============================
   儲存
============================= */

async function saveEdit() {
  if (!auth.user || !detail.value || editProductId.value === null) return

  // ⭐ 前端防護驗證
  if (!validateQuantity(editQuantity.value)) {
    alert('購買數量必須為整數且最小為1')
    return
  }

  if (!validateAccount(editAccount.value)) {
    alert('扣款帳號必須為10~17位數字')
    return
  }

  try {
    await updateLikeListApi(
      auth.user.userId,
      detail.value.id,
      editProductId.value,
      editQuantity.value,
      editAccount.value
    )

    await likeListStore.fetchLikeList()

    detail.value = likeListStore.items.find(
      item => Number(item.id) === Number(detail.value.id)
    )

    if (detail.value) {
      editQuantity.value = detail.value.purchaseQuantity
      editAccount.value = detail.value.account

      const product = productStore.products.find(
        product => product.productName === detail.value.productName
      )

      editProductId.value = product?.id ?? null
    }

    isEditing.value = false
    alert('更新成功，已刷新清單！')

  } catch (err) {
    let msg = '未知錯誤'

    if (axios.isAxiosError(err)) {
      
      msg = err.response?.data?.message || msg
    }

    alert('更新失敗: ' + msg)
  }
}

/* =============================
   刪除
============================= */

async function deleteItem() {
  if (!auth.user || !detail.value) return

  if (!confirm('確定要刪除這筆喜愛商品嗎？')) return

  try {
    await deleteLikeListApi(
      auth.user.userId,
      detail.value.id
    )

    likeListStore.items = likeListStore.items.filter(
      item => item.id !== detail.value.id
    )

    alert('刪除成功')
    router.push('/likelist')

  } catch (err) {
    console.error(err)
    alert('刪除失敗')
  }
}
</script>

<template>
  <div v-if="detail" class="detail-card">
    <h2 class="title">喜愛商品詳情</h2>

    <div class="field">
      <span class="label">SN:</span>
      <span class="value">{{ detail.sn }}</span>
    </div>

    <!-- 商品名稱 -->
    <div class="field">
      <span class="label">商品名稱:</span>
      <span class="value">
        <template v-if="isEditing">
          <select v-model="editProductId" class="edit-input">
            <option
              v-for="product in selectableProducts"
              :key="product.id"
              :value="product.id"
            >
              {{ product.productName }}
            </option>
          </select>
        </template>
        <template v-else>
          {{ detail.productName }}
        </template>
      </span>
    </div>

    <!-- 數量 -->
    <div class="field">
      <span class="label">預購買數量:</span>
      <span class="value">
        <template v-if="isEditing">
          <input type="number" v-model.number="editQuantity" min="1" class="edit-input" />
        </template>
        <template v-else>
          {{ detail.purchaseQuantity }}
        </template>
      </span>
    </div>

    <!-- 手續費 -->
    <div class="field">
      <span class="label">預計手續費:</span>
      <span class="value">{{ formatFee(detail.totalFee) }}</span>
    </div>

    <!-- 總金額 -->
    <div class="field">
      <span class="label">預計總金額:</span>
      <span class="value">{{ formatAmount(detail.totalAmount) }}</span>
    </div>

    <!-- 信箱 -->
    <div class="field">
      <span class="label">使用者聯絡信箱:</span>
      <span class="value">{{ detail.email }}</span>
    </div>

    <!-- 扣款帳號 -->
    <div class="field">
      <span class="label">預計扣款帳號:</span>
      <span class="value">
        <template v-if="isEditing">
          <input type="text" v-model="editAccount" maxlength="17" class="edit-input" />
        </template>
        <template v-else>
          ({{ bankCode }}) {{ accountNumber }}
        </template>
      </span>
    </div>

    <!-- 按鈕 -->
    <div class="button-group">
      <button v-if="!isEditing" @click="startEdit" class="edit-btn">編輯</button>
      <button v-if="isEditing" @click="saveEdit" class="save-btn">儲存</button>
      <button @click="deleteItem" class="delete-btn">刪除</button>
      <button v-if="isEditing" @click="cancelEdit" class="cancel-btn">取消</button>
    </div>
  </div>
</template>

<style scoped>
.detail-card {
  max-width: 500px;
  margin: 50px auto;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.12);
  background-color: #fff;
  font-family: Arial, sans-serif;
}

.title {
  text-align: center;
  font-size: 1.8rem;
  margin-bottom: 1.5rem;
  color: #333;
  font-weight: bold;
}

.field {
  display: flex;
  justify-content: space-between;
  padding: 0.5rem 0;
  border-bottom: 1px solid #eee;
}

.label {
  font-weight: 600;
  color: #555;
}

.value {
  font-weight: 500;
  color: #222;
}

.edit-input {
  width: 160px;
  padding: 0.3rem 0.5rem;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.button-group {
  margin-top: 1.5rem;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

button {
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-weight: 500;
  transition: 0.2s;
}

.edit-btn {
  background-color: #3498db;
  color: white;
}

.save-btn {
  background-color: #2ecc71;
  color: white;
}

.cancel-btn {
  background-color: #95a5a6;
  color: white;
}

.delete-btn {
  background-color: #e74c3c;
  color: white;
}

.delete-btn:hover {
  background-color: #c0392b;
  transform: scale(1.05);
}
</style>