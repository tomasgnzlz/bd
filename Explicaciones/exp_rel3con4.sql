-- FUNCIONES DE AGREGADO. 
use empresaclase;
-- ¿Cuantos empleados hay? 42
select count(*) -- , count(distinct numde) -- Cuenta celdas. 
	from empleados;
-- ¿Cuanto me cuesta al mes pagar a todos mis empleados?
select sum(salarem)
	from empleados;
-- ¿Cual es el salario maximo?
select max(salarem), min(salarem)
	from empleados;
-- ¿Cual es la media?
select avg(salarem)
	from empleados;
    
-- TODO JUNTO

select count(*) as numEmpleados, 
		sum(salarem) as totalSalario, 
        max(salarem) as salarioMaximo, 
        min(salarem) as salarioMinimo, 
        avg(salarem) as mediaSalario
	
	from empleados;
    
-- HACER GRUPOS. DE DEPTOS. 
select  numde, count(*) as numEmpleados,
		sum(salarem) as totalSalario, 
        max(salarem) as salarioMaximo, 
        min(salarem) as salarioMinimo, 
        avg(salarem) as mediaSalario
	
	from empleados
		group by numde;
        
-- rutina que devuelva el número de extensiones telefónicas que usa un departamento dado

delimiter $$
	drop function if exists numExtensiones;
	create function numExtensiones
		(numdepto int)
	returns int
	deterministic
	begin
		return (select count(distinct extelem)
				from empleados
				where numde = numdepto);

	end $$
delimiter ;

select nomde, numExtensiones(numde) -- si numExtensiones fuera un procedimiento, no se podría usar dentro de este select
	from departamentos -- O puedo hacer varios selects dentro de un procedimiento guardando lo que esto muestra en variables sets y devolver todo dentro de un procedimiento. 
		order by nomde;