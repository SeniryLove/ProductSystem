<script setup lang="ts">
import { onMounted } from 'vue'
import { useProductStore } from '@/stores/productStore'
import { useRouter } from 'vue-router'

const store = useProductStore()
const router = useRouter()

onMounted(() => {
  store.fetchProducts()
})

function goDetail(id: number) {
  router.push(`/product/${id}`)
}
</script>

<template>
  <div class="product-page">
    <h2 class="title">所有商品</h2>

    <div class="product-list">
      <div class="product-card" v-for="p in store.products" :key="p.id">
        <div class="product-info">
          <p class="product-no">No: {{ p.no }}</p>
          <p class="product-name">{{ p.productName }}</p>
        </div>
        <button class="detail-btn" @click="goDetail(p.id)">查看</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.product-page {
  max-width: 900px;
  margin: 50px auto;
  padding: 0 1rem;
  font-family: Arial, sans-serif;
}

.title {
  text-align: center;
  font-size: 2rem;
  margin-bottom: 2rem;
  color: #333;
}

.product-list {
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;
  justify-content: center;
}

.product-card {
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  padding: 1rem 1.2rem;
  width: 220px;
  display: flex;
  flex-direction: column;
  align-items: center;
  transition: transform 0.2s, box-shadow 0.2s;
}

.product-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

.product-info {
  text-align: center;
  margin-bottom: 1rem;
}

.product-no {
  font-size: 0.9rem;
  color: #666;
}

.product-name {
  font-size: 1.2rem;
  font-weight: bold;
  color: #222;
  margin-top: 0.3rem;
}

.detail-btn {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  font-size: 0.95rem;
  border-radius: 5px;
  cursor: pointer;
  transition: 0.3s;
}

.detail-btn:hover {
  background-color: #45a049;
}
</style>