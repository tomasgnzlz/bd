use empresaclase;
-- 1. *Obtener por orden alfabético el nombre y los sueldos de los empleados con más de tres hijos.
delimiter $$
	drop procedure if exists ej1_4$$
	create procedure ej1_4 ()
	begin
		select empleados.nomem, empleados.salarem
			from empleados
		where empleados.numhiem > 3 
			order by empleados.nomem; 
	end $$
delimiter ;
call ej1_4();

/* 2. 
	Obtener la comisión, el departamento y el nombre de los empleados cuyo salario es inferior a 190.000 u.m., 
    clasificados por departamentos en orden creciente y por comisión en orden decreciente*/
delimiter $$
	drop procedure if exists ej2_4$$
	create procedure ej2_4()
	begin
		select  empleados.nomem as Empleados, 
		concat_ws('', empleados.numde, ' ', departamentos.nomde) as Departamentos, 
		empleados.comisem as ComisionPersonal
			from empleados
				join departamentos on empleados.numde = departamentos.numde
			where empleados.salarem < 19000.00
            order by departamentos asc, empleados.comisem desc;
	end $$
delimiter ;
call ej2_4();

-- 3. Hallar por orden alfabético los nombres de los deptos cuyo director lo es en funciones y no en propiedad.
delimiter $$
	drop procedure if exists ej3_4$$
	create procedure ej3_4 ()
	begin
		select departamentos.nomde  
			from departamentos	
				join dirigir on departamentos.numde = dirigir.numdepto
		where ifnull(dirigir.fecfindir, curdate()) >=curdate() 
				and dirigir.tipodir = 'F'
			order by departamentos.nomde asc;
	end $$
delimiter ;
select * from dirigir;

/*4. 
	Obtener un listín telefónico de los empleados del departamento 121 incluyendo el
	nombre del empleado, número de empleado y extensión telefónica. Ordenar
	alfabéticamente
*/
delimiter $$
	drop procedure if exists ej4_4$$
	create procedure ej4_4()
	begin
		select empleados.nomem, empleados.numem, empleados.extelem
			from empleados
				join departamentos on empleados.numde = departamentos.numde
		where departamentos.numde = 121 -- Esto se lo podría pasar como parametro y dependiendo del numde obtener dicha lista
            order by departamentos.nomde;
	end $$
delimiter ;
call ej4_4();

-- 5. Hallar la comisión, nombre y salario de los empleados con más de tres hijos,
--    clasificados por comisión y dentro de comisión por orden alfabético.
delimiter $$
	drop procedure if exists ej5_4$$
	create procedure ej5_4()
	begin
		select empleados.nomem, empleados.salarem, concat_ws('', ifnull(empleados.comisem, '0')) as comisionEmpleado
			from empleados
		where empleados.numhiem > 3
            order by empleados.nomem asc; 
	end $$
delimiter ;
call ej5_4();

 -- 6. Hallar por orden de número de empleado, el nombre y salario total (salario más comisión) 
 --    de los empleados cuyo salario total supere las 300.000 u.m. mensuales.
delimiter $$
	drop procedure if exists ej6_4$$
	create procedure ej6_4()
	begin
		select empleados.nomem, concat_ws('', ifnull(empleados.salarem, '0')) + concat_ws('', ifnull(empleados.comisem, '0')) as salarioTotal
			from empleados
            where empleados.salarem + empleados.comisem > 3000.00 -- Creo que quiso decir 3mil y no 30mil, xq es imposible
            order by empleados.numem asc;  
	end $$
delimiter ;
call ej6_4();

-- 7.Obtener los números de los departamentos en los que haya algún empleado cuya comisión supere al 20% de su salario.
delimiter $$
	drop procedure if exists ej7_4$$
	create procedure ej7_4()
	begin
		select concat_ws('', departamentos.numde, ' ', empleados.nomem) as Resultados
			from empleados
				join departamentos on empleados.numde = departamentos.numde
			where (empleados.comisem / empleados.salarem) > 0.2
            order by empleados.numem asc;  
	end $$
delimiter ;
call ej7_4();


/* 8. 
	Hallar por orden alfabético los nombres de los empleados tales que si se les da una
	gratificación de 100 u.m. por hijo el total de esta gratificación no supere a la décima
	parte del salario.*/
