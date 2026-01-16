# 📦 WBS – Sistema de Gestión de Restaurantes
Versión: 1.0 – Octubre 2025  
Estructura tipo README.md / REQADME

---

# 1. Iniciación del Proyecto
## 1.1 Definición del Alcance
## 1.1.1 Identificación de procesos del restaurante
### Mapeo de flujo
Documentar el **viaje completo del cliente**, incluyendo:
- Llegada al restaurante o llamada para pedido.
- Asignación de mesa o toma de pedido.
- Registro de productos.
- Preparación en cocina/bar.
- Entrega del pedido.
- Pago y facturación electrónica.
- Salida del cliente.

### Procesos a tener en cuenta
Definir con detalle:
- **Manejo de fila de espera** (lista de mesas).
- **Cambio de turno de quien esté trabajando** (transferencia de mesas activas).

## 1.1.2 Definición de módulos y componentes
### Frontend
- **App para Tablets (La persona que esté trabajando)**
- **Dashboard Web (Administradores)**
- **KDS – Kitchen Display System (Pantalla de Cocina)**
El Kitchen Display System es una aplicación específica para **cocina y barra**, diseñada para reemplazar las comandas en papel y mostrar en tiempo real los pedidos que deben prepararse.

#### 1. Recepción de Comandas en Tiempo Real
- Mostrar inmediatamente cualquier pedido enviado desde la App de empleados o Caja.
- Cada item debe agruparse por:
  - Categoría (cocina, bar, postres)
  - Área de producción asignada
- Debe actualizarse automáticamente

#### 2. Gestión de Estados del Pedido
El empleado debe poder cambiar los estados:
- **Pendiente**
- **Listo**
- **Entregado**

Cada cambio debe reflejarse instantáneamente en:
- Sistema de ventas / App de empleados

#### 3. Interface de Cocina (UI)
La pantalla debe incluir:
- Vista tipo mosaico/tarjetas (cards) con cada pedido
- Código del pedido y número de mesa
- Notas especiales 
- Prioridad del pedido, es decir orden recibido->orden de entrega

#### 4. Comportamiento ante Cancelaciones
- Una notificacion que este fue cancelado

#### 6. Requerimientos Técnicos
- Debe funcionar en pantallas táctiles (Android o monitor con navegador).
- Debe manejar reconexión automática si se pierde el internet (modo offline visual).

### Backend
---

## 1.1.3 Establecimiento de objetivos del sistema

### Disponibilidad
 tratar de ser 95% funcional para un restaurante que no puede dejar de facturar

### Tiempo de Respuesta
- Las comandas deben llegar a cocina en menos de 5 segundos desde su creación.

### Precisión
- El cálculo de inventario debe tener margen de error practicamente 0%

- Si el local tenia 100 pollos y se vendieron 66 en un día, en el sistema debe aparecer que quedadn 34 pollos y asi con los demas productos

---

## 1.1.4  stakeholders

Kenneth R

## 1.2 Análisis de Viabilidad
--- 

# 2. Análisis y Diseño del Sistema
## 2.1 Levantamiento de Requerimientos
### 2.1.1 Requerimientos Funcionales (RF)

#### RF-01 – Gestión de Comandas  
El sistema debe permitir crear, modificar y cancelar pedidos, enviando actualizaciones automáticas al KDS

#### RF-02 – Facturación Electrónica  
Hablar con el equipo

#### RF-03 – División de Cuentas  
- Capacidad de separar una cuenta por productos o por montos iguales entre N personas
- Cada una de las personas que pagan por aparte puede dar una cantidad en tarjeta y otra en efectivo o sinpe movil

#### RF-04 – Control de Inventario  
Descuento automático de insumos, es decir, cada cosa que se vaya pidiendo, ejemplo de los pollos

#### RF-05 – Gestión de Perfiles  
Control de acceso basado en roles (Admin, empleado)

---

### 2.1.2 Requerimientos No Funcionales (RNF)


#### RNF-01 – Latencia Real-time  
El uso debe garantizar que un pedido llegar en **menos de 5 segundos**.

#### RNF-02 – Persistencia Offline  
El sistema debe permitir seguir operando (crear pedidos y facturar) sin conexión a internet, sincronizando datos al detectar red nuevamente.

