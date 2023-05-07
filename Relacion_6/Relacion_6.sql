use empresaclase;
/*1. Para la base de datos “empresa_clase” obtener, dado el código de un empleado, la contraseña de
acceso formada por:
i. Inicial del nombre + 10 caracteres.
ii. Tres primeras letras del primer apellido + 5 caracteres.
iii. Tres primeras letras del segundo apellido (o “LMN” en caso de no tener 2o
apellido) + 5 caracteres.
iv. El último dígito del dni (sin la letra).*/

drop function if exists ej1_6 ;
delimiter $$
create function ej1_6(CodEmpleado int)
returns varchar(60)
deterministic
begin
	declare i varchar(60);
    declare ii varchar(60);
    declare iii varchar(60);
    declare iv varchar(60);
    
	select concat('', left(nomem, 1), '', 'aaaaaaaaaa') into i
			from empleados
            where empleados.numem = CodEmpleado;

	select concat('', left(ape1em, 1), '', 'bbbbb') into ii
			from empleados
            where empleados.numem = CodEmpleado;
            
	select concat('', ifnull(left(ape1em, 1), 'LMN'), '', 'ccccc') into iii
			from empleados
            where empleados.numem = CodEmpleado;
            
	select left(dniem, 8) into iv
			from empleados
            where empleados.numem = CodEmpleado;
            
	return (
			select concat('', i, '', ii, '',iii, '', iv) as Contraseña
            );
end $$
delimiter ;
-- call ej1_6(110);
select ej1_6(110) as Contraseña;



/*
2. Para la base de datos “BDAlmacen” obtener por separado el nombre, el primer apellido y el
segundo apellido de los proveedores.*/
use bdalmacen;
select proveedores.nomempresa
	from proveedores;

/*3. Obtener un procedimiento que obtenga el salario de los empleados incrementado en un 5%. El
formato de salida del salario incrementado debe ser con dos decimales.*/ --  ¿?¿?¿?¿ NO SE COMO HACERLO PARA TODOS LOS EMPLEADOS Y NO SOLO UNO DE ELLOS.
use empresaclase;
drop procedure if exists ej3_6;
delimiter $$
create procedure ej3_6(out salarioNormal decimal(7,2), out incrementoSalarial decimal(7,2))
begin 
	select empleados.salarem as SalarioNormal,  (empleados.salarem + (empleados.salarem*0.05) ) as SalarioIncrementado
		into salarioNormal, incrementoSalarial
			from empleados
            where empleados.numem = 110;
end $$
delimiter ;
call ej3_6(@salarioNormal, @incrementoSalarial);
select @salarioNormal, @incrementoSalarial;

select * from empleados;


-- 4. Prepara una función que determine si un valor que se pasa como parámetro es una fecha correcta o no.
-- 5. Para la base de datos “Empresa_clase” prepara un procedimiento que devuelva la edad de un empleado.
use empresaclase;
drop procedure if exists ej5_6;
delimiter $$
create procedure ej5_6(in NumeroEmpleado int,out numEmpleado int, out edadEmpleado int)
begin 
	select empleados.numem as NumeroEmpleado, datediff(curdate(), empleados.fecnaem) as AñosDelEmpleado
		into  numEmpleado, edadEmpleado
			from empleados
            where empleados.numem = NumeroEmpleado;
end $$
delimiter ;
call ej5_6(110,@numEmpleado, @edadEmpleado);
select @numEmpleado, @edadEmpleado;

-- 6. Para la base de datos “EMPRESA_CLASE” obtener el día que termina el periodo de prueba de un
-- empleado, dado su código de empleado. El periodo de prueba será de 3 meses.
select date_add(empleados.feciniem, interval 3 month) as FechaTerminaPeridoPrueba
	from empleados
    where empleados.numem=110;
    -- haría falta meter un nuevo empleado para comprobar que funciona. 
	
-- 7. Nuestro sistema MS Sql Server tiene como primer día de la semana el domingo. Cámbialo al
-- lunes. Obtén el nombre del primer día de la semana del sistema. ¿?¿?¿?¿?¿

-- 8. Obtener el nombre completo de los empleados y la fecha de nacimiento con los siguientes formatos:
-- a. “05/03/1978”
	select concat('', empleados.nomem, empleados.ape1em, ifnull(ape2em, '')) as NombreCompleto, 
		concat('',day(empleados.fecnaem) , '/0', month(empleados.fecnaem) , '/',year(empleados.fecnaem)) as FormatoSlicitado
		from empleados
		where empleados.numem=110;
        
-- b. 5/3/1978
	select concat('', empleados.nomem, empleados.ape1em, ifnull(ape2em, '')) as NombreCompleto, 
		concat('',day(empleados.fecnaem) , '/', month(empleados.fecnaem) , '/',year(empleados.fecnaem)) as FormatoSlicitado
		from empleados
		where empleados.numem=110;
        
-- c. 5/3/78
	select concat('', empleados.nomem, empleados.ape1em, ifnull(ape2em, '')) as NombreCompleto, 
		concat('',day(empleados.fecnaem) , '/', month(empleados.fecnaem) , '/',right( year(empleados.fecnaem),2 )) as FormatoSlicitado
		from empleados
		where empleados.numem=110;
        
-- d. 05-03-78
	select concat('', empleados.nomem, empleados.ape1em, ifnull(ape2em, '')) as NombreCompleto, 
		concat('',day(empleados.fecnaem) , '-0', month(empleados.fecnaem) , '-',right( year(empleados.fecnaem),2 )) as FormatoSlicitado
		from empleados
		where empleados.numem=110;
        
-- e. 05 Mar 1978
	select concat('', empleados.nomem, empleados.ape1em, ifnull(ape2em, '')) as NombreCompleto, 
		concat('',day(empleados.fecnaem) , ' ', left( monthname(empleados.fecnaem), 3 ) , ' ',year(empleados.fecnaem)) as FormatoSlicitado
		from empleados
		where empleados.numem=110;


-- 9. Obtener como resultado de la fecha de nacimiento el formato: “5 de marzo de 1978”
select concat('',day(empleados.fecnaem) , ' de ', monthname(empleados.fecnaem) , ' de ',year(empleados.fecnaem)) as FormatoSlicitado
	from empleados
    where empleados.numem=110;
    
-- 10. Añade una columna en la tabla empleados para el nombre de usuario y otra para la contraseña de acceso de los mismos.
-- 11. Los empleados solo pueden acceder al salario de ellos mismos, no al de sus compañeros. 
	-- Prepara un procedimiento que devuelva el salario del usuario actual. 
	-- Tendrás que comprobar que el usuario conectado coincida con el usuario de la tabla empleados.
-- 12. Utiliza lo que hicimos en el apartado 1 de esta actividad para almacenar los valores de la clave de los empleados.
-- 13. Igual que el apartado anterior, pero ahora los valores de la contraseña se almacenarán cifrados. Utiliza la función de cifrado de MySQL.