delimiter $$
	drop procedure if exists ej8_4$$
	create procedure ej8_4()
	begin
		select empleados.nomem
			from empleados
				where (empleados.comisem = (100 * empleados.numhiem)) <= salarem * 0.1
					order by empleados.nomem;   
	end $$
delimiter ;
call ej8_4();


/* 9. 
	Llamaremos presupuesto medio mensual de un depto. al resultado de dividir su presupuesto anual por 12. 
    Supongamos que se decide aumentar los presupuestos medios de todos los deptos en un 10% a partir del mes de octubre inclusive. 
    Para los deptos. cuyo presupuesto mensual anterior a octubre es de más de 500.000 u.m.
	Hallar por orden alfabético el nombre de departamento y su presupuesto anual total después del incremento.*/
delimiter $$
	drop procedure if exists ej9_4$$
	create procedure ej9_4 ()
	begin
		select departamentos.nomde as NombreDepartamento, ((((departamentos.presude/12)*0.1)*3)+departamentos.presude) as PresupuestoAnual
			from departamentos
		where (departamentos.presude/12) > 500
			order by departamentos.nomde asc;
	end $$
delimiter ;
call ej9_4();

/* 10.  Suponiendo que en los próximos tres años el coste de vida va a aumentar un 6%
		anual y que se suben los salarios en la misma proporción. Hallar para los empleados
		con más de cuatro hijos, su nombre y sueldo anual, actual y para cada uno de los
		próximos tres años, clasificados por orden alfabético.*/
delimiter $$
	drop procedure if exists ej10_4$$
	create procedure ej10_4()
	begin
		select empleados.nomem as Nombre, (empleados.salarem*12) as sueldoAnual,
			((empleados.salarem*1.06)*12) as SueldoSubida_1, 
             ((empleados.salarem*1.12)*12) as SueldoSubida_2,
              ((empleados.salarem*1.18)*12) as SueldoSubida_3
			from empleados
			where empleados.numhiem > 4
            order by empleados.nomem asc;
	end $$
delimiter ;
call ej10_4();

-- 15. Hallar los nombres de los empleados que no tienen comisión, clasificados de manera que aparezcan primero aquellos cuyos nombres son más cortos.
delimiter $$
	drop procedure if exists ej15_4$$
	create procedure ej15_4()
	begin
		select empleados.nomem, empleados.comisem
			from empleados
		where empleados.comisem = 0 or empleados.comisem is null -- Aqui le digo que me guarde los nombres de las personas que tengan tanto comision 0 o null.
			-- where coalesce(empleados.comisem, 0) = 0
			order by length(empleados.nomem),empleados.nomem;
	end $$
delimiter ;
call ej15_4();

-- 18. Hallar la diferencia entre el salario más alto y el más bajo
		select ( (max(empleados.salarem)) - (min(empleados.salarem)) ) as Diferencia_Salarial
			from empleados;



-- 19. Hallar el número medio de hijos por empleado para todos los empleados que no tienen más de dos hijos.
delimiter $$
	drop procedure if exists ej19_4$$
	create procedure ej19_4()
	begin
		select empleados.nomem,   avg(empleados.numhiem) as MediaHijosEmpleados
			from empleados
            where empleados.numhiem <= 2
				group by empleados.nomem
				order by empleados.nomem;
	end $$
delimiter ;
call ej19_4();

-- 21.Para cada extensión telefónica, hallar cuantos empleados la usan y el salario medio de éstos
delimiter $$
	drop procedure if exists ej21_4$$
	create procedure ej21_4()
	begin
		select count(*)  as nºEmUsandoExtelem,empleados.nomem, empleados.extelem,  avg(empleados.salarem) as salarioMedio
			from empleados
            where empleados.extelem =  (350) -- Se lo puedo pasar como parámetro tb.
				group by empleados.nomem
				order by empleados.nomem;
	end $$
delimiter ;
call ej21_4();

-- 24.Hallar por orden alfabético, los nombres de los empleados que son directores en funciones.
delimiter $$
	drop procedure if exists ej24_4$$
	create procedure ej24_4()
	begin
		select empleados.nomem 
			from empleados
				join dirigir on empleados.numde = dirigir.numdepto
            where dirigir.numempdirec = empleados.numem
				group by empleados.nomem
				order by empleados.nomem;
	end $$
delimiter ;
call ej24_4();