#### RNF-03 – Seguridad de Datos  
Encriptación de datos sensibles y cumplimiento con la Ley 8968 (Protección de Datos Personales en Costa Rica).

#### RNF-04 – Escalabilidad  
La arquitectura debe soportar el crecimiento a lo largo del tiempo, ya sean mas transacciones y sucursales

---

### 2.1.3 Casos de Uso (Principales)

Define la interacción entre el usuario y el sistema.

#### CU-01 – Apertura y Cierre de Mesa  
El empleado selecciona una mesa libre, registra comensales y abre la cuenta.
Al finalizar, el empleado procesa el pago y libera la mesa.

#### CU-02 – Flujo de Cocina (KDS)  

El empleado utiliza la **KDS (Kitchen Display System)** para visualizar los pedidos. 
El empleado debe poder marcar los productos y/o el pedido completo como **“En preparación”** y **“Listo”**


### CU-03 – Ajuste de Inventario

El administrador registra una **entrada de mercancía** (compra), una **salida de mercancía** por merma, o corrige diferencias detectadas en inventario.

---

## 1. Actores
- **Administrador** (principal)
- **Sistema** (validaciones, actualización de stock)
- **Proveedor** (solo si la entrada viene por compra)

---

## 2. Descripción
El administrador necesita corregir o actualizar el inventario mediante:
1. **Entradas**: compras nuevas o regularización de existencias.  
2. **Salidas**: pérdidas, vencimientos, roturas, mermas o ajustes negativos.  
3. **Ajustes**: corrección de inventario para que coincida con conteo físico.

Cada ajuste debe quedar registrado con motivo, fecha, responsable

## 3. Flujo Básico

### 3.1 Entrada de mercancía (Compra)
1. Admin o empleado abre módulo **Inventario → Ajustes → Entrada**.
2. Selecciona proveedor
3. Selecciona el producto.
4. Ingresa **cantidad**, **costo unitario**, **número de factura** (opcional).
5. Sistema calcula:
   - costo total
   - nuevo costo promedio ponderado del producto
6. Admin confirma el registro.
7. Sistema actualiza **stock** y **costo promedio**.
8. Sistema registra el movimiento y muestra confirmación.

---

### 3.2 Salida / Merma
1. Admin o empleado abre **Inventario → Ajustes → Salida**.
2. Selecciona el producto.
3. Indica cantidad a descontar.
4. Debe seleccionar un **motivo de merma**, por ejemplo:
   - Producto vencido  
   - Daño físico  
   - Desperdicio de cocina  
   - Robo / pérdida  
   - Ajuste por conteo  
6. Sistema descuenta el stock.
7. Sistema registra el movimiento con motivo.

---

### 3.3 Ajuste por conteo físico
1. Admin o empleado selecciona **Inventario → Conteo**.
2. Ingresa cantidad física contada.
3. Sistema calcula diferencia:
   - Si física > sistema → entrada
   - Si física < sistema → salida
4. Admin confirma ajuste.
5. Sistema registra la diferencia con motivo: “Conteo físico”.

---

## 4. Flujo Alterno / Excepciones

- **FA-01:** Si la cantidad ingresada es menor o igual a cero → mostrar error.
- **FA-02:** Si el producto no existe o está inactivo → no permitir ajuste.
- **FA-03:** Si el inventario quedaría negativo con la salida → bloquear (y tira el mensaje indicandole al usuario)
- **FA-04:** Si se intenta registrar una entrada sin proveedor ni factura → permitir pero marcar como **“Entrada Manual No Contabilizada”**.

---

### 2.1.4 Historias de Usuario

---

### 2.1.5 Validaciones y Reglas de Negocio
#### RN-01 – Impuestos  
El sistema debe aplicar obligatoriamente:
- 13% de IVA 
- 10% impuesto de servicio 

#### RN-02 – Inventario Negativo  
No se debe permitir la venta de productos sin existencia en inventario

#### RN-03 – Anulaciones  
Toda anulación de pedido después de haber sido enviado a cocina requiere:
- Motivo del porqué canceló

