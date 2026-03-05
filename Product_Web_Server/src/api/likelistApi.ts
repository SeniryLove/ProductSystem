import axios from '@/utils/axios'

// 取得某使用者所有喜愛清單
export const getLikeListApi = async (userId: string | number) => {
  const res = await axios.get(`/users/${userId}/favorites`)
  return res.data
}

// 取得單一喜愛清單詳細資訊
export const getLikeListDetailApi = async (userId: string | number, likelistId: string | number) => {
  const res = await axios.get(`/users/${userId}/favorites/${likelistId}`)
  return res.data
}

// 新增喜愛清單
export const addLikeListApi = async (userId: string | number, productId: number, purchaseQuantity: number) => {
  const res = await axios.post(`/users/${userId}/favorites`, { productId, purchaseQuantity })
  return res.data
}

// 刪除喜愛清單項目
export const deleteLikeListApi = async (userId: string | number, likelistId: string | number) => {
  const res = await axios.delete(`/users/${userId}/favorites/${likelistId}`)
  return res.data
}

// 新增喜愛清單
export const updateLikeListApi = async (userId: string | number, likelistId: string|number, productId: number, purchaseQuantity: number, account: string) => {
  const res = await axios.put(`/users/${userId}/favorites/${likelistId}`, { productId, purchaseQuantity, account})
  return res.data
}