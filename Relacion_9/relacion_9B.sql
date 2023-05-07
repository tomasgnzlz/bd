-- Para la base de datos turRural:
-- 3. Queremos saber el código de las reservas hechas y anuladas este año, el código de casa
--    reservada, la fecha de inicio de estancia y la duración de la misma. También queremos que
--    se muestre el importe de la devolución en aquellas que hayan producido dicha devolución.
-- 4. Queremos mostrar un listado de todas las casas de la zona 1 en el que se muestre el nombre
--    de casa y el número de reservas que se han hecho para cada casa. Si una casa nunca se ha
--    reservado, deberá aparecer en el listado.
-- 5. Queremos elaborar un listado de casas en el que se muestre el nombre de zona y el nombre
--    de la casa. Ten en cuenta que de algunas zonas no tenemos todavía ninguna casa en el
--    sistema, queremos que se muestren estas zonas también.
use gbdturrural2015;
-- 3. Queremos saber el código de las reservas hechas y anuladas este año, 
--    el código de casa reservada, la fecha de inicio de estancia y la duración de la misma. 
--    También queremos que se muestre el importe de la devolución en aquellas que hayan producido dicha devolución.
delimiter $$
	drop procedure if exists ej3_9$$
	create procedure ej3_9()
	begin
		  select count(*) as nºEmpleados, departamentos.nomde
			from empleados
				join departamentos on empleados.numde = departamentos.numde
                -- where count(*) = 0 and count(*) >=1;
                group by departamentos.nomde; 
	end $$
delimiter ;
call ej3_9();
select * from departamentos;