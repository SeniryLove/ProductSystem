import axios from 'axios'
import { useAuthStore } from '@/stores/authStore'

const config = await fetch('/config.json').then(r => r.json())

const instance = axios.create({
  baseURL: config.API_BASE_URL
})

instance.interceptors.request.use((config) => {
  const auth = useAuthStore()

  if (auth.isAuthenticated) {
    config.headers.Authorization = `Bearer ${auth.token}`
  }

  return config
})

export default instance