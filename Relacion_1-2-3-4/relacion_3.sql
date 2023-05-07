-- 1. Prepara un procedimiento almacenado que obtenga el salario máximo de la empresa.
-- 2. Prepara un procedimiento almacenado que obtenga el salario mínimo de la empresa.
-- 3. Prepara un procedimiento almacenado que obtenga el salario medio de la empresa.
-- 4. Prepara 1 procedimiento almacenado que obtenga el salario máximo, mínimo y medio del departamento “Organización”.
-- 5. Prepara un procedimiento almacenado que obtenga lo mismo que el del apartado
-- anterior pero de forma que podamos cambiar el departamento para el que se obtiene dichos resultados.
-- 6. Prepara un procedimiento almacenado que obtenga lo que se paga en salarios para un departamento en cuestión.¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿¿?¿?¿
-- 7. Prepara un procedimiento almacenado nos dé el presupuesto total de la empresa.
-- 8. Prepara un procedimiento almacenado que obtenga el salario máximo, mínimo y medio para cada departamento.
-- 9. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que hay en la empresa.
-- 10. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza un departamento.
-- 11. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza cada departamento.
use empresaclase; select * from empleados;
-- 1, 2, 3
delimiter $$
    drop procedure if exists ej_1;
    create procedure ej_1()
    begin
		  select max(empleados.salarem) 
          -- select min(empleados.salarem) 
          -- select avg(empleados.salarem)
			from empleados;
    end $$
delimiter ;
call ej_1;
-- 4. obtenga el salario máximo, mínimo y medio del departamento “Organización”.
delimiter $$
    drop procedure if exists ej_4$$
    create procedure ej_4()
    begin
		 select empleados.nomem, empleados.numde, 
				max(empleados.salarem) as salarioMaximo, 
				min(empleados.salarem) as salarioMinimo, 
				avg(empleados.salarem) as mediaSalario
			from empleados
				join departamentos on empleados.numde = departamentos.numde
            -- where departamentos.numde = 110
             where trim(departamentos.nomde) = 'ORGANIZACION'
				group by empleados.nomem, empleados.numde;
    end $$
delimiter ; 
call ej_4();

-- 5. 
delimiter $$
    drop procedure if exists ej_5$$
    create procedure ej_5( in nombreCentro varchar(60))
    begin
		 select 
				max(empleados.salarem) as salarioMaximo, 
				min(empleados.salarem) as salarioMinimo, 
				avg(empleados.salarem) as mediaSalario
			from empleados
				join departamentos on empleados.numde = departamentos.numde
		where trim(departamentos.nomde) = nombreCentro;
    end $$
delimiter ;
call ej_5('Organización');
-- 6. Prepara un procedimiento almacenado que obtenga lo que se paga en salarios para un departamento en cuestión.¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿¿?¿?¿
delimiter $$
    drop procedure if exists ej_6$$
    create procedure ej_6()
    begin
		select sum(empleados.salarem) as SumaSalarios
			from empleados
				join departamentos on empleados.numde = departamentos.numde
		where departamentos.numde = 110;
    end $$
delimiter ; 
call ej_6();

-- 7. Prepara un procedimiento almacenado nos dé el presupuesto total de la empresa.
delimiter $$
    drop procedure if exists ej_7$$
    create procedure ej_7()
    begin
		 select max(presude) as presupuestoMaximoEmpresa
			from departamentos;
    end $$
delimiter ; 
call ej_7();
-- 8. Prepara un procedimiento almacenado que obtenga el salario máximo, mínimo y medio para cada departamento.
delimiter $$
    drop procedure if exists ej8_3$$
    create procedure ej8_3()
    begin
		 select departamentos.nomde, max(presude), min(departamentos.presude), avg(departamentos.presude)
			from departamentos
            group by departamentos.nomde;
    end $$
delimiter ; 
call ej8_3();
-- 9. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que hay en la empresa.
delimiter $$
    drop procedure if exists ej9_3$$
    create procedure ej9_3()
    begin
		select  empleados.nomem as nomEmpleado,
				count(distinct empleados.extelem) as numExtDiferentes, 
				concat_ws('', empleados.nomem, ' ', empleados.extelem) as Nombre_Extension
			from empleados
				group by empleados.nomem, empleados.extelem;
    end $$
delimiter ; 
call ej9_3();
-- 10. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza un departamento.
delimiter $$
    drop procedure if exists ej10_3$$
    create procedure ej10_3()
    begin
		 select departamentos.nomde,  empleados.nomem, count(distinct empleados.extelem)
			from empleados
				join departamentos on empleados.numde = departamentos.numde
			where trim(departamentos.nomde)= 'FINANZAS'
            group by empleados.nomem, departamentos.nomde;
    end $$
delimiter ; 
call ej10_3();
-- 11. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza cada departamento.
use empresaclase;
delimiter $$
    drop procedure if exists ej11_3$$
    create procedure ej11_3()
    begin
		 select departamentos.nomde, empleados.nomem, count(distinct empleados.extelem), empleados.extelem as extencionTelefono
			from empleados
				join departamentos on empleados.numde = departamentos.numde
			group by empleados.nomem, departamentos.numde, empleados.extelem;
    end $$
delimiter ; 
call ej11_3();
