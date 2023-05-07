-- Para la base de datos empresa_clase:
use empresaclase;
-- 1. Hallar el salario medio para cada grupo de empleados con igual comisión y para los que no la tengan, 
--    pero solo nos interesan aquellos grupos de comisión en los que haya más de un empleado.
select count(empleados.numem), empleados.salarem, empleados.comisem
	from empleados
    where empleados.comisem = empleados.comisem
		group by empleados.numem
		having count(empleados.numem) > 1;
    
-- 2. Para cada extensión telefónica, hallar cuantos empleados la usan y el salario medio de éstos. 
--    Solo nos interesan aquellos grupos en los que hay entre 1 y 3 empleados
select empleados.extelem,  count(*), avg(empleados.salarem) as Salario
	from empleados
    group by empleados.extelem
		having count(*) between 1 and 3;
    