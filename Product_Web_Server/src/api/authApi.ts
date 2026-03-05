import axios from '@/utils/axios'

export const loginApi = async (email: string, nationId: string, password: string) => {
  const res = await axios.post('/auth/login', { 'email': email, 'nationId': nationId, 'password': password })
  return res.data
}

export const registerApi = async (data: any) => {
  const res = await axios.post('/users', data)
  return res.data
}