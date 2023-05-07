use GBDturRural2015;
-- 1. Prepara una consulta que muestre, de la forma más eficientemente posible, 
--    todos los datos de las casas con capacidad de entre 4 y 6 personas de la provincia de Sevilla.
select *
	from casas
	where casas.minpersonas between 4 and 6 
			and trim(casas.provincia) = 'Sevilla';
    
-- 2.Prepara una consulta que muestre las reservas que se han anulado este año y el importe de la
-- devolución (si se ha producido). 
-- Nos interesa mostrar el código de la reserva y el nombre y apellidos del cliente (en una sola columna).
-- Ten en cuenta que no todas las reservas anuladas han provocado devolución y que solo existirá 
-- la fila en devoluciones para aquellas reservas con devolución.
    
select reservas.codreserva, 
	   concat('',clientes.nomcli, ' ',clientes.ape1cli,' ',ifnull(clientes.ape2cli,'')) as datosDevoluciones,
	    devoluciones.importedevol as Devoluciones
	from reservas
		join clientes on reservas.codcliente = clientes.codcli
			join devoluciones on reservas.codreserva = devoluciones.codreserva
	where ifnull(devoluciones.importedevol, 0) > 0
		and reservas.fecanulacion > '2023-01-01';
        
    
-- 3. Prepara un procedimiento que, dado un código de característica, muestre el código de casa, nombre,
-- población y tipo de casa (nombre del tipo) de las casas que tienen esa característica. 
-- Queremos mostrar los datos por poblaciones y, dentro de una población, las más caras (precio base) primero.
delimiter $$
drop procedure if exists esimulacro_2_3$$
create procedure esimulacro_2_3(in codCaracteristicaCasa int)
begin 
	select casas.codcasa as CodigoCasa, casas.nomcasa as NombreCasa, casas.poblacion as Población, tiposcasa.nomtipo as TipoCasa
		from casas
			join caracteristicasdecasas on casas.codcasa = caracteristicasdecasas.codcasa
				join tiposcasa on casas.codtipocasa = tiposcasa.numtipo
		where caracteristicasdecasas.codcaracter = codCaracteristicaCasa
			order by casas.poblacion, casas.preciobase desc;
end $$
delimiter ;
call esimulacro_2_3('89');

-- 4. Prepara un procedimiento que, dado un código de zona, muestre el listado de las casas de esa zona.
-- Se mostrará en el listado el nombre de la casa y la población.
delimiter $$
drop procedure if exists esimulacro_2_4$$
create procedure esimulacro_2_4(in codigoZona int)
begin 
	select casas.nomcasa as NombreCasa, casas.poblacion
		from casas
	where casas.codzona = codigoZona;
end $$
delimiter ;
call esimulacro_2_4('6');


-- 5. EL 5 NO SE HACE


-- 6. Prepara un procedimiento que, dado el código de una reserva, 
-- devuelva el número de teléfono del cliente que ha hecho dicha reserva y su nombre completo (todo junto). 
delimiter $$
drop procedure if exists esimulacro_2_6$$
create procedure esimulacro_2_6(in codigoReserva int)
begin 
	select clientes.tlf_contacto as TelefonoCliente, concat(' ', clientes.nomcli,' ',clientes.ape1cli,' ', ifnull(ape2cli,' ')) as DatosCliente
		from clientes
			join reservas on clientes.codcli = reservas.codcliente
		where reservas.codreserva = codigoReserva;
end $$
delimiter ;
call esimulacro_2_6('6');


--  EL DE ARRIBA ESTÁ MAL XQ EL EJERCICIO PIDE QUE DEVUELVA, POR LO QUE POR CADA COSA QUE SALE POR EL SELECT.
drop procedure if exists esimulacro_2_62;
delimiter $$
create procedure esimulacro_2_62(in codigoReserva int, out telefonoCliente char(13), out datosClientes varchar(75))
begin 
	select clientes.tlf_contacto, 
			concat(' ', clientes.nomcli,' ',clientes.ape1cli,' ', ifnull(ape2cli,' '))
		into telefonoCliente, datosClientes
		from clientes
			join reservas on clientes.codcli = reservas.codcliente
		where reservas.codreserva = codigoReserva;
end $$
delimiter ;

call esimulacro_2_62('6', @telefonoCliente, @datosClientes); 
select @telefonoCliente, @datosClientes;
