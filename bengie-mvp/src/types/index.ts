export interface User {
  id: string
  email: string
  role: 'admin' | 'employee'
  name: string
  restaurant_id?: string
}

export interface Product {
  id: string
  name: string
  price: number
  category: string
  available: boolean
  created_at: string
}

export interface OrderItem {
  id: string
  product_id: string
  quantity: number
  price: number
  product?: Product
}

export interface Order {
  id: string
  table_number?: number
  total: number
  status: 'pending' | 'preparing' | 'ready' | 'completed' | 'cancelled'
  items: OrderItem[]
  employee_id: string
  created_at: string
  updated_at: string
}

export interface Restaurant {
  id: string
  name: string
  address: string
  phone: string
  created_at: string
}