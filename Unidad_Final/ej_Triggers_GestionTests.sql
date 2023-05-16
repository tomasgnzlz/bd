use gbdgestionatests;
-- 8. El profesorado también puede matricularse en nuestro centro pero no de las materias que
-- imparte. Para ello tendrás que hacer lo sigjuiente:
-- a. Añade el campo dni en la tabla de alumnado.
alter table alumnos
	add column dni char(9) default '000000000';
-- b. Añade la tabla profesorado (codprof, nomprof, ape1prof, ape2prof, dniprof).
create table profesorado(
	codprof int(11) not null,
    nomprof varchar(30) default null, 
    ape1prof varchar(30) default null, 
    ape2prof varchar(30) default null, 
    dniprof char(9) default '000000000',
		primary key (codprof)
);
-- c. Añade una clave foránea en materias ⇒ codprof references a profesorado (codprof).
alter table materias
	add column codprof int(11),
		add foreign key (codprof) references profesorado(codprof);
-- d. Introduce datos en las tablas y campos creados para hacer pruebas. --PORLOOTRO
-- 9. Comprueba que un profesor no se matricule de las materias que imparte.
-- before insert on matriculas
delimiter $$
create trigger registroTests before insert
	on matriculas
    for each row
    begin 	
		if new.codmateria = new.codprof then
			signal sqlstate '45000' set message_text = 'ERROR. Un profesor no puede matricularse de las materias que imparte';
		end if;
    end $$
delimiter ;

-- si el dni del alumno = dni profesor que imparte la materia de la matricula entonces provocar error ¿?¿?¿?
delimiter $$
create trigger registrodnis before insert
	on matriculas
    for each row
    begin 	
		if new.dni = new.dniprof then
			signal sqlstate '45000' set message_text = 'ERROR. El dni del alumno y del profesor son iguales. ';
		end if;
    end $$
delimiter ;

-- 10. La fecha de publicación de un test no puede ser anterior a la de creación.
drop trigger if exists compruebafechatest;
delimiter $$
create trigger compruebafechatest
	before insert on tests
for each row
begin
	if new.fecpublic < new.feccreacion then
		signal sqlstate '45000' set message_text = 'La fecha de publicación no puede ser anterior a la de creación';
	end if;
end $$
delimiter ;
-- 11. El alumnado no podrá hacer más de una vez un test (ya existe el registro de dicho test para el
-- alumno/a) si dicho test no es repetible (tests.repetible = 0|false).
drop trigger if exists compruebarepeticiontestsalumno;
delimiter $$
create trigger compruebarepeticiontestsalumno
	before insert on respuestas
for each row
begin
	if (select repetible from tests where codtest = new.codtest) = false and
	  (select count(*) from respuestas where codtest = new.codtest and numexped = new.numexped) > 0 then
		signal sqlstate '45000' set message_text = 'ERROR. No se puede repetir el test';
	end if;
end $$
delimiter ;
