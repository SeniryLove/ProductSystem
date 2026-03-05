import { defineStore } from 'pinia'
import { getProductsApi } from '@/api/productApi'

export const useProductStore = defineStore('product', {
  state: () => ({
    products: [] as any[]
  }),

  actions: {
    async fetchProducts() {
      const res = await getProductsApi()
      this.products = res.data
    }
  }
})