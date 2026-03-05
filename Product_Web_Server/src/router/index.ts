import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/authStore'

import MainLayout from '@/layouts/MainLayout.vue'
import ProductView from '@/views/ProductView.vue'
import ProductDetailView from '@/views/ProductDetailView.vue'
import LikeListView from '@/views/LikeListView.vue'
import LikeListDetailView from '@/views/LikeListDetailView.vue'
import LoginView from '@/views/LoginView.vue'
import RegisterView from '@/views/RegisterView.vue'

const routes = [
  {
    path: '/',
    component: MainLayout,
    children: [
      {
        path: '',
        name: 'Products',
        component: ProductView
      },
      {
        path: 'product/:productId',
        name: 'ProductDetail',
        component: ProductDetailView,
        props: true
      },
      {
        path: 'likelist',
        name: 'LikeList',
        component: LikeListView
      },
      {
        path: 'likelist/:likelistId',
        name: 'LikeListDetail',
        component: LikeListDetailView,
        props: true
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: LoginView
  },
  {
    path: '/register',
    name: 'Register',
    component: RegisterView
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

/**
 * Router Guard
 */
router.beforeEach((to, _, next) => {
  const auth = useAuthStore()

  // 喜愛清單需要登入
  if (to.path.startsWith('/likelist') && !auth.isAuthenticated) {
    next('/login')
  } else {
    next()
  }
})

export default router

