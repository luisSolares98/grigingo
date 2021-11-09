create table notificaciones(
  id int primary key auto_increment,
  user_id int,
  tabla text,
  tabla_id int,
  mostrado bool,
  foreign key (user_id) references usuarios(id)
);

alter table desafios add column tipo text;
alter table desafios add parametro int;
alter table desafios add parametro int;

insert into premios values(default, "Un buen inicio", "");
insert into premios values(default, "Sin restrecciones", "");

insert into desafios values(default, "Responde tu primera pregunta correpta",1,"exp",10);
insert into desafios values(default, "Consigue 60 de experiencia",1,"exp",60);
insert into desafios values(default, "Completa tu primera lección",1,"leccion",1);



DELIMITER $$
drop PROCEDURE if exists sp_usuarioExperiencia_update;$$
CREATE PROCEDURE sp_usuarioExperiencia_update(_id int)  BEGIN
  
  declare _punto int default 10;
  declare _new_experiencia int default 10;
  declare _notificar int default 0;

  declare _notificacionId text default 0;
  declare _premioId int default 0;

  select experiencia into _new_experiencia from usuarios where _id;
  set _new_experiencia = _new_experiencia + _punto;

  update usuarios set experiencia = _new_experiencia where id = _id;

  
  select count(*) into _notificar from desafios where tipo = "exp" and parametro = _new_experiencia;
  if _notificar <> 0 then

    select id, premio_id into _notificacionId, _premioId from desafios where tipo = "exp" and parametro = _new_experiencia;
    insert into notificaciones values(default, _id, "desafios", _notificacionId, 0);

    call sp_insert_premios(_id, _premioId);
  end if;

  select * from usuarios where _id;
	
END$$

  


DELIMITER $$
drop PROCEDURE if exists sp_leccion_usuario_insert;$$
CREATE PROCEDURE sp_leccion_usuario_insert(_leccion_id int, _usuario_id int)  BEGIN
  
  declare isRepetido int default 0;
  declare _nivel_id int default 0;

  declare _notificacionId text default 0;
  declare _premioId int default 0;
  declare _countLecciones int default 0;
  declare _notificar int default 0;

  select nivel_id into _nivel_id from lecciones where id = _leccion_id;
  select count(*) into isRepetido from leccion_usuario where usuario_id = _usuario_id and leccion_id = _leccion_id; 
  
  if isRepetido = 0 then

    insert into leccion_usuario values(default, _leccion_id, _usuario_id);

    select count(*) into _countLecciones from leccion_usuario where usuario_id = _usuario_id;
    select count(*) into _notificar from desafios where tipo = "leccion" and parametro = _countLecciones;
    
    if _notificar <> 0 then
      select id, premio_id into _notificacionId, _premioId from desafios where tipo = "leccion" and parametro = _countLecciones;
      insert into notificaciones values(default, _usuario_id, "desafios", _notificacionId, 0);

      call sp_insert_premios(_usuario_id, _premioId);
    end if;

  end if;
    
  call sp_progresoByUser(_usuario_id);
	
END$$




DELIMITER $$
drop PROCEDURE if exists sp_notificaciones;$$
CREATE PROCEDURE sp_notificaciones(_usuario_id int)  BEGIN

  select (select count(*) from notificaciones where user_id = _usuario_id and tabla = "desafios" and mostrado = 0) as desafios,
        (select count(*) from notificaciones where user_id = _usuario_id and tabla = "premios" and mostrado = 0) as premios;
END$$



DELIMITER $$
drop PROCEDURE if exists sp_get_notificaciones;$$
CREATE PROCEDURE sp_get_notificaciones(_usuario_id int, _tabla text)  BEGIN
  
  update notificaciones set mostrado = 1 where user_id = _usuario_id and tabla = _tabla;  
  if _tabla = "desafios" then
    
    select n.id, d.nombre from notificaciones n
      join desafios d on n.tabla_id = d.id
    where user_id = _usuario_id and tabla = _tabla;

  elseif _tabla = "premios" then

    select n.id, p.nombre from notificaciones n
      join premios p on n.tabla_id = p.id
    where user_id = _usuario_id and tabla = _tabla;

  end if;
END$$



DELIMITER $$
drop PROCEDURE if exists sp_insert_premios;$$
CREATE PROCEDURE sp_insert_premios(_usuario_id int, _premio_id text)  BEGIN
  
  declare _countDesafios int default 0;
  declare _countDesafiosCompletados int default 0;

  declare _valido int default 0;

  select count(*) into _countDesafios from desafios where premio_id = _premio_id;

  select count(*) into _countDesafiosCompletados from (select * from notificaciones where tabla = "desafios" and user_id = 1) n
  join desafios d on n.tabla_id = d.id 
  where d.premio_id = _premio_id;

  if _countDesafios = _countDesafiosCompletados then

    select count(*) into _valido from notificaciones where tabla = "premios" and user_id = _usuario_id and tabla_id = _premio_id;
    
    if _valido = 0 then 

      insert into notificaciones values(default, _usuario_id, "premios", _premio_id, 0);

    end if;
  end if;

END$$



