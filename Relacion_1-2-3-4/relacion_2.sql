-- 	EL 1 Y 2 NO SE HACEN.
-- 3. Obtener todos los datos de todos los empleados y el nombre del departamento al que pertenecen.
-- 4. Obtener la extensión telefónica y el nombre del centro de trabajo de “Juan López”.
-- 5. Obtener el nombre completo y en una sola columna de los empleados del departamento “Personal” y “Finanzas”.
-- 6. Obtener el nombre del director actual del departamento “Personal”.
-- 7. Obtener el nombre de los departamentos y el presupuesto que están ubicados en la “SEDE CENTRAL”.
-- 8. Obtener el nombre de los centros de trabajo cuyo presupuesto esté entre 100000 € y 150000 €.
-- 9. Obtener las extensiones telefónicas del departamento “Finanzas”. No deben salir extensiones repetidas.
-- 10. Obtener el nombre completo y en una sola columna de todos los directores que ha tenido el departamento cualquiera.
-- 11. Como el apartado 2, pero, ahora, generalízalo para el empleado que queramos en cada caso.
-- 12. Como el apartado 3 pero generalízalo para que podamos buscar los empleados de un solo departamento.
-- 13. Como el apartado 4. pero generalízalo para buscar el director del departamento que queramos en cada caso.
-- 14. Como el apartado 5 pero generalízalo para buscar por el centro que queramos.
-- 15. Como el apartado 6 pero generalizado para poder buscar el rango que deseemos.
-- 16. Como el apartado 7 pero generalizado para poder buscar las extensiones del departamento que queramos.
use empresaclase; select * from departamentos;
-- 3. 
select em.nomem, dep.nomde
	from empleados em 
		join departamentos dep on em.numde = dep.numde;
-- 4. 

delimiter $$
    drop procedure if exists ej_4;
    create procedure ej_4(in nomem varchar(30), in ape1em varchar(30)) -- Acordarme siempre de poner el tipo de dato que voy a introducir.
    begin
       select em.extelem as extencTel, c.nomce as nombreCentro
			from empleados em
				join departamentos dep on em.numde = dep.numde
				join centros c on dep.numce = c.numce
			where em.nomem = nomem and em.ape1em=ape1em;
    end $$
delimiter ;

call ej_4('Juan','López');


-- 5. Obtener el nombre completo y en una sola columna de los empleados del departamento “Personal” y “Finanzas”.
delimiter $$
    drop procedure if exists ej_5;
    create procedure ej_5(in nomdepto varchar(60))
    begin
       select concat_ws('',em.nomem,' ', em.ape1em,' ', ifnull(ape2em,' '))
			from empleados em
				join departamentos dep on em.numde = dep.numde
			where dep.nomde =nomdepto;
    end $$
delimiter ;

-- 6. Obtener el nombre del director actual del departamento “Personal”.
select em.nomem
	from empleados em
		join dirigir dir on em.numem = dir.numempdirec
		join departamentos dep on dir.numdepto = dep.numde
	where dep.nomde ='Personal';

-- 7. Obtener el nombre de los departamentos y el presupuesto que están ubicados en la “SEDE CENTRAL”.
DROP PROCEDURE IF EXISTS ejer_7;
DELIMITER $$
CREATE PROCEDURE ejer_7()
BEGIN
	SELECT departamentos.nomde, departamentos.presude
    FROM departamentos join centros 
		on departamentos.numce = centros.numce
    WHERE trim(centros.nomce) = 'SEDE CENTRAL'; 
END $$
DELIMITER ;
call ejer_7;
-- 8. Obtener el nombre de los centros de trabajo cuyo presupuesto esté entre 100000 € y 150000 €.
select  departamentos.nomde, departamentos.presude, centros.nomce, centros.numce
	from departamentos	
		join centros on departamentos.numce = centros.numce
	where departamentos.presude between 100000 and 150000 ;
    
-- 9. Obtener las extensiones telefónicas del departamento “Finanzas”. No deben salir extensiones repetidas. 

delimiter $$
drop procedure if exists ejereeeee$$
create procedure ejereeeee()
begin
	select departamentos.nomde, departamentos.numde, empleados.extelem
	from departamentos
		join empleados on departamentos.numde = empleados.numde
	where trim(departamentos.nomde) = 'Finanzas';
end $$
delimiter ;
call ejereeeee();

-- 10. Obtener el nombre completo y en una sola columna de todos los directores que ha tenido el departamento cualquiera.

DROP PROCEDURE IF EXISTS ejer_5_2_10;
DELIMITER $$
CREATE PROCEDURE ejer_5_2_10(in nombredepto VARCHAR(60))
BEGIN
	select CONCAT(empleados.ape1em, ifnull(concat(' ', empleados.ape2em), ''),', ',  empleados.nomem)
	from departamentos 
		join dirigir on departamentos.numde = dirigir.numdepto
			join empleados on empleados.numem = dirigir.numempdirec
	where departamentos.nomde =nombredepto
		and ifnull(dirigir.fecfindir,curdate()) >= curdate();
END $$
DELIMITER ;
call ejer_5_2_10('Finanzas');


-- 12. Como el apartado 3 pero generalízalo para que podamos buscar los empleados de un solo departamento.
DROP PROCEDURE IF EXISTS ejer_5_2_10;
DELIMITER $$
CREATE PROCEDURE ejer_5_2_10(in nombredepto VARCHAR(60))
BEGIN
	select em.nomem, dep.nomde
	from empleados em 
		join departamentos dep on em.numde = dep.numde 
	where trim(dep.nomde)= nombredepto;
    
END $$
DELIMITER ;
call ejer_5_2_10('Finanzas');
    
-- 4. Obtener la extensión telefónica y el nombre del centro de trabajo de “Juan López”.    
-- 13. Como el apartado 4. pero generalízalo para buscar el director del departamento que queramos en cada caso.

delimiter $$
    drop procedure if exists ej_4;
    create procedure ej_4(in nombredepto varchar(60))
    begin
       select em.nomem, em.ape1em
		from empleados em
			join dirigir dir on em.numem = dir.numempdirec
				join departamentos dep on dir.numdepto = dep.numde
		where trim(dep.nomde)= nombredepto;
    end $$
delimiter ;
call ej_4('Finanzas');



-- 15. Como el apartado 6 pero generalizado para poder buscar el rango que deseemos.
delimiter $$
    drop procedure if exists ej_4;
    create procedure ej_4(in rangoUno decimal(10,2), rangoDos decimal(10,2))
    begin
       select departamentos.nomde, departamentos.presude, centros.nomce, centros.numce
			from departamentos
				join centros on departamentos.numce = centros.numce
			-- where departamentos.presude between 100000 and 150000;
            where departamentos.presude between rangoUno and rangoDos;
    end $$
delimiter ;
call ej_4(100000,150000);


-- 16. Como el apartado 7 pero generalizado para poder buscar las extensiones del departamento que queramos.
delimiter $$
drop procedure if exists ejereeeee$$
create procedure ejereeeee(in nombredepto varchar(60))
begin
	select departamentos.nomde, departamentos.numde, empleados.extelem
	from departamentos
		join empleados on departamentos.numde = empleados.numde
	where trim(departamentos.nomde)= nombredepto;
end $$
delimiter ;
call ejereeeee('Finanzas'); 