-- 25.A los empleados que son directores en funciones se les asignará una gratificación del
-- 5% de su salario. Hallar por orden alfabético, los nombres de estos empleados y la
-- gratificación correspondiente a cada uno.
delimiter $$
	drop procedure if exists ej25_4$$
	create procedure ej25_4()
	begin
		select empleados.nomem,  (empleados.salarem * 1.05) as nuevoSalario
			from empleados
				join dirigir on empleados.numde = dirigir.numdepto
            where dirigir.numempdirec = empleados.numem
				group by empleados.nomem, empleados.salarem
				order by empleados.nomem;
	end $$
delimiter ;
call ej25_4();


-- 29. Seleccionar los nombres de los departamentos que no dependan de ningún otro.
	select departamentos.nomde
		from departamentos
		where departamentos.depende is null;



-- 33.Obtener los nombres y salarios de los empleados cuyo salario coincide con la comisión de algún otro o la suya propia.
delimiter $$
	drop procedure if exists ej33_4$$
	create procedure ej33_4()
	begin
		select empleados.numde, empleados.salarem
			from empleados
            where empleados.salarem = empleados.comisem;
	end $$
delimiter ;
call ej33_4();



-- 34. Obtener por orden alfabético los nombres de los empleados que trabajan en el mismo
--     departamento que Pilar Gálvez o Dorotea Flor.
delimiter $$
	drop procedure if exists ej34_4$$
	create procedure ej34_4()
	begin
		select empleados.nomem, empleados.salarem
			from empleados
				join departamentos on empleados.numde = departamentos.numde
            -- where departamentos.numde = 111 and departamentos.numde = 120 CON EL Nº DE LOS DEPARTAMENTOS NO ME SALEN LOS EMPLEADOS.
			where trim(departamentos.nomde) = 'ORGANIZACION' 
            -- where trim(departamentos.nomde) = 'DIRECC.COMERCIAL'
				order by empleados.nomem;
	end $$
delimiter ;
call ej34_4();



-- 37.Hallar el centro de trabajo (nombre y dirección) de los empleados sin comisión.
delimiter $$
	drop procedure if exists ej37_4$$
	create procedure ej37_4()
	begin
		select centros.nomce as NombreCentro, centros.dirce as DireccionCentro, empleados.nomem as NombreEmpleados, empleados.comisem as Comision
			from empleados
				join departamentos on empleados.numde = departamentos.numde
					join dirigir on departamentos.numde = dirigir.numdepto
						join centros on departamentos.numce = centros.numce
			where empleados.comisem = 0 or empleados.comisem is null
            order by centros.nomce;
	end $$
delimiter ;
call ej37_4();

-- 38.Hallar cuantos empleados no tienen comisión en un centro dado.
delimiter $$
	drop procedure if exists ej38_4$$
	create procedure ej38_4()
	begin
		select centros.nomce as NombreCentro, empleados.nomem as NombreEmpleados, empleados.comisem as Comision
			from empleados
				join departamentos on empleados.numde = departamentos.numde
					join dirigir on departamentos.numde = dirigir.numdepto
						join centros on departamentos.numce = centros.numce
			where empleados.comisem = 0 or empleados.comisem is null 
				and trim(centros.nomce) = 'RELACION CON CLIENTES'
				order by centros.nomce;
	end $$
delimiter ;
call ej38_4();


-- 39.Hallar cuantos empleados no tienen comisión por cada centro de trabajo.
delimiter $$
	drop procedure if exists ej39_4$$
	create procedure ej39_4()
	begin
		select  count(empleados.nomem) as NºEmpleados
			from empleados
				join departamentos on empleados.numde = departamentos.numde
					join dirigir on departamentos.numde = dirigir.numdepto
						join centros on departamentos.numce = centros.numce
				where empleados.comisem = 0 or empleados.comisem is null 
					and trim(centros.nomce) = 'RELACION CON CLIENTES' -- Le paso el nombre de c/centro.
					order by centros.nomce;
	end $$
delimiter ;
call ej39_4();

-- EJEMPLO EVA FUNCIONES. 
delimiter $$
    drop function if exists ejemploEvaFunciones;
    create function ejemploEvaFunciones(empleado int)
        returns char(3)
        deterministic
    begin
    
        return(
			select extelem
				from empleados
			where numem= empleado
        );
    end $$
delimiter ;
select ejemploEvaFunciones();




