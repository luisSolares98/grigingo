create database gringringo;

create table usuarios(
  id int primary key auto_increment,
  nombre text,
  apellido text,
  nick text,
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

