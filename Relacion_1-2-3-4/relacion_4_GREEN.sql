use empresaclase;
-- 16. Hallar cuántos departamentos hay y el presupuesto anual medio de ellos.
	select departamentos.numde as CódigoDepartamento, avg(departamentos.presude) as PresupuestoAnualMedio
		from departamentos
			group by numde;
        
        
-- 17. Hallar el salario medio de los empleados cuyo salario no supera en más de un 20% al salario mínimo de los empleados que tienen algún hijo 
--     y su salario medio por hijo es mayor que 100.000 u.m.
	select empleados.nomem as NombreEmpleados ,round( avg(empleados.salarem), 3 ) as SalarioMedio
		from empleados
        where empleados.numhiem >= 1 
			and (empleados.salarem * empleados.numhiem) >=100.000
				group by empleados.nomem ,empleados.salarem
		having ( avg(empleados.salarem)*0.2 ) < min(empleados.salarem);
            
-- 20. Hallar el salario medio para cada grupo de empleados con igual comisión y para los que no la tengan.
	select empleados.salarem as SalarioEmpleados, empleados.comisem
		from empleados
        where empleados.salarem >= some (select empleados.salarem from empleados);
        
-- 22. Para los departamentos cuyo salario medio supera al de la empresa, hallar cuantas extensiones telefónicas tienen.
	select count(empleados.extelem) as nºExtensionesTelefonicas
		from departamentos
			join empleados on departamentos.numde = empleados.numde
		where departamentos.presude >=(select max(departamentos.presude) from departamentos);
        
-- 23. Hallar el máximo valor de la suma de los salarios de los departamentos.
	select count(empleados.numde) as numeroEmpleadosDeptos, sum(empleados.salarem) as SumaSalarario
		from departamentos
			join empleados on departamentos.numde = empleados.numde
		where departamentos.numde = 110;
            
            

