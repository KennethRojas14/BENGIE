'use client'

import { useEffect, useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { User } from '@/types'
import { useRouter } from 'next/navigation'

export default function Dashboard() {
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)
  const router = useRouter()
  const supabase = createClient()

  useEffect(() => {
    const getUser = async () => {
      const { data: { session } } = await supabase.auth.getSession()
      
      if (!session) {
        router.push('/')
        return
      }

      // For demo purposes, we'll simulate user data
      setUser({
        id: session.user.id,
        email: session.user.email || '',
        role: session.user.email?.includes('admin') ? 'admin' : 'employee',
        name: session.user.email?.split('@')[0] || 'Usuario'
      })
      setLoading(false)
    }

    getUser()
  }, [supabase, router])

  const handleLogout = async () => {
    await supabase.auth.signOut()
    router.push('/')
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-lg">Cargando...</div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-blue-900 to-indigo-900">
      {/* Background decoration */}
      <div className="absolute inset-0 opacity-20">
        <div className="h-full w-full bg-slate-900/20"></div>
      </div>
      
      {/* Header */}
      <header className="relative bg-slate-800/50 backdrop-blur-xl border-b border-slate-700/50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-6">
            <div className="flex items-center space-x-4">
              <div className="h-10 w-10 bg-gradient-to-r from-blue-500 to-purple-600 rounded-xl flex items-center justify-center">
                <span className="text-xl">🍽️</span>
              </div>
              <div>
                <h1 className="text-2xl font-bold text-white">BENGIE</h1>
                <p className="text-sm text-blue-200">Sistema de Gestión Integral</p>
              </div>
              <span className="px-3 py-1 text-xs font-medium bg-gradient-to-r from-blue-500/20 to-purple-500/20 text-blue-200 rounded-full border border-blue-500/30">
                {user?.role === 'admin' ? 'Administrador' : 'Empleado'}
              </span>
            </div>
            <div className="flex items-center space-x-4">
              <div className="text-right">
                <p className="text-sm font-medium text-white">Hola, {user?.name}</p>
                <p className="text-xs text-slate-400">6:27:48 p. m.</p>
              </div>
              <button
                onClick={handleLogout}
                className="bg-gradient-to-r from-red-500 to-red-600 hover:from-red-600 hover:to-red-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200 transform hover:scale-105"
              >
                Cerrar Sesión
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Content */}
      <main className="relative max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <div className="px-4 py-6 sm:px-0">
          {user?.role === 'admin' ? (
            <AdminDashboard />
          ) : (
            <EmployeeDashboard />
          )}
        </div>
      </main>
    </div>
  )
}

