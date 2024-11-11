# Practica 4: Modelo relacional vistas y disparadores

## Identifique tablas, vistas y secuencias 
Las tablas, vistas y secuencias con las que cuenta la base de datos son las siguientes:

![Tablas](https://github.com/alu0101101507/ADBD/blob/main/Modelo%20entidad%20relacion/Practica_4/img/Tablas%20y%20secuencias.png)

En ella podemos ver principalmente informacion por una parte de las peliculas, como los actores, las categorias a las que pertenece una pelicula,
informacion de la pelicula en si como el titulo, el año de salida, etc.
Tambien hay informacion relativa al cliente que alquila la pelicula, como el nombre, el email, la direccion entre otras cosas, se puede observar tambien informacion del pago,
de las tiendas, del staff.

## Tablas principales y principales elementos
Las tablas principales de la base de datos son las siguientes:
  - Film: Representa a las peliculas de la base de datos:
    - Atributos:
      - Film_id: Identificador unico no nulo de la pelicula
      - Title: Titulo de la pelicula
      - Derscription: Descripcion de la pelicula
      - release_year: Año de salida de la pelicula
      - languaje_id: Identificador que relaciona con que lenguaje esta disponible la pelicula
      - rental_duration: Duracion del alquiler de la pelicula
      - rental_rate: Precio del alquiler de la pelicula
      - lenght: Duracion de la pelicula
      - replacement_cost: Coste de reemplazo
      - rating: Rating de la pelicula (publico para el es apto)
      - last_update: Ultima actualizacion de alquiler
      - special_features: Accesorios especiales (trailers, behind the scenes)
      - fulltext: Vector de palabras con el cual realizar busquedas a esas peliculas

  - Customer: Representa a los clientes
    - Atributos:
      - Customer_id: Identificador unico del cliente
      - store_id: Tienda en la cual esta afiliado
      - fisrt_name: Nombre
      - last_name: Apellidos
      - email: Email
      - address_id: Numero que representa la direccion de donde vive, esto se relaciona con otra tabla que tiene la informacion mas detallada
      - activebool: Booleano
      - create_date: Fecha de registro del usuario
      - last_update: Ultima actualizacion del usuario
      - active: Numero que indica si el cliente esta dado de alta o no
  
  - Category: Representa las categorias a las que pertenece una pelicula
    - Atrributos:
      - Category_id: Identificador unico de la categoria
      - name: Nombre de la categoria (Accion, aventura)
      - last_update: ultima actualizacion de las categorias en la base de datos
  
  - Inventory: Representa el inventario que hay de peliculas en las tiendas
    - Atributos:
      - Inventory_id: identificador unico de cada registro 
      - film_id: identificador que hace referencia a una pelicula de la tabla film
      - store_id: identificador que hace referencia a una tienda de la tabla store
      - last_update:  ultima actualizacion del inventario

  - Payment: Representa un historial del pago de los clientes
    - Atributos:
      - Payment_id: Identificador unico del pago
      - Customer_id: Identificador unico del cliente que hace el pago
      - Staff_id: Identificador unico del staff que atiende al pago del cliente
      - rental_id: Identificador unico del item que ha alquilado
      - amount: Cantidad a pagar
      - payment_date: Fecha de pago

  - Rental: Representa un historial de los alquileres
    - Atributos:
      - rental_id: Identificador unico del alquiles
      - rental_date: Fecha de alquiler
      - inventory_id: Identificador unico del item en el inventario
      - customer_id: Identificador del cliente que alquila
      - return_date: Fecha de devolucion
      - staff_id: Identificador del staff que atiende al cliente
      - last_update: Ultima actualizacion del alquiler
  
  - Staff: Representa al staff que se encarga en las tiendas de alquilar las peliculas
    - Atributos:
      - staff_id: Identificador del miembro del staff
      - first_name: Nombre
      - last_name: Apellido
      - address_id: Identificador de la direccion del staff
      - email: Correo electronico
      - store_id: Identificador de la tienda a la que estana asignadors
      - active: Booleano que dice si esta activo o no el staff
      - username: Nombre de usuario
      - password: Contraseña
      - last_update: Ultima actualizacion del staff
      - picture: Fotografia identificativa

  - Store: Representa la tienda en la que se alquilan peliculas
    - Atributos:
      - store_id: Identificador unico de la tienda
      - manager_staff_id: Identificador del manager, que es un miembro de la tabla staff
      - address_id: Identificaador de la direccion donde se encuentra la tienda
      - last_update: Ultima actualizacion de la tienda

  - Language: Representa los lenguajes en los que estan las peliculas
    - Atributos:
      - language_id: Identificador unico del lenguaje 
      - name: Lenguaje 
      - last_update: Ultima actualizacion del lenguaje en la base de datos
  
  - Address: Representa la direccion de los clientes, tiendas, etc de la base de datos
    - Atributos:
      - address_id: Identificador unico de la direccion
      - address: Direccion real (calle, piso, etc)
      - address2: Datos de segunda direccion en caso de tener
      - district: Distrito al que pertenece
      - city_id: Identificador para saber la ciudad en la que esta
      - postal_code: codigo postal
      - phone: Telefono de contacto
      - last_update: Ultima actualizaciond de la base de datos
  
## Vistas con las consultas del apartado 4
  Las consultas pedidas para realizar y despues crear las vistas eran las siguientes:
    - Obtenga las ventas totales por categoría de películas ordenadas descendentemente.

      ```sql
      CREATE VIEW public.view_1 AS 
        SELECT category.name AS category,
          SUM(payment.amount) AS ventas_totales     
        FROM (((((public.film
        JOIN public.film_category USING (film_id))
        JOIN public.category USING (category_id)) 
        JOIN public.inventory USING (film_id))    
        JOIN public.rental USING (inventory_id))  
        JOIN public.payment USING (rental_id))    
        GROUP BY category.name
        ORDER BY (sum(payment.amount)) ASC;   
      ```