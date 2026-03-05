import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'

const app = createApp(App)

// Pinia
const pinia = createPinia()
app.use(pinia)

// Router
app.use(router)

// Mount
app.mount('#app')