<script setup lang="ts">
import { onMounted } from 'vue'
import { useLikeListStore } from '@/stores/likelistStore'
import { useRouter } from 'vue-router'

const store = useLikeListStore()
const router = useRouter()

onMounted(() => {
  store.fetchLikeList()
})

function goDetail(id: number) {
  router.push(`/likelist/${id}`)
}
</script>

<template>
  <div class="likelist-page">
    <h2 class="title">喜愛清單</h2>

    <div class="likelist-container">
      <div class="likelist-card" v-for="item in store.items" :key="item.id">
        <div class="item-info">
          <p><strong>SN:</strong> {{ item.sn }}</p>
          <p><strong>商品名稱:</strong> {{ item.productName }}</p>
          <p><strong>預購買數量:</strong> {{ item.purchaseQuantity }}</p>
        </div>
        <button class="detail-btn" @click="goDetail(item.id)">查看</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.likelist-page {
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

.likelist-container {
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;
  justify-content: center;
}

.likelist-card {
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  padding: 1rem 1.2rem;
  width: 250px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  transition: transform 0.2s, box-shadow 0.2s;
}

.likelist-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

.item-info p {
  margin: 0.3rem 0;
  color: #222;
  font-size: 1rem;
}

.detail-btn {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  font-size: 0.95rem;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 0.8rem;
  transition: 0.3s;
}

.detail-btn:hover {
  background-color: #45a049;
}
</style>