use empresaclase;
-- 1. Prepara una rutina que, dado el número de un departamento, devuelva el presupuesto del mismo.
delimiter $$
    drop procedure if exists ej_A $$ -- Uso el dolar porque lo he puesto como delimitador.
    create procedure ej_A(in numdepto int) -- Creo la variable donde he de decirle el departamento del que quiero conocer el presupuesto.  
    begin
       select departamentos.presude as PresuDeptos -- Cuando se vayan a mostrar los resultados la tabla en la que se muestren tendrá el nombre 'PresuDeptos'
          from departamentos
		  where departamentos.numde=numdepto;
    end $$
delimiter ;
call ej_A(110); -- Pongo el numero del departamento del que quiero conocer su presupuesto.



-- 2. Prepara una rutina que, dado el número de un empleado, nos devuelva:
	--  · la fecha de ingreso en la empresa.
    --  · el nombre de su director/a.
delimiter $$
    drop procedure if exists ej_B $$ 
    create procedure ej_B(in numEmp int) 
    begin
       -- select concat_ws('', empleados.fecinem) -- Esto solo me devolvería la fecha en la que un determinado empleado ingresa a la empresa.
		select empleados.fecinem, dirigir.numempdirec
			from empleados 
				join dirigir on empleados.numde= numempdirec
			where empleados.numem=numEmp;
    end $$
delimiter ;

call ej_B(100); -- Pongo el numero del departamento del que quiero conocer su fecha de ingreso como el nombre de su director. 











