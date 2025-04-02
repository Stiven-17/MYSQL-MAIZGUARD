CREATE DATABASE MAIZGUARD;
USE MAIZGUARD;

CREATE TABLE usuarios (
	id_usuarios INT AUTO_INCREMENT PRIMARY KEY,
    id_estados INT NOT NULL,
    id_rol INT NOT NULL DEFAULT 2,
	nombre VARCHAR (40) NOT NULL,
	apellido VARCHAR (40) NOT NULL,
	contrasena VARCHAR (255) NOT NULL,
	correo_electronico VARCHAR (100) NOT NULL UNIQUE,
	fotografia  VARCHAR(255),
	fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    token_recuperacion VARCHAR(250) NULL,
    fecha_expiracion_token DATETIME NULL,
    FOREIGN KEY (id_estados) REFERENCES estados (id_estados),
    FOREIGN KEY (id_rol) REFERENCES roles (id_rol)
);
select * from usuarios;


CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO roles (nombre_rol) VALUES ('SuperAdmin'), ('usuario');


CREATE TABLE estados (
    id_estados INT AUTO_INCREMENT PRIMARY KEY,   
    nombre_estado VARCHAR(50) NOT NULL UNIQUE
    );
INSERT INTO estados (nombre_estado) VALUES ('Activo'), ('Inactivo');
select * from estados where id_estados;


CREATE TABLE fase_cultivo (
	id_fase_cultivo INT AUTO_INCREMENT PRIMARY KEY,
	descripcion VARCHAR(250) NOT NULL
);
INSERT INTO fase_cultivo (descripcion) VALUES ('Maduracion'), ('Cosecha');


CREATE TABLE registro_cultivo (
	id_registro_cultivo INT AUTO_INCREMENT PRIMARY KEY,
    id_fase_cultivo INT NOT NULL,
    id_usuarios INT NOT NULL,
	ancho DECIMAL(10, 2),
    largo DECIMAL(10, 2),
    url_img  VARCHAR(255) NOT NULL,
	descripcion TEXT,
	id_estados INT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuarios) REFERENCES usuarios (id_usuarios),
    FOREIGN KEY (id_fase_cultivo) REFERENCES fase_cultivo (id_fase_cultivo),
	FOREIGN KEY (id_estados) REFERENCES estados (id_estados)
);


CREATE TABLE tipo_plaga (
	id_tipo_plaga INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (60) NOT NULL UNIQUE
);
INSERT INTO tipo_plaga (nombre) VALUES ('Insectos'), ('Acaros'), ('Fungos'), ('Bacterias'), ('Virus');


CREATE TABLE temporada (
	id_temporada INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (60) NOT NULL UNIQUE
);
INSERT INTO temporada (nombre) VALUES ('Temporada de Lluvia'), ('Temporada de Sequia');

CREATE TABLE plaga (
	id_plaga INT AUTO_INCREMENT PRIMARY KEY,
    id_usuarios INT NOT NULL,
	nombre VARCHAR (60) NOT NULL,
	nombre_cientifico VARCHAR (100) NOT NULL,
	url_img  VARCHAR(255) NOT NULL,
	descripcion TEXT NOT NULL,
	recomendaciones TEXT NOT NULL,
	id_fase_cultivo INT NOT NULL,
	id_tipo_plaga int NOT NULL,
	id_temporada int NOT NULL,
     FOREIGN KEY (id_usuarios) REFERENCES usuarios (id_usuarios),
    FOREIGN KEY (id_fase_cultivo) REFERENCES fase_cultivo (id_fase_cultivo),
    FOREIGN KEY (id_tipo_plaga) REFERENCES tipo_plaga (id_tipo_plaga),
    FOREIGN KEY (id_temporada) REFERENCES temporada (id_temporada)
); 

CREATE TABLE registro_plaga (
	id_registro_plaga INT AUTO_INCREMENT PRIMARY KEY,
    id_usuarios INT NOT NULL,
	id_registro_cultivo INT NOT NULL,
    id_plaga INT NOT NULL,
    url_img  VARCHAR(255) NOT NULL,
	descripcion TEXT NOT NULL,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
     FOREIGN KEY (id_usuarios) REFERENCES usuarios (id_usuarios),
	FOREIGN KEY (id_registro_cultivo) REFERENCES registro_cultivo (id_registro_cultivo),
    FOREIGN KEY (id_plaga) REFERENCES plaga (id_plaga)
);


CREATE TABLE Consultas (
	id_consultas INT AUTO_INCREMENT PRIMARY KEY,
    id_Plaga INT NOT NULL,
    id_usuarios INT NOT NULL,
    FOREIGN KEY (id_Plaga) REFERENCES Plaga (id_Plaga),
     FOREIGN KEY (id_usuarios) REFERENCES usuarios (id_usuarios)
);
