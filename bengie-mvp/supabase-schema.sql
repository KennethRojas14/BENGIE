-- ====================================
-- ESQUEMA DE BASE DE DATOS BENGIE MVP
-- ====================================

-- Extensiones necesarias
create extension if not exists "uuid-ossp";

-- ====================================
-- 1. TABLA DE USUARIOS/EMPLEADOS
-- ====================================
create table public.profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text unique not null,
  name text not null,
  role text not null check (role in ('admin', 'employee')) default 'employee',
  restaurant_id uuid,
  phone text,
  is_active boolean default true,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================
-- 2. TABLA DE RESTAURANTES/SUCURSALES
-- ====================================
create table public.restaurants (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  address text,
  phone text,
  email text,
  tax_id text, -- cédula jurídica
  is_active boolean default true,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================
-- 3. TABLA DE CATEGORÍAS DE PRODUCTOS
-- ====================================
create table public.categories (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  description text,
  restaurant_id uuid references public.restaurants(id) on delete cascade,
  is_active boolean default true,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================
-- 4. TABLA DE PRODUCTOS
-- ====================================
create table public.products (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  description text,
  price decimal(10,2) not null,
  cost decimal(10,2), -- costo del producto
  category_id uuid references public.categories(id) on delete set null,
  restaurant_id uuid references public.restaurants(id) on delete cascade,
  sku text, -- código del producto
  image_url text,
  is_active boolean default true,
  stock_quantity integer default 0,
  min_stock integer default 0, -- stock mínimo para alertas
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================
-- 5. TABLA DE PEDIDOS
-- ====================================
create table public.orders (
  id uuid default uuid_generate_v4() primary key,
  order_number text not null, -- número de orden (ej: ORD-001)
  table_number integer,
  customer_name text,
  customer_phone text,
  customer_email text,
  subtotal decimal(10,2) not null default 0,
  tax_amount decimal(10,2) not null default 0,
  discount_amount decimal(10,2) not null default 0,
  total decimal(10,2) not null default 0,
  status text not null check (status in ('pending', 'preparing', 'ready', 'completed', 'cancelled')) default 'pending',
  payment_status text check (payment_status in ('pending', 'partial', 'paid', 'refunded')) default 'pending',
  payment_method text check (payment_method in ('cash', 'card', 'sinpe', 'transfer', 'mixed')),
  employee_id uuid references public.profiles(id) on delete set null,
  restaurant_id uuid references public.restaurants(id) on delete cascade,
  notes text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null,
  completed_at timestamp with time zone
);

-- ====================================
-- 6. TABLA DE ITEMS DE PEDIDOS
-- ====================================
create table public.order_items (
  id uuid default uuid_generate_v4() primary key,
  order_id uuid references public.orders(id) on delete cascade not null,
  product_id uuid references public.products(id) on delete restrict not null,
  quantity integer not null check (quantity > 0),
  unit_price decimal(10,2) not null,
  total_price decimal(10,2) not null,
  special_instructions text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================
-- 7. TABLA DE PAGOS
-- ====================================
create table public.payments (
  id uuid default uuid_generate_v4() primary key,
  order_id uuid references public.orders(id) on delete cascade not null,
  amount decimal(10,2) not null,
  payment_method text not null check (payment_method in ('cash', 'card', 'sinpe', 'transfer')),
  reference_number text, -- número de referencia del pago
  notes text,
  processed_by uuid references public.profiles(id) on delete set null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================
-- 8. TABLA DE CAJA
-- ====================================
create table public.cash_registers (
  id uuid default uuid_generate_v4() primary key,
  name text not null, -- ej: "Caja Principal", "Caja Bar"
  restaurant_id uuid references public.restaurants(id) on delete cascade,
  opened_by uuid references public.profiles(id) on delete set null,
  closed_by uuid references public.profiles(id) on delete set null,
  opening_amount decimal(10,2) not null default 0,
  closing_amount decimal(10,2),
  expected_amount decimal(10,2),
  difference_amount decimal(10,2),
  status text check (status in ('open', 'closed')) default 'closed',
  opened_at timestamp with time zone,
  closed_at timestamp with time zone,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================
-- ÍNDICES PARA MEJORAR PERFORMANCE
-- ====================================
create index idx_profiles_restaurant_id on public.profiles(restaurant_id);
create index idx_profiles_role on public.profiles(role);
create index idx_products_restaurant_id on public.products(restaurant_id);
create index idx_products_category_id on public.products(category_id);
create index idx_products_active on public.products(is_active);
create index idx_orders_restaurant_id on public.orders(restaurant_id);
create index idx_orders_status on public.orders(status);
create index idx_orders_employee_id on public.orders(employee_id);
create index idx_orders_created_at on public.orders(created_at);
create index idx_order_items_order_id on public.order_items(order_id);
create index idx_order_items_product_id on public.order_items(product_id);
create index idx_payments_order_id on public.payments(order_id);

-- ====================================
-- ROW LEVEL SECURITY (RLS)
-- ====================================

-- Habilitar RLS en las tablas
alter table public.profiles enable row level security;
alter table public.restaurants enable row level security;
alter table public.categories enable row level security;
alter table public.products enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.payments enable row level security;
alter table public.cash_registers enable row level security;

-- Políticas para profiles
create policy "Users can view own profile" on public.profiles
  for select using (auth.uid() = id);

create policy "Users can update own profile" on public.profiles
  for update using (auth.uid() = id);

-- Políticas para restaurants (solo admins pueden crear/modificar)
create policy "Users can view restaurants" on public.restaurants
  for select using (true);

-- Políticas para productos (empleados pueden ver, admins pueden modificar)
create policy "Users can view products" on public.products
  for select using (true);

-- Políticas para pedidos (empleados solo ven pedidos de su restaurante)
create policy "Employees can view restaurant orders" on public.orders
  for select using (
    restaurant_id in (
      select restaurant_id from public.profiles 
      where id = auth.uid()
    )
  );

create policy "Employees can create orders" on public.orders
  for insert with check (
    restaurant_id in (
      select restaurant_id from public.profiles 
      where id = auth.uid()
    )
  );

create policy "Employees can update orders" on public.orders
  for update using (
    restaurant_id in (
      select restaurant_id from public.profiles 
      where id = auth.uid()
    )
  );

-- Políticas similares para order_items y payments
create policy "Users can view order items" on public.order_items
  for select using (
    order_id in (
      select id from public.orders 
      where restaurant_id in (
        select restaurant_id from public.profiles 
        where id = auth.uid()
      )
    )
  );

create policy "Users can create order items" on public.order_items
  for insert with check (
    order_id in (
      select id from public.orders 
      where restaurant_id in (
        select restaurant_id from public.profiles 
        where id = auth.uid()
      )
    )
  );

-- ====================================
-- FUNCIONES Y TRIGGERS
-- ====================================

-- Función para actualizar updated_at automáticamente
create or replace function update_updated_at_column()
returns trigger as $$
begin
  new.updated_at = timezone('utc'::text, now());
  return new;
end;
$$ language plpgsql;

-- Triggers para updated_at
create trigger update_profiles_updated_at before update on public.profiles
  for each row execute function update_updated_at_column();

create trigger update_restaurants_updated_at before update on public.restaurants
  for each row execute function update_updated_at_column();

create trigger update_categories_updated_at before update on public.categories
  for each row execute function update_updated_at_column();

create trigger update_products_updated_at before update on public.products
  for each row execute function update_updated_at_column();

create trigger update_orders_updated_at before update on public.orders
  for each row execute function update_updated_at_column();

-- Función para crear perfil automáticamente cuando se registra un usuario
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email, name, role)
  values (new.id, new.email, coalesce(new.raw_user_meta_data->>'name', split_part(new.email, '@', 1)), 'employee');
  return new;
end;
$$ language plpgsql security definer;

-- Trigger para crear perfil automáticamente
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Función para calcular total del pedido
create or replace function calculate_order_total(order_uuid uuid)
returns void as $$
declare
  calculated_subtotal decimal(10,2);
  calculated_total decimal(10,2);
begin
  -- Calcular subtotal sumando los items
  select coalesce(sum(total_price), 0) into calculated_subtotal
  from public.order_items
  where order_id = order_uuid;
  
  -- Por ahora el total es igual al subtotal (sin impuestos ni descuentos)
  calculated_total := calculated_subtotal;
  
  -- Actualizar el pedido
  update public.orders
  set 
    subtotal = calculated_subtotal,
    total = calculated_total,
    updated_at = timezone('utc'::text, now())
  where id = order_uuid;
end;
$$ language plpgsql;

-- Trigger para recalcular total cuando se modifican items
create or replace function recalculate_order_total()
returns trigger as $$
begin
  if TG_OP = 'DELETE' then
    perform calculate_order_total(old.order_id);
    return old;
  else
    perform calculate_order_total(new.order_id);
    return new;
  end if;
end;
$$ language plpgsql;

create trigger recalculate_total_on_item_change
  after insert or update or delete on public.order_items
  for each row execute function recalculate_order_total();