create database gringingo;
use gringingo;

create table usuarios(
  id int primary key auto_increment,
  nombre text,
  apellido text,
  nick text,
  password text,
  vida int,
  experiencia int
);

create table premios(
  id int primary key auto_increment,
  nombre text,
  img text
);

create table desafios(
  id int primary key auto_increment,
  nombre text,
  premio_id int,
  foreign key (premio_id) references premios(id)
);

create table desafio_usuario(
  id int primary key auto_increment,
  desafio_id int not null,
  usuario_id int not null,
  foreign key (desafio_id) references desafios(id),
  foreign key (usuario_id) references usuarios(id)
);


create table niveles(
  id int primary key auto_increment,
  nombre text
);

create table lecciones(
  id int primary key auto_increment,
  nombre text,
  img text,
  nivel_id int,
  foreign key (nivel_id) references niveles(id)
);


create table leccion_usuario(
  id int primary key auto_increment,
  leccion_id int not null,
  usuario_id int not null,
  foreign key (leccion_id) references lecciones(id),
  foreign key (usuario_id) references usuarios(id)
);

create table preguntas(
  id int primary key auto_increment,
  detalle text,
  tipo text,
  leccion_id int not null,
  foreign key (leccion_id) references lecciones(id)
);

create table respuestas(
  id int primary key auto_increment,
  nombre text,
  correpta bool,
  pregunta_id int not null,
  foreign key (pregunta_id) references preguntas(id)
);

create table ligas(
  id int primary key auto_increment,
  nombre text,
  puntos int
);

insert into ligas values
(default, "Oro", 200),
(default, "Plata", 100),
(default, "Bronce", 50);

insert into niveles values
(default, "Leccion 1"),
(default, "Leccion 2");

insert into lecciones values
(default, "Saludos", "",1),
(default, "Familia", "",2),
(default, "Menu", "",2);

insert into preguntas values
(1, 'Traducir a ingles [Buenos días]',"opciones", 1),
(2, 'Traducir a ingles [Mucho gusto]',"opciones", 1),
(3, 'Traducir a ingles [Bienvenido a Bolivia]',"opciones", 1),
(4, 'Traducir a español [Good morning!]',"opciones", 1),
(5, 'Traducir a Ingles [Yo soy de Bolivia.]',"opciones", 1),
(6, 'Escribe [Bienvenido] en ingles ',"comparar", 1),
(7, 'Escribe [Mucho gusto] en ingles ',"comparar", 1);

insert into respuestas values
(default, "Good morning",true,1),
(default, "Good night",false,1),
(default, "Good evening",false,1);
insert into respuestas values
(default, "Nice to meet you.",true,2),
(default, "I meet you.",false,2),
(default, "Nice to meet your.",false,2);
insert into respuestas values
(default, "Welcome to Bolivia",true,3),
(default, "Welcome from Bolivia",false,3),
(default, "Welcome to Bolivian",false,3);
insert into respuestas values
(default, "Good morning",false,4),
(default, "Good night",true,4),
(default, "Good evening",false,4);
insert into respuestas values
(default, "Welcome to Bolivia.",false,5),
(default, "I am from Bolivia.",true,5),
(default, "I am Bolivia.",false,5);
insert into respuestas values (default, "Welcome",true,6);
insert into respuestas values (default, "Nice to meet you.",true,7);



DELIMITER $$
drop PROCEDURE if exists sp_usuario_insert;$$
CREATE PROCEDURE sp_usuario_insert(_nombre TEXT, _apellido TEXT, _nick text, _password text)  BEGIN
	INSERT into usuarios values (DEFAULT, _nombre, _apellido, _nick, sha1(_password), 0, 0);
    select * from usuarios where id = LAST_INSERT_ID();
END$$

DELIMITER $$
drop PROCEDURE if exists sp_usuario_selectByLogin;$$
CREATE PROCEDURE sp_usuario_selectByLogin (_nick TEXT,_password TEXT)  BEGIN
	SELECT id, nombre, apellido, nick, vida, experiencia from usuarios where nick like _nick and password like sha1(_password);
END$$