function AdminDashboard() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-3xl font-bold text-white">Dashboard Principal</h2>
        <div className="text-right">
          <p className="text-sm text-slate-400">Sistema de Gestión Integral</p>
        </div>
      </div>
      
      {/* Stats Cards */}
      <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
        {/* Miembros Activos */}
        <div className="bg-slate-800/60 backdrop-blur-sm overflow-hidden rounded-2xl border border-slate-700/50 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-slate-400 mb-1">Ventas Hoy</p>
              <p className="text-2xl font-bold text-white">₡125,340</p>
              <p className="text-xs text-green-400 flex items-center mt-1">
                <span className="mr-1">↗</span>
                +12% este mes
              </p>
            </div>
            <div className="h-12 w-12 bg-blue-500/20 rounded-xl flex items-center justify-center">
              <span className="text-xl">💰</span>
            </div>
          </div>
        </div>

        {/* Ingresos del Mes */}
        <div className="bg-slate-800/60 backdrop-blur-sm overflow-hidden rounded-2xl border border-slate-700/50 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-slate-400 mb-1">Pedidos Hoy</p>
              <p className="text-2xl font-bold text-white">23</p>
              <p className="text-xs text-green-400 flex items-center mt-1">
                <span className="mr-1">↗</span>
                +8.2% vs mes anterior
              </p>
            </div>
            <div className="h-12 w-12 bg-green-500/20 rounded-xl flex items-center justify-center">
              <span className="text-xl">📋</span>
            </div>
          </div>
        </div>

        {/* Clases Hoy */}
        <div className="bg-slate-800/60 backdrop-blur-sm overflow-hidden rounded-2xl border border-slate-700/50 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-slate-400 mb-1">Pedidos Activos</p>
              <p className="text-2xl font-bold text-white">8</p>
              <p className="text-xs text-blue-400 flex items-center mt-1">
                <span className="mr-1">↗</span>
                0 en curso
              </p>
            </div>
            <div className="h-12 w-12 bg-purple-500/20 rounded-xl flex items-center justify-center">
              <span className="text-xl">⏱️</span>
            </div>
          </div>
        </div>

        {/* Check-ins Hoy */}
        <div className="bg-slate-800/60 backdrop-blur-sm overflow-hidden rounded-2xl border border-slate-700/50 p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-slate-400 mb-1">Empleados Activos</p>
              <p className="text-2xl font-bold text-white">4</p>
              <p className="text-xs text-orange-400 flex items-center mt-1">
                <span className="mr-1">⚠</span>
                Últimas N/A
              </p>
            </div>
            <div className="h-12 w-12 bg-orange-500/20 rounded-xl flex items-center justify-center">
              <span className="text-xl">👥</span>
            </div>
          </div>
        </div>
      </div>

      {/* Activity and Recent Activity */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Actividad Semanal */}
        <div className="bg-slate-800/60 backdrop-blur-sm rounded-2xl border border-slate-700/50 p-6">
          <div className="flex items-center mb-6">
            <span className="text-blue-400 mr-3">📊</span>
            <h3 className="text-lg font-semibold text-white">Actividad Semanal</h3>
          </div>
          <p className="text-sm text-slate-400 mb-6">Resumen de check-ins y actividad</p>
          
          <div className="space-y-4">
            {[
              { day: 'Lun', amount: 139, width: '85%', color: 'bg-blue-500' },
              { day: 'Mar', amount: 103, width: '60%', color: 'bg-blue-500' },
              { day: 'Mié', amount: 91, width: '55%', color: 'bg-blue-500' },
              { day: 'Jue', amount: 105, width: '65%', color: 'bg-blue-500' },
              { day: 'Vie', amount: 144, width: '90%', color: 'bg-blue-500' },
              { day: 'Sáb', amount: 103, width: '60%', color: 'bg-blue-500' },
              { day: 'Dom', amount: 120, width: '75%', color: 'bg-blue-500' }
            ].map((item) => (
              <div key={item.day} className="flex items-center">
                <span className="text-sm text-slate-400 w-10">{item.day}</span>
                <div className="flex-1 mx-4">
                  <div className="h-2 bg-slate-700 rounded-full overflow-hidden">
                    <div className={`h-full ${item.color} rounded-full`} style={{ width: item.width }}></div>
                  </div>
                </div>
                <span className="text-sm font-medium text-white w-8 text-right">{item.amount}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Actividad Reciente */}
        <div className="bg-slate-800/60 backdrop-blur-sm rounded-2xl border border-slate-700/50 p-6">
          <div className="flex items-center mb-6">
            <span className="text-blue-400 mr-3">⚡</span>
            <h3 className="text-lg font-semibold text-white">Actividad Reciente</h3>
          </div>
          <p className="text-sm text-slate-400 mb-6">Últimas acciones en el sistema</p>
          
          <div className="space-y-4">
            {[
              { icon: '👤', text: 'Nuevo pedido registrado', time: 'hace 2 min', color: 'text-green-400' },
              { icon: '💳', text: 'Pago procesado', time: 'hace 5 min', color: 'text-blue-400' },
              { icon: '📅', text: 'Mesa programada', time: 'hace 8 min', color: 'text-purple-400' },
              { icon: '✅', text: 'Check-in realizado', time: 'hace 12 min', color: 'text-orange-400' },
              { icon: '📊', text: 'Reporte generado', time: 'hace 16 min', color: 'text-pink-400' }
            ].map((activity, index) => (
              <div key={index} className="flex items-center">
                <div className="h-8 w-8 bg-slate-700/50 rounded-lg flex items-center justify-center mr-3">
                  <span className="text-sm">{activity.icon}</span>
                </div>
                <div className="flex-1">
                  <p className="text-sm text-white">{activity.text}</p>
                  <p className={`text-xs ${activity.color}`}>{activity.time}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Acciones Rápidas */}
      <div className="bg-slate-800/60 backdrop-blur-sm rounded-2xl border border-slate-700/50 p-6">
        <div className="flex items-center mb-6">
          <span className="text-blue-400 mr-3">⭐</span>
          <h3 className="text-lg font-semibold text-white">Acciones Rápidas</h3>
        </div>
        <p className="text-sm text-slate-400 mb-6">Funciones más utilizadas del sistema</p>
        
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
          <button className="bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white p-4 rounded-xl text-sm font-medium transition-all duration-200 transform hover:scale-105 flex flex-col items-center space-y-2">
            <span className="text-2xl">👤</span>
            <span>Nuevo Miembro</span>
          </button>
          <button className="bg-gradient-to-r from-green-600 to-green-700 hover:from-green-700 hover:to-green-800 text-white p-4 rounded-xl text-sm font-medium transition-all duration-200 transform hover:scale-105 flex flex-col items-center space-y-2">
            <span className="text-2xl">✅</span>
            <span>Check-in</span>
          </button>
          <button className="bg-gradient-to-r from-purple-600 to-purple-700 hover:from-purple-700 hover:to-purple-800 text-white p-4 rounded-xl text-sm font-medium transition-all duration-200 transform hover:scale-105 flex flex-col items-center space-y-2">
            <span className="text-2xl">📅</span>
            <span>Nueva Clase</span>
          </button>
          <button className="bg-gradient-to-r from-orange-600 to-orange-700 hover:from-orange-700 hover:to-orange-800 text-white p-4 rounded-xl text-sm font-medium transition-all duration-200 transform hover:scale-105 flex flex-col items-center space-y-2">
            <span className="text-2xl">📊</span>
            <span>Reportes</span>
          </button>
        </div>
      </div>
    </div>
  )
}

function EmployeeDashboard() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-3xl font-bold text-white">Punto de Venta</h2>
        <div className="text-right">
          <p className="text-sm text-slate-400">Interfaz de empleado</p>
        </div>
      </div>
      
      {/* POS Interface */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Menu Categories */}
        <div className="lg:col-span-2">
          <div className="bg-slate-800/60 backdrop-blur-sm rounded-2xl border border-slate-700/50 p-6">
            <h3 className="text-lg font-semibold text-white mb-4 flex items-center">
              <span className="mr-3">🍽️</span>
              Menú
            </h3>
            
            {/* Category Tabs */}
            <div className="flex space-x-2 mb-6 overflow-x-auto">
              {['Entradas', 'Platos Fuertes', 'Bebidas', 'Postres'].map((category) => (
                <button
                  key={category}
                  className="px-4 py-2 text-sm font-medium text-slate-300 bg-slate-700/50 hover:bg-slate-600/50 rounded-lg whitespace-nowrap transition-all duration-200 border border-slate-600/50 hover:border-blue-500/50"
                >
                  {category}
                </button>
              ))}
            </div>

            {/* Products Grid */}
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
              {[
                { name: 'Casado Tradicional', price: 4500, available: true },
                { name: 'Gallo Pinto', price: 2800, available: true },
                { name: 'Pollo a la Plancha', price: 5200, available: true },
                { name: 'Pescado Entero', price: 7800, available: false },
                { name: 'Coca Cola', price: 1200, available: true },
                { name: 'Cerveza Imperial', price: 1800, available: true }
              ].map((product) => (
                <button
                  key={product.name}
                  disabled={!product.available}
                  className={`p-4 rounded-xl text-left transition-all duration-200 transform hover:scale-105 ${
                    product.available 
                      ? 'bg-slate-700/50 border border-slate-600/50 hover:border-blue-500/50 hover:bg-slate-600/50' 
                      : 'bg-slate-800/50 border border-slate-700/50 opacity-50 cursor-not-allowed'
                  }`}
                >
                  <div className="font-medium text-white text-sm mb-1">{product.name}</div>
                  <div className="text-sm text-slate-400">₡{product.price.toLocaleString()}</div>
                  {!product.available && (
                    <div className="text-xs text-red-400 mt-1">No disponible</div>
                  )}
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Order Summary */}
        <div className="lg:col-span-1">
          <div className="bg-slate-800/60 backdrop-blur-sm rounded-2xl border border-slate-700/50 p-6 sticky top-6">
            <h3 className="text-lg font-semibold text-white mb-4 flex items-center">
              <span className="mr-3">📋</span>
              Pedido Actual
            </h3>
            
            <div className="space-y-4">
              {/* Mesa info */}
              <div className="flex items-center justify-between">
                <span className="text-sm text-slate-400">Mesa #5</span>
                <span className="px-2 py-1 text-xs bg-blue-500/20 text-blue-300 rounded-full">Activa</span>
              </div>
              
              {/* Order Items */}
              <div className="space-y-3">
                <div className="flex justify-between items-center p-3 bg-slate-700/30 rounded-lg">
                  <div>
                    <div className="text-sm font-medium text-white">Casado Tradicional</div>
                    <div className="text-xs text-slate-400">x1</div>
                  </div>
                  <div className="text-right">
                    <div className="text-sm font-medium text-white">₡4,500</div>
                    <button className="text-xs text-red-400 hover:text-red-300">Eliminar</button>
                  </div>
                </div>
                
                <div className="flex justify-between items-center p-3 bg-slate-700/30 rounded-lg">
                  <div>
                    <div className="text-sm font-medium text-white">Coca Cola</div>
                    <div className="text-xs text-slate-400">x2</div>
                  </div>
                  <div className="text-right">
                    <div className="text-sm font-medium text-white">₡2,400</div>
                    <button className="text-xs text-red-400 hover:text-red-300">Eliminar</button>
                  </div>
                </div>
              </div>

              {/* Totals */}
              <div className="border-t border-slate-600/50 pt-4">
                <div className="flex justify-between text-sm text-slate-400 mb-2">
                  <span>Subtotal:</span>
                  <span>₡6,900</span>
                </div>
                <div className="flex justify-between text-sm text-slate-400 mb-2">
                  <span>Impuestos:</span>
                  <span>₡0</span>
                </div>
                <div className="flex justify-between text-lg font-semibold text-white">
                  <span>Total:</span>
                  <span>₡6,900</span>
                </div>
              </div>

              {/* Action Buttons */}
              <div className="space-y-3 pt-4">
                <button className="w-full bg-gradient-to-r from-green-600 to-green-700 hover:from-green-700 hover:to-green-800 text-white py-3 px-4 rounded-xl text-sm font-medium transition-all duration-200 transform hover:scale-105 flex items-center justify-center">
                  <span className="mr-2">🍳</span>
                  Enviar a Cocina
                </button>
                <button className="w-full bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white py-3 px-4 rounded-xl text-sm font-medium transition-all duration-200 transform hover:scale-105 flex items-center justify-center">
                  <span className="mr-2">💳</span>
                  Procesar Pago
                </button>
                <button className="w-full bg-gradient-to-r from-slate-600 to-slate-700 hover:from-slate-700 hover:to-slate-800 text-white py-3 px-4 rounded-xl text-sm font-medium transition-all duration-200 transform hover:scale-105 flex items-center justify-center">
                  <span className="mr-2">🗑️</span>
                  Limpiar
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}