import { defineStore } from 'pinia'
import { loginApi, registerApi } from '@/api/authApi'

interface User {
  userId: number
  username: string
}

export const useAuthStore = defineStore('auth', {
  state: () => ({
    token: localStorage.getItem('token') || '',
    user: JSON.parse(localStorage.getItem('user') || 'null') as User | null
  }),

  getters: {
    isAuthenticated: (state) => !!state.token
  },

  actions: {
    async login(email: string, nationId: string, password: string) {
      const res = await loginApi(email, nationId, password)
      this.token = res.data.token

      this.user = {
        userId: res.data.id,
        username: res.data.name
      }

      localStorage.setItem('token', this.token)
      localStorage.setItem('user', JSON.stringify(this.user))
    },

    async register(data: any) {
      return (await registerApi(data))?.message
    },

    async logout() {
      this.token = ''
      this.user = null

      localStorage.removeItem('token')
      localStorage.removeItem('user')
    }
  }
})