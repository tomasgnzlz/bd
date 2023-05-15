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
-- 2. NO SE HACE. NO CAEN CURSORES
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