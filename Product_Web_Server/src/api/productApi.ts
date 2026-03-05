import axios from '@/utils/axios'

// 取得所有產品
export const getProductsApi = async () => {
  const res = await axios.get('/products')
  return res.data
}

// 依 productId 取得單一產品詳細資訊
export const getProductByIdApi = async (productId: string | number) => {
  const res = await axios.get(`/products/${productId}`)
  return res.data
}