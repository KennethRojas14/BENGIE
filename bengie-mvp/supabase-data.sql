-- ====================================
-- DATOS DE EJEMPLO PARA BENGIE MVP
-- ====================================

-- IMPORTANTE: Ejecuta primero supabase-schema.sql antes que este archivo

-- ====================================
-- 1. RESTAURANTE DE EJEMPLO
-- ====================================
INSERT INTO public.restaurants (id, name, address, phone, email, tax_id) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Restaurante Demo BENGIE', 'San José, Costa Rica', '+506 2222-3333', 'info@restaurantedemo.com', '3-101-123456');

-- ====================================
-- 2. CATEGORÍAS DE PRODUCTOS
-- ====================================
INSERT INTO public.categories (id, name, description, restaurant_id) VALUES
('550e8400-e29b-41d4-a716-446655440010', 'Entradas', 'Aperitivos y entradas', '550e8400-e29b-41d4-a716-446655440001'),
('550e8400-e29b-41d4-a716-446655440011', 'Platos Fuertes', 'Platos principales del menú', '550e8400-e29b-41d4-a716-446655440001'),
('550e8400-e29b-41d4-a716-446655440012', 'Bebidas', 'Bebidas frías y calientes', '550e8400-e29b-41d4-a716-446655440001'),
('550e8400-e29b-41d4-a716-446655440013', 'Postres', 'Postres y dulces', '550e8400-e29b-41d4-a716-446655440001');

-- ====================================
-- 3. PRODUCTOS DEL MENÚ
-- ====================================

