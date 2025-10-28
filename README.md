# 📘 Sistema de Gestión de Restaurantes
**Documento de Requerimientos Funcionales**  
**Fecha:** Octubre 2025

---

## 1. Objetivo

El sistema busca **digitalizar y modernizar la administración de restaurantes**, ofreciendo control total sobre ventas, inventario, pedidos, clientes, proveedores y sucursales en tiempo real.

La meta principal es **agilizar la operación diaria, reducir errores humanos y centralizar la información** para que los administradores tomen decisiones basadas en datos precisos.

---

## 2. Componentes del Sistema

- **Módulo de Ventas (Empleados):**  
  Interfaz para meseros y cajeros, disponible en tablets o computadoras, diseñada para registrar pedidos, enviar comandas a cocina, aplicar descuentos y cobrar al cliente.  
  - Interfaz táctil.  
  - Soporte para múltiples mesas o pedidos simultáneos.  
  - Sincronización con cocina y barra.

- **Panel de Administración (Administradores):**  
  Área de control general que permite supervisar ventas, inventarios, reportes, empleados y finanzas.  
  - Módulos de reportes, control de caja, compras, proveedores y análisis financiero.  
  - Enfoque en visualización de métricas en tiempo real y generación de reportes automáticos.

---

## 3. Roles y Permisos

### 3.1. Empleado (Mesero, Cajero, Cocinero, Repartidor)
Podrán:
- Registrar pedidos y enviarlos a cocina/bar.  
- Abrir y cerrar caja.  
- Dividir cuentas entre clientes o mesas.  
- Aplicar descuentos autorizados.  
- Ver inventario limitado de insumos.  
- Recibir propinas digitales (SINPE, tarjeta, efectivo).

### 3.2. Administrador
Podrá:
- Configurar precios, menús, categorías y combos.  
- Controlar todas las sucursales.  
- Registrar nuevos empleados, roles y permisos.  
- Revisar reportes, cierres de caja y estados financieros.  
- Administrar proveedores, compras y facturación electrónica.

---

## 4. Funcionalidades del Sistema de Ventas (Empleados)

### 4.1. Registro de Pedidos y Ventas
- Creación de pedidos por **mesa, cliente o para llevar**.  
- Envío automático de comandas a cocina/bar.  
- Soporte para combos, promociones, menús del día o platillos personalizados.  
- Clasificación por tipo (entrada, plato fuerte, bebida, postre, etc.).  
- Ventas en colones y dólares.

### 4.2. Gestión de Dinero en Caja
- Apertura y cierre de caja con registro de efectivo inicial y final.  
- Control de ingresos y egresos.  
- Registro de propinas (manual o automático).  
- Múltiples cajas por sucursal (bar, restaurante, delivery).

### 4.3. Métodos de Pago
- Efectivo, tarjeta, SINPE móvil, transferencia o combinación de métodos.  
- División de cuenta por cliente o grupo.  
- Registro de pagos parciales o créditos autorizados.

### 4.4. Clientes y Descuentos
- Registro de clientes frecuentes o corporativos.  
- Programas de fidelidad (puntos, descuentos).  
- Descuentos automáticos por hora feliz o promociones activas.  
- Cuentas abiertas para consumo prolongado.

### 4.5. Comandas y Flujo de Restaurante
- Generación automática de comandas digitales.  
- Visualización en pantallas de cocina o impresoras térmicas.  
- Estados de pedido: *Pendiente → En preparación → Listo → Entregado*.  
- Control de tiempos promedio de servicio.

### 4.6. Facturación y Envío
- Factura electrónica integrada con Hacienda (XML).  
- Envío automático al correo o WhatsApp del cliente.  
- Notas de crédito y devoluciones gestionadas por administrador.

### 4.7. Inventario en Tiempo Real
- Actualización automática por cada venta o consumo.  
- Alertas de bajo stock y caducidad próxima.  
- Transferencia de productos entre sucursales.  
- Control de insumos (ej. gramos de carne, unidades de bebida).

### 4.8. Modo Offline
- Operación sin conexión a internet.  
- Sincronización automática al reconectarse.

---

## 5. Panel de Administración (Administradores)

### 5.1. Dashboard en Tiempo Real
- Ventas por hora, categoría o empleado.  
- Niveles de stock.  
- Flujo de caja.  
- Clientes recurrentes y desempeño de meseros.

### 5.2. Reportes Avanzados
- Ventas por fecha, plato, sucursal o mesero.  
- Reportes de costos e ingresos.  
- Exportación en PDF o Excel.

### 5.3. Gestión Financiera y Cajas
- Registro de ingresos, egresos y propinas.  
- Conciliación automática con bancos o SINPE.  
- Balance por sucursal o consolidado.

### 5.4. Gestión de Proveedores y Compras
- Registro y contacto de proveedores.  
- Órdenes de compra automáticas según stock mínimo.  
- Importación de facturas XML para integración con Hacienda.

### 5.5. Facturación Electrónica
- Generación y envío de facturas electrónicas.  
- Recepción y aceptación de comprobantes.  
- Clasificación CABYS e impuestos por servicio.

### 5.6. Seguridad y Copias de Respaldo
- Control de acceso por roles.  
- Historial completo de movimientos.  
- Copias automáticas en la nube (diarias o semanales).

---

## 6. Requerimientos Adicionales a Considerar

| Categoría | Descripción |
|------------|-------------|
| **Multisucursal** | Cada restaurante podrá operar de forma independiente, pero reportar a un panel central. |
| **Accesibilidad** | Compatible con tablets Android y navegadores modernos. |
| **Notificaciones** | Alertas por ventas altas, bajo inventario o fallas en facturación. |
| **Integraciones futuras** | Apps de delivery, reservas en línea, menú QR y BI (Business Intelligence). |
| **Privacidad** | Cumplimiento de Ley 8968 (Protección de Datos Personales en Costa Rica). |
| **Escalabilidad** | Arquitectura basada en microservicios o Supabase + Kubernetes. |

---

## 7. Resumen General

✅ Control de ventas, mesas y comandas.  
✅ Gestión de caja, inventario y proveedores.  
✅ Facturación electrónica integrada.  
✅ Dashboard en tiempo real y reportes descargables.  
✅ Operación offline y soporte multimoneda.  
✅ Diseño adaptable y seguro.

---

## 🔑 En resumen

Para adaptar el sistema a **restaurantes**, debés tener en cuenta:

- Reemplazar la lógica de combos fijos (pollos) por **platillos dinámicos, menús del día y comandas por mesa**.  
- Agregar **gestión de tiempos y estados de pedidos.**  
- Considerar **propinas, reservas, delivery** y **multicaja (bar + restaurante + cocina)**.  
- Incluir **roles nuevos**: mesero, cocinero, administrador general.  
- Fortalecer el **inventario por insumo (no por producto final)**.  
- Añadir integración con **facturación electrónica**, **SINPE**, y **menús QR.**
