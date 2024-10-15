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
    - Cantidad de stock: Cantidad de producto en al zona

## Productos
  - Descripcion de la entidad: Representa los diferentes productos que se venden en los viveros y que estan almacenados en las zonas
  - Atributos:
    - ID del producto: identificador unico del producto
    - Nombre: Nombre del producto (Ej: Amapola)

## Empleados
  - Descripcion de la entidad: Representa a los empleados que trabajan en las zonas del vivero
  - Atributos:
    - DNI: Identificador unico del empleado
    - Nombre: Nombre del empleado
    - Historial: Productividad historica del empleado

## Pedido (relacion)
  - Descripcion: Representa las ordenes de compra a realizar por los clientes
  - Atributos:
    - ID: Identificador unico del pedido
    - Fecha de compra: Fecha en la que se realiza la compra
    - Fecha de pedido: Fecha en la que se realiza el pedido

## Clientes
  - Descripcion de la entidad: Representa a los clientes de la empresa, que seran divididos en diferentes tipos
  - Atributos:
    - DNI: Identificador unico del cliente
  (duda)
  - Afiliado: Atributo booleano para comprobar si el cliente es afiliado o no:
      - Estado: Atributo que dice si es afiliado o no el cliente
      - Valor de bonificaciones: Valor de la bonificacion en relacion al volumen de compra del cliente
      - Fecha de ingreso: Fecha de ingreso al programa de afiliado
      - Compras mensuales: Volumen de compras mensuales realizadas

# Atributos de la relaciones
## Relacion de Pertenece entre zonas y empleados
  - Descropcion: Representa la pertenencia de un empleado a una zona y tambien la epoca en la que pertenece y mediante la cual 
    puede cambiar de zona
  - Atributos:
      - Puesto: Puesto del empleado
      - Epoca del año: atributo compuesto que sirve para reorganizar a los empleados en Zonas
        - Fecha de inicio: Fecha de inicio de la epoca de trabajo del empleado
        - Fecha de fin: Fecha de finalizacion de la epoca de trabajo del empleado

# Relaciones Definidas
## Viveros - Zonas
  - Descripcion: Un vivero esta formado por varias zonas
  - Cardinalidad: (1,1) ↔ (1,N)
  - Ejemplo:
    - Un vivero debe tener una o mas zonas
    - Una zona pertenece a un solo vivero

## Zonas - Producto 
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
 
## Empleados - Pedidos 
  - Descripcion: Un empleado puede gestionar un unico pedido y un pedido solo puede ser gestionado por un empleado (tiene un unico responsable)
  - Cardinalidad: (1,1) ↔ (1,1)
  - Ejemplo:
    - Un pedido es gestionado por un unico empleado
    - Un empleado puede gestionar un unico pedido

## Procuctos - Pedido
  - Descripcion: Un producto puede pertenecer a uno o mas pedidos y un pedido puede tener uno o mas productos
  - Cardinalidad: (1,N) ↔ (1,N)
  - Ejemplo:
    - Un producto puede pertenecer a uno o varios pedidos
    - Un pedido puede estar formado por uno o varios productos

## Pedidos - Clientes
  - Descripcion: Un cliente puere realizar multiples pedidos
  - Cardinalidad: (1,n) ↔ (1,1)
  - Ejemplo:
    - Un cliente puede realizar multiples pedidos
    - Un pedido pertence a un unico cliente

# Ejemplos de los dominios
## Viveros
  - ID: V001, V002
  - Nombre: "Vivero Norte", "Vivero Sur"
  - Latitud/Longitud: (27.986, -15.498)
  - *Cantidad de stock: 200, 500

## Zonas
  - Tipo de zona: "Interior", "Exterior"
  - Latitud/Longitud: (27.986, -15.498)
  - *Cantidad de stock: 200, 500

## Productos
  - ID: P001, P002
  - Nombre: "Planta A", "Planta B"

## Empleados
  - DNI: 12245678Y
  - Nombre: "Manuel"
  - Hostorial: 300

## Pedido
  - ID: 123456789
  - Fecha de compra: 2022-04-12
  - Fecha de pedido: 2022-04-13
  
## Clientes
  - DNI: 12345688X
  - Estado: true
  - Valor de bonificacion: 15
  - Fecha de ingreso: 2022-05-15
  - Compras mensuales: 300