# 🍽️ BENGIE MVP - Sistema de Gestión de Restaurantes

Este es el MVP (Producto Mínimo Viable) del sistema BENGIE para probar las funcionalidades básicas.

## 🚀 Funcionalidades Implementadas

### ✅ Autenticación Básica
- Login con email y contraseña
- Diferenciación de roles (Admin/Empleado)
- Logout seguro

### ✅ Panel de Administración
- Dashboard con métricas básicas (simuladas)
- Vista de ventas del día
- Acciones rápidas para funciones futuras

### ✅ Punto de Venta (POS)
- Interfaz para empleados
- Menú de productos básicos
- Carrito de pedidos
- Cálculo de totales

## 🛠️ Tecnologías Utilizadas

- **Frontend:** Next.js 14 + TypeScript
- **Styling:** Tailwind CSS
- **Backend:** Supabase (configuración pendiente)
- **Autenticación:** Supabase Auth

## 📋 Configuración

### 1. Instalar dependencias
```bash
npm install
```

### 2. Configurar Supabase
1. Crea un proyecto en [supabase.io](https://supabase.io)
2. Copia las credenciales en `.env.local`:

```env
NEXT_PUBLIC_SUPABASE_URL=tu_url_de_supabase
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_anon_key
SUPABASE_SERVICE_ROLE_KEY=tu_service_role_key
```

### 3. Ejecutar el proyecto
```bash
npm run dev
```

El proyecto estará disponible en [http://localhost:3000](http://localhost:3000)

## 👤 Credenciales de Demo

Por ahora, el sistema funciona sin base de datos real. Puedes usar cualquier email/contraseña para probar:

- **Admin:** cualquier email que contenga "admin"
- **Empleado:** cualquier otro email
- **Contraseña:** cualquier contraseña

## 🎯 Próximos Pasos

1. ✅ ~~Estructura básica del proyecto~~
2. 🔄 Configurar base de datos en Supabase
3. ⏳ Implementar CRUD de productos
4. ⏳ Sistema de pedidos real
5. ⏳ Procesamiento de pagos básico
6. ⏳ Reportes simples

## 📁 Estructura del Proyecto

```
src/
├── app/
│   ├── page.tsx              # Página de login
│   └── dashboard/
│       └── page.tsx          # Dashboard principal
├── lib/
│   └── supabase/
│       ├── client.ts         # Cliente Supabase
│       └── server.ts         # Servidor Supabase
└── types/
    └── index.ts              # Tipos TypeScript
```

## 🤝 Cómo Contribuir

1. Clona el repositorio
2. Crea una rama para tu feature: `git checkout -b feature/nueva-funcionalidad`
3. Realiza tus cambios y confirma: `git commit -m 'Agrega nueva funcionalidad'`
4. Sube tus cambios: `git push origin feature/nueva-funcionalidad`
5. Abre un Pull Request

---

**Estado:** 🟡 MVP en desarrollo
**Versión:** 0.1.0
**Última actualización:** Octubre 2025
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
