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