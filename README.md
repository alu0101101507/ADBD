# ADBD
(Nombre : Jose Miguel Hernández Santana, alu: alu0101101507)
# Entidades definidas
## Medicamentos
  - Descripcion de la entidad: Representa los medicamentos con los que cuenta la farmacia
  - Atributos:
    - Codigo del medicamento: Identificador unico para cada medicamento(Ej: codigo de barras)
    - Nombre del medicamento (Ej: Paracetamol)
    - Tipo de medicamento: Atributo compuesto por los diferentes tipos de medicamentos que haya (Ej: Jarabe, pomada, etc)
    - Unidades de stock: Numero de medicamento que queda en la farmacia (Ej: 10 unidades de paracetamol)
    - Unidades vendidas: Numero de unidades de medicamento vendidos (Ej: 5 unidades de pectox)
    - Precio: Precio del medicamento en cuestion (Ej: 5 euros por caja)

## Laboratorio
  - Descripcion de la entidad: Representa el laboratorio que fabrica los medicamentos que comprara la farmacia
  - Atributos:
    - Codigo del laboratorio: Identificador unico del laboratorio (Ej: LAB1)
    - Nombre del laboratorio (Ej: Laboratorio Abbott)
    - Teléfono: Número de contacto del laboratorio (Ej: +34 123 456 789)
    - Dirección Postal: Dirección física del laboratorio
    - Fax: Número de fax del laboratorio
    - Persona de contacto: Nombre de la persona de contacto

## Familias
  - Descripcion de la entidad: Representa las familias en las que se agrupan los medicamentos
  - Atributos:
      - Tipo de enfermedad: Tipo de enfermedad que trata la familia(Ej: gripe)
      - Nombre de familia: Nombre que recibe la familia en la que se agrupan esos medicamentos (Ej: Antibiotico)

## Compra
  - Descripcion: Representa la relacion por la cual el cliente compra un medicamento
  - Atributos:
    - Fecha de compra: Fecha en la que se realizo la compra
    - Numero de medicamentos comprados: Numero de medicamentos comprado por el cliente

## Clientes
  - Descripcion de la entidad: Representa los clientes que compran medicamentos
  - Atributos:
    - Nombre del cliente: Nombre del cliente que compra medicamentos
    - Dni del cliente: Identificador unico del cliente

## Clientes con saldo
  - Descripcion de la entidad: Representa a los clientes con saldo en la farmacia
  - Atributos:
    - Datos bancarios: Datos bancarios del cliente necesarios en la farmacia
    - Fecha de pago: Fecha en la que se le cobrara al cliente el medicamento (Puede tener varias fechas dependiendo del medicamento)

## Clientes sin saldo
  - Descripcion de la entidad: Representa a los clientes sin saldo en la farmacia

## Venta libre
  - Descripcion de la entidad: Representa los medicamentos que son de venta libre(sin receta)

## Receta medica
  - Descripcion de la entidad: Representa los medicamentos que solo pueden ser comprados con receta medica

# Descripcion de las relaciones definidas

## Relacion Medicamentos - Laboratorios
  La relacion que hay entre medicamentos y laboratorio es que un medicamento puede ser comprado un laboratorio , al igual que un laboratorio puede vender varios medicamentos a una farmacia.
  
  - Su cardinalidad es (N,M) ya que:
      - Un medicamento puede ser comprado a varios laboratorios
      - Un laboratorio puede vender varios medicamnetos

## Relacion Medicamentos - Familias
  La relacion que hay entre los medicamentos y las familias de medicamentos es que un medicamento puede pertenecer a una familia unica, pero una familia puede contener varios medicamentos

  - Su cardinalidad es (1, N) ya que:
    - Un  medicamento se agrupa en una familia
    - Una familia se forma de agrupar varios medicamentos
  
  Un ejemplo de esto seria: 
    - El medicamento "Ibuprofeno" pertenece a la familia de medicamentos para el "Dolor y la inflamación".
    - La familia "Antiinflamatorios" incluye tanto "Ibuprofeno" como "Naproxeno".

## Relacion Medicamentos - Cliente
  La relacion que se establece aqui es que un medicamento es comprado por un cliente

  - Su cardinalidad es (N,M) ya que:
    - Un medicamento puede ser comprado por un cliente
    - Un cliente puede comprar varios medicamentos

  Un ejemplo de esto seria:
    - Ibuprofeno puede ser comprado por ese cliente, así como por otros clientes.
    - Un cliente compra ibuprofeno y paracetamol.

## Relacion Medicamentos con tipo de venta
  La relacion que se establece es el metodo por el cual se van a poder vender medicamentos que seran , por venta libre
  o con receta medica, pero solo por uno de esos metodos a la vez es decir si se te vende por venta libre no se te vende con cita medica y viceversa.

## Relacion Clientes- Tipo de clientes
  La relacion qeu se establece es el tipo de cliente y como se divide en la farmacia, entre los que tienen saldo en ella y los que no, pero siendo solo uno de esos tipos de clientes a la vez, los clientes con saldo tienen asociados sus datos bancarios y sus fechas de pago en las cuales se les cargara el importe de los medicamentos.