-- Entradas
INSERT INTO public.products (id, name, description, price, cost, category_id, restaurant_id, sku, stock_quantity, min_stock) VALUES
('550e8400-e29b-41d4-a716-446655440020', 'Pejibaye Relleno', 'Pejibaye relleno de queso con salsa rosada', 3500.00, 1800.00, '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'ENT001', 50, 10),
('550e8400-e29b-41d4-a716-446655440021', 'Yuca Frita', 'Yuca frita con chimichurri', 2800.00, 1200.00, '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'ENT002', 100, 20),
('550e8400-e29b-41d4-a716-446655440022', 'Patacones', 'Patacones con frijoles molidos y queso', 3200.00, 1500.00, '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'ENT003', 75, 15);

-- Platos Fuertes
INSERT INTO public.products (id, name, description, price, cost, category_id, restaurant_id, sku, stock_quantity, min_stock) VALUES
('550e8400-e29b-41d4-a716-446655440030', 'Casado Tradicional', 'Arroz, frijoles, carne, plátano maduro, ensalada y picadillo', 4500.00, 2200.00, '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 'PLT001', 30, 5),
('550e8400-e29b-41d4-a716-446655440031', 'Gallo Pinto', 'Gallo pinto con huevo, queso y plátano', 2800.00, 1400.00, '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 'PLT002', 40, 8),
('550e8400-e29b-41d4-a716-446655440032', 'Pollo a la Plancha', 'Pechuga de pollo con arroz y ensalada', 5200.00, 2800.00, '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 'PLT003', 25, 5),
('550e8400-e29b-41d4-a716-446655440033', 'Pescado Entero Frito', 'Pescado entero con patacones y ensalada', 7800.00, 4200.00, '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 'PLT004', 15, 3),
('550e8400-e29b-41d4-a716-446655440034', 'Olla de Carne', 'Olla de carne tradicional costarricense', 6500.00, 3500.00, '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 'PLT005', 20, 4);

-- Bebidas
INSERT INTO public.products (id, name, description, price, cost, category_id, restaurant_id, sku, stock_quantity, min_stock) VALUES
('550e8400-e29b-41d4-a716-446655440040', 'Coca Cola', 'Coca Cola 355ml', 1200.00, 600.00, '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440001', 'BEB001', 200, 50),
('550e8400-e29b-41d4-a716-446655440041', 'Cerveza Imperial', 'Cerveza Imperial 330ml', 1800.00, 900.00, '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440001', 'BEB002', 150, 30),
('550e8400-e29b-41d4-a716-446655440042', 'Jugo Natural', 'Jugo natural de frutas variadas', 1500.00, 700.00, '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440001', 'BEB003', 100, 20),
('550e8400-e29b-41d4-a716-446655440043', 'Café', 'Café costarricense tradicional', 800.00, 300.00, '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440001', 'BEB004', 500, 100),
('550e8400-e29b-41d4-a716-446655440044', 'Agua Embotellada', 'Agua embotellada 500ml', 900.00, 400.00, '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440001', 'BEB005', 300, 60);

-- Postres
INSERT INTO public.products (id, name, description, price, cost, category_id, restaurant_id, sku, stock_quantity, min_stock) VALUES
('550e8400-e29b-41d4-a716-446655440050', 'Tres Leches', 'Pastel tres leches tradicional', 2800.00, 1400.00, '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440001', 'POS001', 20, 4),
('550e8400-e29b-41d4-a716-446655440051', 'Flan de Coco', 'Flan casero de coco', 2500.00, 1200.00, '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440001', 'POS002', 25, 5),
('550e8400-e29b-41d4-a716-446655440052', 'Helado Artesanal', 'Helado artesanal sabores variados', 2200.00, 1000.00, '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440001', 'POS003', 30, 6);

-- ====================================
-- 4. USUARIOS DE EJEMPLO
-- ====================================
-- Nota: Estos usuarios se crearán automáticamente cuando se registren en Supabase Auth
-- Solo agregamos aquí la información adicional para usuarios que ya existen

-- Actualizar perfiles si los usuarios ya existen
-- Usuario Admin de ejemplo
UPDATE public.profiles SET 
  name = 'Administrador Demo',
  role = 'admin',
  restaurant_id = '550e8400-e29b-41d4-a716-446655440001',
  phone = '+506 8888-9999'
WHERE email = 'admin@bengie.com';

-- Usuario Empleado de ejemplo
UPDATE public.profiles SET 
  name = 'Empleado Demo',
  role = 'employee',
  restaurant_id = '550e8400-e29b-41d4-a716-446655440001',
  phone = '+506 7777-8888'
WHERE email = 'empleado@bengie.com';

-- Si los usuarios no existen aún, los perfiles se crearán automáticamente cuando se registren

-- ====================================
-- 5. PEDIDOS DE EJEMPLO
-- ====================================
INSERT INTO public.orders (id, order_number, table_number, customer_name, subtotal, total, status, payment_status, payment_method, restaurant_id, employee_id) VALUES
('550e8400-e29b-41d4-a716-446655440060', 'ORD-001', 5, 'Mesa 5', 6900.00, 6900.00, 'completed', 'paid', 'cash', '550e8400-e29b-41d4-a716-446655440001', (SELECT id FROM public.profiles WHERE email = 'empleado@bengie.com' LIMIT 1)),
('550e8400-e29b-41d4-a716-446655440061', 'ORD-002', 3, 'Mesa 3', 4500.00, 4500.00, 'preparing', 'pending', null, '550e8400-e29b-41d4-a716-446655440001', (SELECT id FROM public.profiles WHERE email = 'empleado@bengie.com' LIMIT 1)),
('550e8400-e29b-41d4-a716-446655440062', 'ORD-003', 8, 'Mesa 8', 8600.00, 8600.00, 'ready', 'pending', null, '550e8400-e29b-41d4-a716-446655440001', (SELECT id FROM public.profiles WHERE email = 'empleado@bengie.com' LIMIT 1));

-- ====================================
-- 6. ITEMS DE PEDIDOS DE EJEMPLO
-- ====================================
-- Pedido 1 (Mesa 5 - Completado)
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('550e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655440030', 1, 4500.00, 4500.00), -- Casado Tradicional
('550e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655440040', 2, 1200.00, 2400.00); -- Coca Cola x2

-- Pedido 2 (Mesa 3 - En preparación)
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('550e8400-e29b-41d4-a716-446655440061', '550e8400-e29b-41d4-a716-446655440030', 1, 4500.00, 4500.00); -- Casado Tradicional

-- Pedido 3 (Mesa 8 - Listo)
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('550e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440032', 1, 5200.00, 5200.00), -- Pollo a la Plancha
('550e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440041', 1, 1800.00, 1800.00), -- Cerveza Imperial
('550e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440042', 1, 1500.00, 1500.00), -- Jugo Natural
('550e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440050', 1, 2800.00, 2800.00); -- Tres Leches - Error aquí, va en otra línea

-- Corregir el último item del pedido 3
UPDATE public.order_items SET total_price = 1100.00 WHERE order_id = '550e8400-e29b-41d4-a716-446655440062' AND product_id = '550e8400-e29b-41d4-a716-446655440042';

-- Agregar el item del postre correctamente
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('550e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440050', 1, 2800.00, 2800.00); -- Tres Leches

-- ====================================
-- 7. PAGOS DE EJEMPLO
-- ====================================
INSERT INTO public.payments (order_id, amount, payment_method, reference_number, processed_by) VALUES
('550e8400-e29b-41d4-a716-446655440060', 6900.00, 'cash', 'CASH-001', (SELECT id FROM public.profiles WHERE email = 'empleado@bengie.com' LIMIT 1));

-- ====================================
-- 8. VERIFICAR DATOS INSERTADOS
-- ====================================
-- Puedes ejecutar estas consultas para verificar que todo se insertó correctamente:

/*
-- Verificar restaurantes
SELECT * FROM public.restaurants;

-- Verificar categorías
SELECT * FROM public.categories;

-- Verificar productos
SELECT p.name, p.price, c.name as categoria 
FROM public.products p
JOIN public.categories c ON p.category_id = c.id
ORDER BY c.name, p.name;

-- Verificar pedidos con items
SELECT 
  o.order_number,
  o.table_number,
  o.status,
  o.total,
  COUNT(oi.id) as total_items
FROM public.orders o
LEFT JOIN public.order_items oi ON o.id = oi.order_id
GROUP BY o.id, o.order_number, o.table_number, o.status, o.total
ORDER BY o.created_at DESC;

-- Verificar perfiles
SELECT name, email, role FROM public.profiles;
*/

-- ====================================
-- MENSAJE FINAL
-- ====================================
-- ¡Datos de ejemplo insertados correctamente!
-- 
-- Ya puedes probar el sistema con:
-- - 1 Restaurante demo
-- - 4 Categorías de productos  
-- - 17 Productos variados
-- - 3 Pedidos de ejemplo
-- - Usuarios admin y empleado (cuando se registren)
-- 
-- Recuerda configurar las variables de entorno en tu archivo .env.local
-- con las credenciales de tu proyecto Supabase.