#### RN-04 – Cierre de Caja  
No se puede realizar el cierre de caja si existen mesas con cuentas abiertas o pendientes de pago.

#### RN-05 – Carga de XML  (hablar con el Equipo)
esquema de proveedores

## 2.2 Diseño UI/UX
## 2.3 Arquitectura del Sistema
---

# 3. Módulo de Ventas 
## 3.1 Gestión de Pedidos
### 3.1.1 Crear pedido (Mesa / Para Llevar )

#### Mesa
- Debe solicitar **número de mesa** y **cantidad de comensales**.  
- El pedido queda en estado **"Abierto"** hasta el pago.

#### Para Llevar
- Solicita **nombre del cliente**.  
- Requiere **pago inmediato** o puede marcarse como **"Pendiente de Pago"**.  
- No ocupa mesa ni reserva espacio en el lugar.

---

### 3.1.2 Agregar / Editar productos
- La búsqueda de productos debe permitir filtrar por:
  - **Nombre**
  - **Categoría**
- **Validación:**  
  No se puede editar un producto que ya fue marcado como **"En preparación"** en cocina
---

### 3.1.3 Personalización de Platillos (Modificadores)

Al seleccionar un producto, el sistema debe mostrar los **Modificadores** asignados.

#### Tipos de Modificadores:
**Adicionales con costo**  
Ejemplo:  
- Extra tocineta: **+500 colones**  
- Extra queso: **+300 colones**
---

### 3.1.4 Cancelación con motivo

- Si el pedido ya se envió la cancelación debe generar un reporte de anulacion y notificar
- El sistema debe obligar a elegir un motivo:
  - **Error de digitación**
  - **Cliente se arrepintió**
  - **Falta de stock**
  - **Otro**
---

## 3.2 Comandas

### 3.2.3 Historial de Comandas

- El sistema debe permitir consultar comandas previamente enviadas por una mesa.
  - Para resolver reclamos de clientes

---

## 3.3 Caja y Pagos

### 3.3.1 Apertura de Caja

- Se debe ingresar un **Monto Inicial** de efectivo (base/fondo).
- No se permite ninguna operación de venta si:
  - No existe una caja abierta.

### 3.3.2 Ingresos y Egresos (Caja Chica)

Registrar movimientos **no relacionados** con ventas.

Requiere:
- **Monto**
- **Motivo**
- **Nombre de quien recibe** el dinero

Ejemplos:
- Compra de hielo
- Pago rápido a proveedor
- Retiro de efectivo autorizado (Ejemplo de las cajetas)

---

### 3.3.3 Métodos de Pago

El sistema debe soportar:
- **Efectivo**
- **Tarjeta**
- **SINPE Móvil**

#### Regla del Impuesto de Servicio (10%):
- Aplicar **automáticamente** el 10% solo si el pedido es **Mesa (Consumo en lugar)**.
- No aplicar el 10% en:
  - **Para Llevar**
  
Esto es parte de la normativa de CR.

---

### 3.3.4 Pagos Mixtos y División de Cuentas

#### Pagos Mixtos
- Permite liquidar una cuenta con múltiples métodos.  
  Ejemplo:
  - ₡10,000 efectivo + resto en SINPE

#### División de Cuenta

**Por Monto:**  
- Divide el total entre **N** partes iguales

**Por Producto:**  
- Seleccionar qué productos paga cada persona.
- Validación:  
  La suma final debe coincidir exactamente con el valor total antes de cerrar la mesa.
---

### 3.3.5 Cierre de Caja

#### Arqueo Ciego (Hablar con el equipo)
- El empleado ingresa cuánto dinero tiene **en físico**.
- El sistema **no** muestra cuánto debería haber (blindaje para auditoría).

#### Reporte de Diferencias
El sistema debe generar un informe con:
- Monto ingresado por empleado  
- Monto esperado según ventas  
- Faltantes o sobrantes  
- Responsable del turno

---

## 3.4 Facturación Electrónica (Hacienda CR) (hablar con el equipo)

### 3.4.1 Generación de XML y PDF

- Generar :
  - **PDF (representación gráfica)**

