<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <!-- App 根結構 -->
  <div id="app">
    <!-- router-view 會顯示 MainLayout 或 Login/Register -->
    <RouterView />
  </div>
</template>

<style>
/* 全域重置或基礎樣式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: Arial, Helvetica, sans-serif;
  background-color: #f0f2f5;
  color: #333;
}

#app {
  min-height: 100vh;
}
</style>