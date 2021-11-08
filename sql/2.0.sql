DELIMITER $$
drop PROCEDURE if exists sp_progresoByUser;$$
CREATE PROCEDURE sp_progresoByUser(_usuario_id int)  BEGIN

    select z.id,z.nombre, x.lecciones,z.completados from (
    select n.id, count(n.id) as lecciones from niveles n
    join lecciones l on n.id = l.nivel_id
    group by n.id) x

    join (
      select n2.*, ifnull(completados,0) as completados from niveles n2
          left join (
            select l.*, count(l.id) as completados from niveles n
            join lecciones l on n.id = l.nivel_id
            join leccion_usuario lu on l.id = lu.leccion_id
            where lu.usuario_id = _usuario_id
            group by n.id) leu on n2.id = leu.id) z on x.id = z.id;

END$$

DELIMITER $$
drop PROCEDURE if exists sp_leccion_usuario_insert;$$
CREATE PROCEDURE sp_leccion_usuario_insert(_leccion_id int, _usuario_id int)  BEGIN
  
  declare isRepetido int default 0;
  declare _nivel_id int default 0;

  select nivel_id into _nivel_id from lecciones where id = _leccion_id;
  select count(*) into isRepetido from leccion_usuario where usuario_id = _usuario_id and leccion_id = _leccion_id; 
  
  if isRepetido = 0 then

    insert into leccion_usuario values(default, _leccion_id, _usuario_id);

  end if;
    
  call sp_progresoByUser(_usuario_id);
	
END$$


DELIMITER $$
drop PROCEDURE if exists sp_usuarioExperiencia_update;$$
CREATE PROCEDURE sp_usuarioExperiencia_update(_id int)  BEGIN
  
  declare _punto int default 10;

  update usuarios set experiencia = (select experiencia from usuarios where id = _id) + _punto
    where id = _id;
  
  select * from usuarios where _id;
	
END$$


DELIMITER $$
drop PROCEDURE if exists sp_usuarioQuitarVida;$$
CREATE PROCEDURE sp_usuarioQuitarVida(_id int)  BEGIN
  
  declare _vida int default 0;

  select vida into _vida from usuarios where id = _id;
  if _vida <> 0 then
    update usuarios set vida = _vida -1  where id = _id;
  end if;
  
  
  select * from usuarios where id = _id;
	
END$$





 select * from usuarios where 2;