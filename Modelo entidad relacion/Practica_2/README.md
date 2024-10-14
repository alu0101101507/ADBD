# ADBD: Modelo entidad/relacion viveros
Nombre : Jose Miguel Hernández Santana, alu: alu0101101507
# Entidades definidas
## Viveros 
  - Descripcion de la entidad: Representa a los viveros que forman parte de la empresa
  - Atributos: 
    - Nombre del vivero: Nombre del vivero
    - Latitud: Coordenada Latitud del vivero
    - Longitud: Coordenada de Longitud del vivero
    (Ambos atributos representan las coordenadas del vivero)

## Zonas
  - Descripcion de la entidad: Representa las zonas de las que esta formado el vivero, cada zona puede contener diferentes tipos de productos
  - Atributos:
    - Tipo de zona: Tipo de zona en la que se almacenan productos (Ej: Almacen, zona exterior)
    - Latitud: Coordenada Latitud de la zona
    - Longitud: Coordenada de Longitud de la zona
    (Ambos atributos representan las coordenadas de las zonas)

## Productos
  - Descripcion de la entidad: Representa los diferentes productos que se venden en los viverosn y que estan almacenados en las zonas
  - Atributos:
    - ID del producto: identificador unico del producto
    - Nombre: Nombre del producto
    (duda)
    - Stock: Cantidad de producto que se encuentra en la zona

## Empleados
  - Descripcion de la entidad: Representa a los empleados que trabajan en las zonas del vivero
  - Atributos:
    - DNI: Identificador unico del empleado
    - Nombre: Nombre del empleado
    - Historial: Productividad historica del empleado
    (duda)
    - Epoca del año: Epoca del año para saber cuando el empleado peude cambiar de zona , formado por fecha de inicio y fecha de fin del periodo
    - Puesto: puesto de trabajo del empleado

## Clientes
  - Descripcion de la entidad: Representa a los clientes de la empresa, que seran divididos en diferentes tipos
  - Atributos:
    - DNI: Identificador unico del cliente
  (duda)
  - Jerarquia (Programa de fidelizacion):
    - Clientes Tajinaste Plus:
      - Valor de bonificaciones: Valor de la bonificacion en relacion al volumen de compra del cliente
      - Fecha de ingreso: Fecha de ingreso al programa de afiliado
      - Compras mensuales: Volumen de compras mensuales realizadas

(duda)
## Pedido (relacion)
  - Descripcion: Representa las ordenes de compra a realizar por los clientes
  - Atributos:
    - Fecha de compra: Fecha en la que se realiza la compra
    - Fecha de pedido: Fecha en la que se realiza el pedido

# Relaciones Definidas
## Viveros - Zonas
  - Descripcion: Un vivero esta formado por varias zonas
  - Cardinalidad: (1,1) ↔ (1,N)
  - Ejemplo:
    - Un vivero debe tener una o mas zonas
    - Una zona pertenece a un solo vivero

## Zonas - Producto (duda cardinalidad)
  - Descripcion: Cada zona contiene productos y un producto puede estar en varias zonas.
  - Cardinalidad: (1,N) ↔ (1,N)
  - Ejemplo:
    - Una zona puede contener multiples productos
    - Un producto puede estar presente en varias zonas
## Zonas - Empleados
  - Descripcion: Un empleado trabaja en una zona específica durante un período de tiempo determinado por la época del año
  - Cardinalidad: (1,1) ↔ (1,N)
  - Ejemplo:
    - Una zona puede tener multiples empleados a lo largo del tiempo
    - Un empleado solo puede trabajar en una zona a la vez, pero puede cambiar de zona en distintas épocas del año
 
## Empleados - Pedidos (duda esta relacion se daria tal y como esta en la imagen)
  - Descripcion: Un empleado puede gestionar varios pedidos, pero un pedido solo puede ser gestionado por un empleado
  - Cardinalidad: (1,1) ↔ (1,N)
  - Ejemplo:
    - Un pedido es gestionado por un unico empleado
    - Un empleado puede gestionar múltiples pedidos

## Pedidos - Clientes
  - Descripcion: Un cliente puere realizar multiples pedidos
  - Cardinalidad: (1,1) ↔ (1,N)
  - Ejemplo:
    - Un cliente puede realizar multiples pedidos
    - Un pedido pertence a un unico cliente

# Ejemplos de los dominios
## Viveros
  - ID: V001, V002
  - Nombre: "Vivero Norte", "Vivero Sur"
  - Latitud/Longitud: (27.986, -15.498)

## Zonas
  - Tipo de zona: "Interior", "Exterior"
  - Latitud/Longitud: (27.986, -15.498)

## Productos
  - ID: P001, P002
  - Nombre: "Planta A", "Planta B"
  - *Cantidad de stock: 200, 500

## Empleados
  - DNI: 12345678Y
  - Nombre: "Manuel"
  - Historial: 100
  
## Clientes Tajinaste Plus
  - DNI: 12345678X
  - Nombre: "Juan Pérez"
  - Valor de bonificacion: 15
  - Fecha de ingreso: 2022-05-15
  - Compras mensuales: 300 € (volumen de compras)