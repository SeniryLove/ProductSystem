<script setup lang="ts">
import NavMenu from '@/components/NavMenu.vue'
</script>

<template>
  <div>
    <NavMenu />

    <section>
      <router-view />
    </section>
  </div>
</template>