#### Validación de Identificación:
- Cédula Física → **9 dígitos**
- Cédula Jurídica → **10 dígitos**
- DIMEX / NITE → **11 o 12 dígitos**

Si no se ingresan datos:  
→ Facturar como **Cliente Contado** (Tiquete Electrónico).

---

### 3.4.2 Envío al Receptor

- Opción de envío automático por **correo** al cerrar la venta.

### 3.4.3 Notas de Crédito

Si una factura firmada requiere corrección:

- Debe generarse una **Nota de Crédito** asociada al número de factura original.
- Requiere siempre:
  - Seleccionar motivo (ej. "Error en método de pago")
  - Descripción adicional opcional
---

### 3.4.4 Reenvío Automático (Contingencia)

Si Hacienda responde error (400/500):
1. Emitir factura en **Modo Contingencia**.
2. Guardarla en una **cola de pendientes**.
3. Reintentar envío cada **15 minutos**.
4. Cambiar estado solo cuando Hacienda responda:
   - **Aceptado**
   - **Rechazado**
---
### 3.4.5 Sincronización con Hacienda

El sistema debe proveer un panel para ver:

- **Enviado**
- **Aceptado**
- **Rechazado**
- **Pendiente**

Debe permitir:
- Descargar mensajes XML de confirmación.
- Revisar histórico por fecha, cliente o número de factura.

---
# 4. Panel de Administración
## 4.1 Dashboard
Visualización de datos en tiempo real para la toma de decisiones.

### 4.1.1 KPIs de Ventas
El dashboard debe permitir al administrador visualizar y analizar las ventas de forma clara y flexible. Entre los indicadores principales se deben mostrar:

- **Ventas del día:** Monto total vendido con opción de ver: (por definir)

  - **Bruto:** antes de descuentos e impuestos.
  - **Neto:** después de descuentos, notas de crédito e impuestos.
- **Día Operativo vs Calendario:** Los reportes deben basarse en el **Día Operativo** (desde la apertura de la primera caja hasta el cierre de la última)
- **Rango de fechas:** El administrador debe poder retroceder días, semanas o meses y ver el historial de ventas.
- **Ticket Promedio:** Promedio por transacción en el período seleccionado.
- **Picos de venta por hora:** Gráfico que muestre en qué horas del día se vendió más o menos.
- **Métodos de pago más usados:** Distribución general entre efectivo, tarjeta, SINPE, etc.

### 4.1.3 Stock Crítico
- Lista automática de insumos por debajo del **stock mínimo** definido por el administrador.


### 4.1.4 Comparación entre Sucursales (hablar con el equipo)
- Gráficos comparativos de **ingresos**, **ventas**, **costos** o **gastos** para negocios con múltiples ubicaciones.

---
## 4.2 Sucursales (hablar con el equipo)

El administrador **no podrá crear ni eliminar sucursales** desde el sistema.  
Las sucursales serán configuradas **internamente por el equipo técnico** 

El panel del administrador debe permitir únicamente **visualizar** las sucursales existentes y administrar ciertos parámetros operativos asignados por los programadores.

---

### 4.2.1 Información de Sucursales (Solo Lectura)

El administrador podrá consultar información básica de cada sucursal:

- Nombre de la sucursal  
- Dirección física  
- Teléfono de contacto   

---

### 4.2.2 Parámetros Operativos (Editable por Administrador)

Cada sucursal puede tener configuraciones operativas específicas que **sí** pueden ser gestionadas por el administrador:

- **Horarios de atención** (ej. L–D 10:00 AM – 10:00 PM)
- **Menú habilitado por sucursal**  
  (productos disponibles o no disponibles en esa ubicación)
- **Precios diferenciados por sucursal** (si el negocio lo requiere)
- **Disponibilidad de combos o promociones específicas**
- **Control de mesas**: cantidad de mesas, nombres o numeración interna

---

## 4.3 Productos y Menús

### 4.3.1 CRUD de Productos
- **Acciones:** Crear, leer, actualizar y desactivar productos.
- **Configuración de Impuestos (CR):** Cada producto debe permitir configurar su perfil tributario:
  - Indicador de si está **Exento de IVA**.
  - Aplicación de **tasa reducida** (ej. Canasta Básica al 1%).
  - Aplicación de **tasa estándar** (13%).
  - Checkbox para habilitar/deshabilitar el **10% de Impuesto de Servicio** (independiente del IVA).


