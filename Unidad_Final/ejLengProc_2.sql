use empresaclase;
-- 1. 
drop procedure if exists listadosueldo;
delimiter $$
create procedure listadosueldo ()
begin 
	select empleados.nomem,
							case 
								when empleados.salarem < 800 then "Menos de 800€"
								when empleados.salarem between 800 and  1000 then "Entre 800€-1000€"
								when empleados.salarem between 1000 and 1200 then "Entre 1000€-1200€"
								when empleados.salarem between 1200 and 1500 then "Entre 1200€-1500€"
								when empleados.salarem between 1500 and 1800 then "Entre 1500€-1800€"
								else "Más de 1800€"
							end as Salarios
		from empleados;
end $$
delimiter ;
call listadosueldo();
-- 2. 
drop procedure if exists listadoDeptos;
delimiter $$
create procedure listadoDeptos ()
begin 
	select case 
				when empleados.comisem is null or empleados.comisem = 0 then concat('El empleado ', numem, ' no tiene comision')
				else concat('El empleado ', numem, ' si tiene comision')
			end as ComisionEmpleados
			from empleados;
end $$
delimiter ;
call listadoDeptos();
-- 3. 
drop procedure if exists listadoDeptos_2;
delimiter $$
create procedure listadoDeptos_2 ()
begin 
	set var=(select empleados.nomem,
							case 
								when empleados.salarem < 800 then "Menos de 800€"
								when empleados.salarem between 800 and  1000 then "Entre 800€-1000€"
								when empleados.salarem between 1000 and 1200 then "Entre 1000€-1200€"
								when empleados.salarem between 1200 and 1500 then "Entre 1200€-1500€"
								when empleados.salarem between 1500 and 1800 then "Entre 1500€-1800€"
								else "Más de 1800€"
							end
			from empleados);
	select concat('Departamento: ',departamentos.nomde,'', var)
		from departamentos;
end $$
delimiter ;
call listadoDeptos_2();

/*
Los empleados de nuestra base de datos se conectarán al sistema utilizando un nombre de usuario y una
contraseña que quedarán almacenadas en la tabla empleados. Añade dichos campos (nomuserem y
contrasem).
Inicialmente tanto el nombre de usuario como la contraseña serán el nombre y el primer apellido (sin
espacios en blanco). Prepara un procedimiento almacenado que, mediante el uso de cursores inicalize
todos los nombres de usuario y contraseñas.
7. Prepara un procedimiento almacenado que iguale todas las contraseñas al nombre de usuario.
*/


drop procedure if exists nomser;
delimiter $$
create procedure nomser()
begin
		declare nomser varchar(60);
		set nomser=( select lower(concat(nomem,ape1em,ifnull(ape2em,''))) as nomser from empleados );
        -- Una vez tengo la cadena de como sería el nombre de usuario debería de meterlo en la tabla correspondiente
        -- Previamente se han creado las columnas nomuserem y contrasem en la tabla empelados, donde como datos deberían de estar
        -- su nombre y apellidos juntos sin espacios como nombre de usuario y como contraseña
        update empleados
			set nomuserem = nomser and contrasem = nomser;
end $$
delimiter ;

-- --------------------------
DROP PROCEDURE IF EXISTS nomser;
DELIMITER $$
CREATE PROCEDURE nomser()
BEGIN
    DECLARE nomser VARCHAR(60);
    SELECT LOWER(CONCAT(nomem, ape1em, IFNULL(ape2em, ''))) INTO nomser FROM empleados;    
    -- Actualizar los campos nomuserem y contrasem con el valor de nomser
    UPDATE empleados SET nomuserem = nomser, contrasem = nomser;
END $$
DELIMITER ;


/*
8. Cuando damos de alta un nuevo empleado habrá que asignarle un nombre de usuario y contraseña al
nuevo usuario. 
Prepara un procedimiento que busque que no exista ese nombre de usuario, en caso
afirmativo se almacenará el usuario y la contraseña elegidas, caso contrario mostrará un mensaje por
pantalla indicando que el nombre de usuario ya existe para que busquemos otro.
*/
drop procedure if exists daralta;
delimiter $$
create procedure daralta (in nom varchar(30)) -- le paso el nombre que quiiero saber si existe o no.
begin
	declare existe boolean;
    declare busca varchar(60);
    -- inicializo la variable como falso
    set existe = false;
    set busca = ( select * 	from empleados where empleados.nomem = nom );
    if busca = false then
		select concat('El nombre: ', nom , ' no existe en la bbdd');
        -- realizaría la insersion del empleado con ese nombre
	else
		select concat('El nombre: ', nom , 'existe en la bbdd. Busca otro');
	end if;
end $$
delimiter ;

/*
10. Prepara un procedimiento almacenado que, dado un número de departamento, obtenga un listado con el
nombre del director de dicho departamento y el nombre de los departamentos que dependan de él y el de
sus directores. En caso de que no exista ningún departamento que dependa del departamento dado,
mostrar su director y un mensaje indicando que no existen departamentos dependientes.
*/
drop procedure if exists listado;
delimiter $$
create procedure listado (in num int) -- le paso el nº del depto que quiero.  
begin
	
end $$
delimiter ;




