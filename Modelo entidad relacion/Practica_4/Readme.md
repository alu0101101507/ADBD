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

    - a) Obtenga las ventas totales por categoría de películas ordenadas descendentemente.

      ``` sql
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

      Lo que nos permite ver esto:

      ![view_1](https://github.com/alu0101101507/ADBD/blob/main/Modelo%20entidad%20relacion/Practica_4/img/view1.png)

    - b) Obtenga las ventas totales por tienda, donde se refleje la ciudad, el país (concatenar la ciudad y el país empleando como separador la “,”), y el encargado.

    ```sql
    CREATE VIEW public.view_2 AS
    SELECT 
        CONCAT(city.city, ', ', country.country) AS location,
        CONCAT(staff.first_name, ' ', staff.last_name) AS encargado,  
        SUM(payment.amount) AS ventas_totales
    FROM public.payment
    JOIN public.staff USING (staff_id)
    JOIN public.store USING (store_id)
    JOIN public.address ON store.address_id = address.address_id  
    JOIN public.city USING (city_id)
    JOIN public.country USING (country_id)
    GROUP BY location, encargado
    ORDER BY ventas_totales DESC;
    ```

    Lo que nos permite ver la siguiente vista:

    ![view_2](https://github.com/alu0101101507/ADBD/blob/main/Modelo%20entidad%20relacion/Practica_4/img/view2.png)

    - c) Obtenga una lista de películas, donde se reflejen el identificador, el título, descripción, categoría, el precio, la duración de la película, clasificación, nombre y apellidos de los actores (puede realizar una concatenación de ambos)

    ```sql
    CREATE VIEW public.view_3 AS
      SELECT
        film.film_id,
        film.title,
        film.description,
        category.name AS category,
        film.length AS duracion_pelicula,
        film.rating AS clasificacion,
        film.rental_rate AS precio,
        CONCAT(actor.first_name, ' ', actor.last_name) AS actores
      FROM public.film
      JOIN public.film_category USING (film_id)
      JOIN public.category USING (category_id)
      JOIN public.film_actor USING (film_id)
      JOIN public.actor USING (actor_id);
    ```

    Lo que nos permite ver la siguiente vista:

    ![view_3](https://github.com/alu0101101507/ADBD/blob/main/Modelo%20entidad%20relacion/Practica_4/img/view3.png)

    - d) Obtenga la información de los actores, donde se incluya sus nombres y apellidos, las categorías y sus películas. Los actores deben de estar agrupados y, las categorías y las películas deben estar concatenados por “:” 

    ```sql
    CREATE VIEW public.view_4 AS
    SELECT 
        CONCAT(actor.first_name, ' ', actor.last_name) AS actor_nombre_completo,
        STRING_AGG(CONCAT(category.name, ': ', film.title), ', ' ) AS categorias_y_peliculas
    FROM  public.actor
    JOIN public.film_actor USING (actor_id)
    JOIN public.film USING (film_id)
    JOIN public.film_category USING (film_id)
    JOIN public.category USING (category_id)
    GROUP BY actor_nombre_completo
    ORDER BY actor_nombre_completo;
    ```

    Lo que nos permite ver la siguiente vista:

    ![view_4](https://github.com/alu0101101507/ADBD/blob/main/Modelo%20entidad%20relacion/Practica_4/img/view4.png) 

  ## Restricciones CHECK en el modelo
    Viendo el modelo he realizado las siguientes restricciones CHECk:
      - En la tabla customer he puesto dos restriscciones, en la que la primera es que el campo active solo pueda tener los valores 0 y 1 para representar de manera correcta
        que clientes estan o no activos, y la segunda restriccion vale para verificar que la fecha de creacion de la ficha del cliente sea anterior a la fecha actual, es decir
        que no se puede crear un cliente a futuro.

        ```sql
        CREATE TABLE public.customer (
          customer_id integer DEFAULT nextval('public.customer_customer_id_seq'::regclass) NOT NULL,
          store_id smallint NOT NULL,
          first_name character varying(45) NOT NULL,
          last_name character varying(45) NOT NULL,
          email character varying(50),
          address_id smallint NOT NULL,
          activebool boolean DEFAULT true NOT NULL,
          create_date date DEFAULT ('now'::text)::date NOT NULL,
          last_update timestamp without time zone DEFAULT now(),
          active integer,
          -- Check restriccions 
          CONSTRAINT chk_customer_active CHECK (active IN (0, 1)),
          CONSTRAINT chk_customer_current_date CHECK ((now() > create_date))
        );
        ```

      - En al tabla film he puesto 3 restricciones, la primera sirve para que el precio del alquiler sea superior a 0 e inferior a 50,
        la segunda restriccion sirve para que el precio de cambio en caso de que el cliente pierda o rompa una pelicula, sea superior a 0 pero inferior a 1000
        la idea es que haya un umbral de precios, y la ultima restriccion es para que la longitud de las peliculas tenga que ser superior a 1 minuto

        ```sql
        CREATE TABLE public.film (
          film_id integer DEFAULT nextval('public.film_film_id_seq'::regclass) NOT NULL,
          title character varying(255) NOT NULL,
          description text,
          release_year public.year,
          language_id smallint NOT NULL,
          rental_duration smallint DEFAULT 3 NOT NULL,
          rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
          length smallint,
          replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
          rating public.mpaa_rating DEFAULT 'G'::public.mpaa_rating,
          last_update timestamp without time zone DEFAULT now() NOT NULL,
          special_features text[],
          fulltext tsvector NOT NULL,
          -- Check restritcions
          CONSTRAINT chk_film_rental_rate CHECK (rental_rate > 0 AND rental_rate < 50),
          CONSTRAINT chk_film_replacement_cost CHECK (replacement_cost > 0 AND replacement_cost < 1000),
          CONSTRAINT chk_film_length CHECK (length >= 1)
        );
        ```

      - En la tabla inventory he puesto una restriccion para que la ultima actualizacion tenga que ser inferior a la fecha actual, es decir
        que no se pueda poner una actualizacion para un momento que no ha llegado aun

        ```sql
          CREATE TABLE public.inventory (
            inventory_id integer DEFAULT nextval('public.inventory_inventory_id_seq'::regclass) NOT NULL,
            film_id smallint NOT NULL,
            store_id smallint NOT NULL,
            last_update timestamp without time zone DEFAULT now() NOT NULL,
            -- Check restriction
            CONSTRAINT chk_inventory_last_update CHECK (last_update <= now())
        );
        ```


      - En la tabla payment he puesto dos restricciones, la primera se encara de comprobar que el pago (el campo amount) sea superior o igual a 0 y la segunda 
          se encarga de comprobar que la fecha de pago sea actual, es decir que no pueda haber un pago en una fecha futura

          ```sql
            CREATE TABLE public.payment (
              payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
              customer_id smallint NOT NULL,
              staff_id smallint NOT NULL,
              rental_id integer NOT NULL,
              amount numeric(5,2) NOT NULL,
              payment_date timestamp without time zone NOT NULL,
              -- Check restriction
              CONSTRAINT chk_payment_amount CHECK (amount >= 0),
              CONSTRAINT chk_payment_date CHECK (payment_date <= now())
          );
          ```

      - En la tabla staff he puesto una restriccion la cual me permite poner un limite al tamaño del nombre de usuario del miembro del staff

      ```sql
        CREATE TABLE public.staff (
            staff_id integer DEFAULT nextval('public.staff_staff_id_seq'::regclass) NOT NULL,
            first_name character varying(45) NOT NULL,
            last_name character varying(45) NOT NULL,
            address_id smallint NOT NULL,
            email character varying(50),
            store_id smallint NOT NULL,
            active boolean DEFAULT true NOT NULL,
            username character varying(16) NOT NULL,
            password character varying(40),
            last_update timestamp without time zone DEFAULT now() NOT NULL,
            picture bytea,
            -- CHeck restrictions
            CONSTRAINT chk_staff_username CHECK (char_length(username) BETWEEN 0 AND 16)
        );
      ```

  ## Explique la sentencia [ last_updated BEFORE UPDATE ON customer FOR EACH ROW EXECUTE PROCEDURE last_updated() ]

    Lo que hace ese trigger es que cuando se realize un UPDATE en la tabla customer, el campo last_update se actualizara a la hora actual de la realizacion del UPDATE
    en cada una de las filas modificadas con el update, un caso similar pasa con la tabla film:

    ```sql
    CREATE TRIGGER last_updated BEFORE UPDATE ON public.film
    FOR EACH ROW EXECUTE PROCEDURE public.last_updated();
    ```

  ## Creacion de triggers 

    He construido 2 triggers tal y como se pide en los siguientes casos:

      - Construya un disparador que guarde en una nueva tabla creada por usted la fecha de cuando se insertó un nuevo registro en la tabla film. 
        
        Para ello primero he creado la tabla film_inser_date:
        
        ```sql
          CREATE TABLE public.film_insert_date (
            film_id INTEGER NOT NULL,
            insert_date  timestamp WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
        ```

        Despues he creado la funcion date_film_insert que nos servira para cuando creemos el trigger usarla y que funcione correctamente

        ```sql
        CREATE FUNCTION public.date_film_insert() RETURNS trigger
            LANGUAGE plpgsql
            AS $$
        BEGIN
            INSERT INTO public.film_insert_date (film_id, insert_date)
            VALUES (NEW.film_id, CURRENT_TIMESTAMP);
            RETURN NEW;
        END $$;

        ALTER FUNCTION public.date_film_insert() OWNER TO postgres;
        ```

        y para terminar he creado el trigger:

        ```sql
        CREATE TRIGGER date_film_insert_trigger AFTER INSERT ON public.film
        FOR EACH ROW EXECUTE PROCEDURE public.date_film_insert();
        ```

        todo esto nos servira para que cuando insertemos en la tabla film una nueva pelicula se nos inserte en la nueva tabla creada el id y la fecha de introduccion de la misma en la tabla film:

        ![trigger1](https://github.com/alu0101101507/ADBD/blob/main/Modelo%20entidad%20relacion/Practica_4/img/trigger1.png)

        
      - Construya un disparador que guarde en una nueva tabla creada por usted la fecha de cuando se eliminó un registro en la tabla film y el identificador del film.

        Para ello como antes primero creo la tabla:
        
        ```sql
          CREATE TABLE public.film_delete_date (
              film_id INTEGER NOT NULL,
              delete_date  timestamp WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
          );
        ```

        despues cree la funcion date_film_delete() que nos servira despues en la creacion del trigger y que funcione correctamente:

        ```sql
          CREATE FUNCTION public.date_film_delete() RETURNS trigger
              LANGUAGE plpgsql
              AS $$
          BEGIN
              INSERT INTO public.film_delete_date (film_id, delete_date)
              VALUES (OLD.film_id, CURRENT_TIMESTAMP);
              RETURN OLD;
          END $$;

          ALTER FUNCTION public.date_film_delete() OWNER TO postgres;
        ```

        y para terminar cree el trigger:

        ```sql
        CREATE TRIGGER date_film_delete_trigger AFTER DELETE ON public.film
        FOR EACH ROW EXECUTE PROCEDURE public.date_film_delete();
        ```

        Ahora cuando querramos eliminar un registro de la tabla film guardaremos el id del film eliminado y tambien la fecha de eliminacion

        ![trigger2](https://github.com/alu0101101507/ADBD/blob/main/Modelo%20entidad%20relacion/Practica_4/img/trigger2.png)

  
  ## Comente el significado y la relevancia de las secuencias.

    Las secuencias nos estan sirviendo para la creacion de numeros secuenciales y valores unicos para por ejemplo las columnas de los ids de muchas de las tablas con la que habia que trabjar , tambien permiten ir incrementando los valores secuencialmente por lo que queramos en nuestro caso las secuencias aumentan de 1 en 1 y no contaban con valor ni minimo ni maximo, pero en definitiva sirven para la generacion de numero secuenciales, lo que nos permite a la hora de insertar un valor no tener que poner el campo id de por ejmplo peliculas si no que ya se generaria, o tambien a la hora de realizar una busqueda por ese campo.

    La relevancia que tiene todo esto es que permite una automatizacion a una base de datos la cual es amplia asi como al encagado de mantenerla se le hace un trabajo mas sencillo el poder realizar busquedas o insertar valores sin tener que estar preocupandose por el siguiente id a introducir.