## 4.4 Empleados y Roles
### 4.4.2 Permisos Granulares
Permitir configurar permisos específicos:  
- El **empleado** puede cobrar y anular facturas.  
- El **empleado** puede editar pedidos pero no cambiar precios.  
- El **empleado** solo puede usar el la aplicacion del lugar  
- El **empleado** controla todo.

# 5. Inventario

---

## 5.1 Control de Stock

### 5.1.3 Alertas Automáticas
- Notificación al administrador (correo o mensaje) cuando un insumo llega al **nivel crítico**.

### 5.1.4 Bloqueo por Quiebre
- Si un ingrediente llega a 0, el sistema debe **desactivar automáticamente** el producto y notificar

---

## 5.2 Consumo
### 5.2.2 Consumo Automático
- Al cerrar una venta, el sistema debe restar automáticamente los insumos del inventario.

---

## 5.3 Transferencias entre Sucursales

### 5.3.1 Solicitudes
- Ejemplo: Sucursal A solicita **10 kg de carne** a Sucursal B.

### 5.3.2 Aprobación (se puede hacer manualmente agregando nuevo producto)
- El stock no se mueve hasta:
  1. Sucursal B confirma **salida**.  
  2. Sucursal A confirma **entrada**.  


# 6. Integraciones

## 6.1 Facturación Electrónica (Técnico) (Hablar con el equipo)

### 6.1.1 API de Hacienda
- Envío de XML **firmado digitalmente**.

### 6.1.3 Respaldo de XML
- Almacenamiento seguro de XML enviados y recibidos durante **5 años** (requisito legal).

---

## 6.2 Métodos de Pago

### 6.2.1 SINPE Móvil
- Campo para ingresar el **número de comprobante**.  
- Validación manual o automática según integración.

### 6.2.2 Tarjeta
- Integración con datáfonos vía API (si el banco lo permite)  
  **o**  
  registro manual del número de autorización.

---

## 6.3 Hardware

### 6.3.1 Dispositivos Compatibles
- Tablets Android/iOS  
- PC Windows
- Pantallas táctiles para KDS

# 7. Modo Offline (Estrategia de Sincronización)

### 7.1.1 Ventas Offline
- Las ventas se almacenan en una base de datos local 
- Debe funcionar aunque falle el internet del restaurante

### 7.1.3 Resolución de Conflictos
-El sistema compara las marcas de tiempo de cada cambio y da prioridad al cambio que tenga la marca de tiempo más reciente. Esto significa que, cuando ambos cambios se sincronizan con el sistema central, solo se conservará la versión más actualizada, descartando la anterior.
Importante se le debe notificar y guardar una copia

### 7.1.4 Sincronización Incremental
Cuando hay dos dispositivos trabajando sin internet al mismo tiempo, pueden ocurrir situaciones donde:

- Ambos modifican la misma mesa
- Ambos modifican el mismo pedido
- Ambos cambian la misma cantidad de un producto
- Ambos intentan cerrar la misma cuenta
Como no tienen conexión, cada uno guarda su versión local.

Cada vez que un mesero hace un cambio, el sistema guarda una fecha y hora exacta del cambio.

Cuando ambos dispositivos se conectan nuevamente, el sistema compara:

### ¿Cuál cambio fue el último en el tiempo?
- Ese cambio será el que se conserva.
- El cambio más viejo se descarta.



# 8. Pruebas y Calidad

---

# 9. Implementación y Despliegue
## 9.1 Infraestructura (por definir)

## 9.2 Preparación de Sucursales
- 9.2.1 Instalación de tablets  
- 9.2.2 Configuración de impresoras  
- 9.2.3 Capacitación  

## 9.3 Migración de Datos
- 9.3.1 Productos  
- 9.3.2 Proveedores  
- 9.3.3 Precios  
---

# 10. Mantenimiento
## 10.1 Monitoreo  
## 10.2 Backups  
## 10.3 Actualizaciones  
## 10.4 Soporte técnico  

