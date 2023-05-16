use empresaclase;
-- 1. Comprueba que no podamos contratar a empleados que no tengan 16 años.
delimiter $$
create trigger emMayorEdad before insert
	on empleados
    for each row
    begin 
    -- SELECT timestampdiff(year,"2003-06-28", "2023-06-28");
	--         diff         año   fecantigua    fecfinal
		declare edad int;
		set edad = timestampdiff(year,new.fecnaem,curdate());
        if edad < 17 then
			signal sqlstate '45000' set message_text="ERROR, El empleado no cumple con la edad requerida";
		end if;
    end $$
delimiter ;
    
-- 2. Comprueba que el departamento de las personas que ejercen la dirección de los departamentos pertenezcan a dicho departamento.
-- 3. Añade lo que consideres oportuno para que las comprobaciones anteriores se hagan también
-- cuando se modifiquen la fecha de nacimiento de un empleado o al director/a de un departamento.
-- 4. Añade una columna numempleados en la tabla departamentos. En ella vamos a almacenar el número de empleados de cada departamento.
alter table departamentos
	add column  numempleados int default 0;

-- 5. Prepara un procecdimiento que para cada departamento calcule el número de empleados y guarde dicho valor en la columna creada en el apartado 4.
drop procedure if exists numempleadosDepto;
delimiter $$
create procedure numempleadosDepto()
begin
	/*select count(*), d.nomde
			from empleados e
				join departamentos d on e.numde = d.numde
				where e.numde = d.numde
		group by d.nomde;*/
        update departamentos
    set numempleados = (select count(*)
						from empleados
						where empleados.numde = departamentos.numde);
end $$
delimiter ;
-- 6. Prepara lo que consideres necesario para que cada trimestre se compruebe y actualice, 
-- en caso de ser necesario, el número de empleados de cada departamento.
-- drop event actualNumEmpleados;
delimiter $$
create event actualNumEmpleados
    on schedule
		every 1 quarter
    starts '2023/06/1'
	do
	begin
		call numempleadosDepto();
    end $$
delimiter ;


-- 7. Asegúrate de que cuando eliminemos a un empleado, se actualice el número de empleados del departamento al que pertenece dicho empleado.
delimiter $$
create trigger delEmNumEm after delete
	on empleados
    for each row
    begin 
		declare numeroempleadosDepto int;
		set numeroempleadosDepto = (
								select count(*)
									from empleados
									where empleados.numde = departamentos.numde
								);
        if new.numeroempleadosDepto > old.numeroempleadosDepto  then
			-- Si el número de departamentos es diferente, se cambia sino no
				update departamentos
					set numempleados = (
										select count(*)
											from empleados
											where empleados.numde = departamentos.numde
										);
		end if;
    end $$
delimiter ;
/*
update departamentos
    -- set numempleados = (select count(*) from empleados where numde = old.numde)
    set numempleados =  numempleados -1
    where numde = old.numde;
*/
-- ----------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
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
