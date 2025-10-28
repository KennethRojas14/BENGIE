# 🗄️ Configuración de Supabase para BENGIE MVP

## 📋 Pasos para Configurar la Base de Datos

### 1. Crear Proyecto en Supabase

1. Ve a [supabase.io](https://supabase.io) y crea una cuenta
2. Crea un nuevo proyecto
3. Elige un nombre (ej: "bengie-mvp")
4. Elige una región cercana (ej: "South America")
5. Genera una contraseña segura para la base de datos

### 2. Ejecutar el Schema

1. Ve a tu proyecto Supabase → **SQL Editor**
2. Copia todo el contenido de `supabase-schema.sql`
3. Pégalo en el editor SQL y ejecuta (botón "RUN")
4. Verifica que no haya errores

### 3. Insertar Datos de Ejemplo

1. En el mismo **SQL Editor**
2. Copia todo el contenido de `supabase-data.sql`
3. Pégalo en una nueva consulta y ejecuta
4. Verifica que los datos se insertaron correctamente

### 4. Configurar Variables de Entorno

1. En tu proyecto Supabase → **Settings** → **API**
2. Copia las siguientes credenciales:
   - `Project URL`
   - `anon public key`
   - `service_role key` (solo si es necesario)

3. Actualiza tu archivo `.env.local`:

```env
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_anon_key_aqui
SUPABASE_SERVICE_ROLE_KEY=tu_service_role_key_aqui
```

### 5. Crear Usuarios de Prueba

#### Opción A: Desde la interfaz de Supabase
1. Ve a **Authentication** → **Users**
2. Crea usuarios manualmente:
   - Email: `admin@bengie.com`, Password: `123456`
   - Email: `empleado@bengie.com`, Password: `123456`

#### Opción B: Desde tu aplicación
1. Inicia tu aplicación: `npm run dev`
2. Ve a [http://localhost:3000](http://localhost:3000)
3. Los usuarios se crearán automáticamente al registrarse

### 6. Verificar Configuración

Ejecuta estas consultas en **SQL Editor** para verificar:

```sql
-- Verificar tablas creadas
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

-- Verificar productos
SELECT p.name, p.price, c.name as categoria 
FROM products p
JOIN categories c ON p.category_id = c.id
ORDER BY c.name, p.name;

-- Verificar pedidos
SELECT order_number, table_number, status, total 
FROM orders 
ORDER BY created_at DESC;
```

## 🔧 Solución de Problemas Comunes

### Error: "Invalid supabaseUrl"
- Verifica que `NEXT_PUBLIC_SUPABASE_URL` esté correctamente configurado
- No debe tener espacios ni caracteres extra
- Debe incluir `https://`

### Error: "Invalid API Key"
- Verifica que `NEXT_PUBLIC_SUPABASE_ANON_KEY` sea correcto
- Copia la key completa sin espacios

### Error de Permisos (RLS)
- Las políticas RLS están configuradas automáticamente
- Los usuarios solo ven datos de su restaurante
- Admins tienen permisos completos

### Error al Insertar Datos
- Ejecuta primero `supabase-schema.sql`
- Luego ejecuta `supabase-data.sql`
- Verifica que no haya conflictos de UUIDs

## 📊 Estructura de Datos Creada

### Tablas Principales:
- **restaurants**: Sucursales/restaurantes
- **profiles**: Usuarios/empleados  
- **categories**: Categorías de productos
- **products**: Menú de productos
- **orders**: Pedidos
- **order_items**: Items de cada pedido
- **payments**: Pagos procesados
- **cash_registers**: Control de caja

### Datos de Ejemplo:
- ✅ 1 Restaurante demo
- ✅ 4 Categorías (Entradas, Platos Fuertes, Bebidas, Postres)
- ✅ 17 Productos del menú
- ✅ 3 Pedidos de ejemplo con diferentes estados
- ✅ Perfiles para admin y empleado

## 🚀 Próximos Pasos

Una vez configurado Supabase:

1. ✅ Reinicia tu aplicación: `npm run dev`
2. ✅ Prueba el login con usuarios demo
3. ✅ Verifica que los productos aparezcan en el POS
4. ✅ Crea un pedido de prueba
5. ✅ Revisa el dashboard de admin

## 📞 Soporte

Si tienes problemas:
1. Revisa los logs en la consola del navegador
2. Verifica la configuración en Supabase → **Settings** → **API**
3. Confirma que las variables de entorno estén bien configuradas
4. Reinicia el servidor de desarrollo

---

**¡Tu base de datos BENGIE MVP está lista para usar!** 🎉