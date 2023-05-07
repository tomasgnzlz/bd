use empresaclase; -- Le estoy diciendo la bbdd se la cual tiene que hacer las consultas. 
/*
	Para la BD Empresa_clase descargada de la plataforma obtener las siguientes consultas:
	1. Obtener todos los datos de todos los empleados.
	2. Obtener la extensión telefónica de “Juan López”.
	3. Obtener el nombre completo de los empleados que tienen más de un hijo.
	4. Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.
	5. Obtener el nombre completo y en una sola columna de los empleados sin comisión.
	6. Obtener la dirección del centro de trabajo “Sede Central”.
	7. Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
	8. Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.
	9. Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en
	nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).
	10. Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en
	nuestra empresa entre 1 y tres años. (Añade filas nuevas para poder comprobar que tu consulta funciona).
	11. Prepara un procedimiento almacenado que ejecute la consulta del apartado 1 y otro que ejecute la del apartado 5.
	12. Prepara un procedimiento almacenado que ejecute la consulta del apartado 2 de forma que nos sirva
	para averiguar la extensión del empleado que deseemos en cada caso.
	13. Prepara un procedimiento almacenado que ejecute la consulta del apartado 3 y otro para la del
	apartado 4 de forma que nos sirva para averiguar el nombre de aquellos que tengan el número de hijos que deseemos en cada caso.
	14. Prepara un procedimiento almacenado que, dado el nombre de un centro de trabajo, nos devuelva su dirección.
	15. Prepara un procedimiento almacenado que ejecute la consulta del apartado 7 de forma que nos sirva
	para averiguar, dada una cantidad, el nombre de los departamentos que tienen un presupuesto superior a dicha cantidad.
	16. Prepara un procedimiento almacenado que ejecute la consulta del apartado 8 de forma que nos sirva
	para averiguar, dada una cantidad, el nombre de los departamentos que tienen un presupuesto igual o superior a dicha cantidad.
	17. Prepara un procedimiento almacenado que ejecute la consulta del apartado 9 de forma que nos sirva
	para averiguar, dada una fecha, el nombre completo y en una sola columna de los empleados que llevan trabajando con nosotros desde esa fecha.
	18. Prepara un procedimiento almacenado que ejecute la consulta del apartado 10 de forma que nos sirva
	para averiguar, dadas dos fechas, el nombre completo y en una sola columna de los empleados que
	comenzaron a trabajar con nosotros en el periodo de tiempo comprendido entre esas dos fechas.
	19. Prepara un procedimiento almacenado que ejecute la consulta del apartado 10 de forma que nos sirva
	para averiguar, dadas dos fechas, el nombre completo y en una sola columna de los empleados que
	comenzaron a trabajar con nosotros fuera del periodo de tiempo comprendido entre esas dos fechas.
*/
-- 1.
select * -- * siginifca todo
	from empleados; -- Con esto le digo de que tabla de la bbdd coga todos los datos.
    
-- 2.
select empleados.extelem -- De esta manera hago la consulta de una tabla pero de una columna en contreto, eso es lo que hace el .extelem
	from empleados
    where nomem='Juan' and ape1em='López';
    
-- 3. 
select empleados.nomem, empleados.ape1em
	from empleados
    where empleados.numhiem >= 1;
    
-- 4.
select concat_ws('', nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as nomCompleto
	from empleados
		where empleados.numhiem between 1 and 3;
        
-- 5. 
select concat_ws('', nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as nomCompleto
	from empleados
		where empleados.comisem = 0;
        
-- 6. 
select centros.dirce
	from centros
		where nomce= 'Sede Central'; -- La sentencia está bien, pero está escrito con espacios en blanco en diff posisicones, xqloque no nos saldrá ningun ejercicio.
        
-- 7.
select departamentos.nomde
	from departamentos
		where departamentos.presude >6000;
        
-- 8. 
select departamentos.nomde
	from departamentos
		where departamentos.presude >6000;

-- 9. 
select concat_ws('', nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as empleadosAntiguos
	from empleados
		where datediff(curdate(), fecinem) > 365;
        
-- 10. 
select concat_ws('', nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as empleadosAntiguos
	from empleados
		where datediff(curdate(), fecinem) > 365 and datediff(curdate(), fecinem) > 1095 ;
        
-- 11.
	-- 11.1
delimiter $$
	drop procedure if exists ej_11;
	create procedure ej_11 
	begin
			select *
				from empleados;
    end $$
delimiter ;
	-- 11.2
delimiter $$
	drop procedure if exists ej_11_2;
	create procedure ej_11_2 
	begin
			select concat_ws('', nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as nomCompleto
				from empleados
					where empleados.comisem = 0;
    end $$
delimiter ;

-- 12. 
delimiter $$
	drop procedure if exists ej_12;
	create procedure ej_12(in nomem, in ape1em)
	begin
		select empleados.extelem 
			from empleados
				where empleados.nomem=nomem and empleados.ape1em=ape1em;
    end $$
delimiter ;

-- 13. 
	-- 13.1
delimiter $$
	drop procedure if exists ej_13_1;
	create procedure ej_13_1(in numhiem int)
	begin
		select empleados.nomem, empleados.ape1em
			from empleados
				where empleados.numhiem = numhiem;
    end $$
delimiter ;
	-- 13.2
delimiter $$
	drop procedure if exists ej_13_2;
	create procedure ej_13_2(in numhiemMin int, in numhiemMax int)
	begin
		select empleados.nomem, empleados.ape1em
			from empleados
				where empleados.numhiemMin = numhiem between numhiemMax;
    end $$
delimiter ;

-- 14. 
delimiter $$
	drop procedure if exists ej_14;
	create procedure ej_14(in nomce varchar(20))
	begin
		select centros.dirce
			from centros
				where centros.nomce = nomce;
    end $$
delimiter ;

-- 15. 

delimiter $$
	drop procedure if exists ej_15;
	create procedure ej_15(in presude decimal(10,2))
	begin
		select departamentos.nomde
			from departamentos
				where departamentos.presude > presude;
    end $$
delimiter ;        
        

-- 16. 
delimiter $$
	drop procedure if exists ej_16;
	create procedure ej_16(in presude decimal(10,2))
	begin
		select departamentos.nomde
			from departamentos
				where departamentos.presude >= presude;
    end $$
delimiter ; 

-- 17. 
delimiter $$
	drop procedure if exists ej_17;
	create procedure ej_17(in feciniem date )
	begin
		select concat_ws('', nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as empleadosAntiguos2
			from empleados
				where empleados.fecinem <= fecinem;
    end $$
delimiter ;     
        

-- 18. 
delimiter $$
	drop procedure if exists ej_17;
	create procedure ej_17(in feciniem_1 date,in feciniem_2 date  )
	begin
		select concat_ws('', nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as empleadosAntiguos2
			from empleados
				where empleados.fecinem between feciniem_1 and feciniem_2;
    end $$
delimiter ;     


-- 19.
delimiter $$
	drop procedure if exists ej_17;
	create procedure ej_17(in feciniem_1 date,in feciniem_2 date  )
	begin
		select concat_ws('', nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as empleadosAntiguos2
			from empleados
				where empleados.fecinem < feciniem_1 or empleados.fecinem > feciniem_2;
    end $$
delimiter ;     