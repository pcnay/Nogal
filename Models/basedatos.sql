/*
-- Ejecutarlo desde una terminal de Mysql 
-- Cuando sea la PRIMERA VEZ que se esta generando la base de datos, se debe entrar como root en la computadora y accesar a "mysql"
		mysql -u root -p


-- Se debe accesar al directorio donde se encuentra el "script.sql" y ejecutar el comenado "mysql" desde una terminal
-- $ mysql -u nom-usr -p NombreBaseDatos < script.sql
-- Otra Forma :
--    mysql -u usuario -p NombreBaseDatos
--    source script.sql ó \. script.sql

			Borrar tabla: DROP TABLE <nombre Tabla>
			Borrar Base Datos : DROP DATABASE <nombre Base Datos>
			Borrar el contenido de la tabla : 
					truncate table nombre-tabla;
*/

/* DROP DATABASE IF EXISTS bd_nogal; */

/* 
Mostrar todos los usuarios 
  select user from mysql.user;

Para borrar un usuario: se tiene que ejecutar los dos comandos.
Para borrar un usuario para todos los hosts:
	drop user ventas-pos;

Para borrar un usuario en especifico
	delete from mysql.user where user = ‘ventas-pos’

Para borrar mas de un usuario en el host
	drop user ‘ventas-pos’@’localhost’;
	
	flush privileges;

BORRANDO EL CONTENIDO DE UNA TABLA EN MariaDB
	truncate table nombre-tabla;
Para mostrar los campos de una tabla:
	describe t_Responsivas;

*/

/* Tabla de Datos */
/* Se ocupa los 9 espacios, no se desperdicia espacio.*/
  /* CHAR(X) = cuando se define de algun tamaño pero no se utiliza, se despedicia espacio, por ejemplo
  CHAR(30), pero el valor de "title" es de 20, se desperdicio 60 espacios.
  VARCHAR(80) se adapta al tamaño del titulo.
  En la base de datos se puede guardar, videos, documentos en formato binario, pero creceria mucho.
  Se sube el video, documento, solo se graba la URL en el campo de la base de datos.
	
	estado INTEGER UNSIGNED DEFAULT 0,

	Tipos De Datos que maneja MySQL, MariaDb
	https://www.anerbarrena.com/tipos-dato-mysql-5024/

  */

DROP DATABASE IF EXISTS bd_nogal;

CREATE DATABASE IF NOT EXISTS bd_nogal;
 /* SET time_zone = 'America/Tijuana';  */

USE bd_nogal;


/*Solo se ejecuta la primera vez.
CREATE USER 'usuario_nogal'@'localhost' IDENTIFIED BY 'nogal-2021';
GRANT ALL on bd_nogal.* to 'usuario_nogal'  IDENTIFIED BY 'nogal-2021';
*/


/* 
Mostrar todos los usuarios 
  select user from mysql.user;

Para borrar un usuario: se tiene que ejecutar los dos comandos.
Para borrar un usuario para todos los hosts:
	drop user ventas-pos;

Para borrar un usuario en especifico
	delete from mysql.user where user = ‘ventas-pos’

Para borrar mas de un usuario en el host
	drop user ‘ventas-pos’@’localhost’;
	
	flush privileges;

BORRANDO EL CONTENIDO DE UNA TABLA EN MariaDB
	truncate table nombre-tabla;
Para mostrar los campos de una tabla:
	describe t_Responsivas;


*/

/* Tabla de Datos */
/* Se ocupa los 9 espacios, no se desperdicia espacio.*/
  /* CHAR(X) = cuando se define de algun tamaño pero no se utiliza, se despedicia espacio, por ejemplo
  CHAR(30), pero el valor de "title" es de 20, se desperdicio 60 espacios.
  VARCHAR(80) se adapta al tamaño del titulo.
  En la base de datos se puede guardar, videos, documentos en formato binario, pero creceria mucho.
  Se sube el video, documento, solo se graba la URL en el campo de la base de datos.
	
	estado INTEGER UNSIGNED DEFAULT 0,

	Tipos De Datos que maneja MySQL, MariaDb
	https://www.anerbarrena.com/tipos-dato-mysql-5024/

  */

CREATE TABLE t_Rol
(
  id_rol SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre_rol VARCHAR(50),
	descripcion VARCHAR(80),
	estatus TINYINT DEFAULT 1
);

CREATE TABLE t_Personas
(
  id_persona SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	id_rol SMALLINT UNSIGNED  NOT NULL,
  identificacion VARCHAR(30),
	nombres VARCHAR(80),
	apellidos VARCHAR(100),
	telefono SMALLINT,
	email_user VARCHAR(100),
	passwords VARCHAR(25),
	rfc VARCHAR(20),
	nombrefiscal VARCHAR(80),
	direccionfiscal VARCHAR(100),
	toke VARCHAR(80),
	datecreated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	estatus TINYINT DEFAULT 1,
	comentarios TEXT NULL,
	FOREIGN KEY(id_rol) REFERENCES t_Rol(id_rol)
	ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE t_Modulos
(
  id_modulo SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(50),
	descripcion VARCHAR(80),
	estatus TINYINT DEFAULT 1	
);

CREATE TABLE t_Permisos
(
  id_permiso SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  id_rol SMALLINT UNSIGNED NOT NULL,
	id_modulo SMALLINT UNSIGNED NOT NULL,
	r TINYINT DEFAULT 0,
	w TINYINT DEFAULT 0,
	u TINYINT DEFAULT 0,
	d TINYINT DEFAULT 0,
	FOREIGN KEY(id_rol) REFERENCES t_Rol(id_rol)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(id_modulo) REFERENCES t_Modulos(id_modulo)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE t_Categorias
(
  id_categoria SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR (100),
	descripcion VARCHAR(100),
	datecreated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	estatus TINYINT DEFAULT 1	
);

CREATE TABLE t_Productos
(
  id_producto SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	id_categoria SMALLINT UNSIGNED NOT NULL,
  codigo VARCHAR (30),
	nombre VARCHAR (100),
	descripcion TEXT,
	precio decimal(10,2) DEFAULT NULL,
	stock SMALLINT UNSIGNED,
	imagen VARCHAR(100),
	datecreated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	estatus TINYINT DEFAULT 1,
	FOREIGN KEY(id_categoria) REFERENCES t_Categorias(id_categoria)
	ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE t_Pedidos
(
  id_pedido SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	id_persona SMALLINT UNSIGNED NOT NULL,	
	fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	monto decimal(10,2) DEFAULT NULL,
	tipopagoid SMALLINT UNSIGNED,
	estatus TINYINT DEFAULT 1,
	FOREIGN KEY(id_persona) REFERENCES t_Personas(id_persona)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE t_Detalle_Pedidos
(
  id_detalle_pedido INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	id_pedido SMALLINT UNSIGNED NOT NULL,	
	id_producto SMALLINT UNSIGNED NOT NULL,	
	cantidad SMALLINT UNSIGNED,
	precio decimal(10,2) DEFAULT NULL,		
	FOREIGN KEY(id_pedido) REFERENCES t_Pedidos(id_pedido)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(id_producto) REFERENCES t_Productos(id_producto)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE t_Detalle_Temp
(
  id_detalle_pedido SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	id_producto SMALLINT UNSIGNED NOT NULL,	
	cantidad SMALLINT UNSIGNED,
	precio decimal(10,2) DEFAULT NULL,
	token VARCHAR(100),
	FOREIGN KEY(id_producto) REFERENCES t_Productos(id_producto)
	ON DELETE RESTRICT ON UPDATE CASCADE
);
