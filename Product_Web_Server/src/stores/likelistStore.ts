import { defineStore } from 'pinia'
import { getLikeListApi } from '@/api/likelistApi'
import { useAuthStore } from '@/stores/authStore'

export const useLikeListStore = defineStore('likelist', {
  state: () => ({
    items: [] as any[]
  }),

  actions: {
    async fetchLikeList() {
      const auth = useAuthStore()
      if (!auth.isAuthenticated) return
      if (auth.user){
        const res = await getLikeListApi(auth.user?.userId)
        this.items = res.data
      }
    }
  }
})