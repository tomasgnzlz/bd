use GBDturRural2015;

-- 1. Prepara una consulta que muestre, de la forma más eficientemente posible, 
	-- todos los datos de las reservas hechas en el primer trimestre de este año (entre 1/1/2021 y el 30 de marzo de 2021) 
    -- de más de 3 días de duración de la estancia. 
select *
	from reservas
    where reservas.fecreserva between '1/1/2021' and '30/03/2021'
		and reservas.numdiasestancia > 3;
        
        
-- 2. Prepara una consulta que muestre 
	-- las reservas que se han anulado este año 
    -- y el importe de la devolución (si se ha producido). 
    -- Nos interesa mostrar el código de la reserva y el nombre y apellidos del cliente (en una sola columna). 
-- Ten en cuenta que no todas las reservas anuladas han provocado devolución y que solo existirá la fila en devoluciones para aquellas reservas con devolución.
select reservas.codreserva as CódigoReserva,   
		 concat('',clientes.nomcli, ' ',clientes.ape1cli,' ',ifnull(clientes.ape2cli,'')) as DatosClientes,
			ifnull(devoluciones.importedevol,0) as ImporteDevolución -- para que coga aquellos que si tienen algo
	from reservas
		 join devoluciones  on reservas.codreserva = devoluciones.codreserva
			join clientes on reservas.codcliente = clientes.codcli
where reservas.fecanulacion > '2023-01-01';
	-- and devoluciones.importedevol > 0; -- esto no debría de ser así?
		
            
            

-- 3. Prepara un procedimiento que, dado un código de característica, 
	-- muestre el código, nombre,  población y tipo de casa (nombre del tipo) de las casas que tienen esa característica. 
    -- Muestra los resultados ordenados pos la población y para una misma población,  primero las que tengan más metros cuadrados. 
    
delimiter $$    
drop procedure if exists esimulacro_3_3$$
create procedure esimulacro_3_3(in codCaracteristica int)
begin 
		select casas.codcasa as CódigoCasa, casas.nomcasa as NombreCasa, casas.poblacion as Población, tiposcasa.nomtipo
			from casas
				join tiposcasa on casas.codtipocasa = tiposcasa.numtipo
					join caracteristicasdecasas on casas.codcasa = caracteristicasdecasas.codcasa
			where caracteristicasdecasas.codcaracter = codCaracteristica
				order by casas.poblacion, casas.m2 desc;
end $$ 
delimiter ;
call esimulacro_3_3('55');
select * from caracteristicasdecasas;


-- 4. Prepara un procedimiento que, dado un código de casa, muestre el listado de características (nombre de característica) que tiene esa casa 
--  (ten en cuenta que el campo tiene tendrá que ser 1) .
delimiter $$    
drop procedure if exists esimulacro_3_4$$
create procedure esimulacro_3_4(in CodigoCasa int)
begin 
		select casas.codcasa as CódigoCasa, caracteristicasdecasas.codcaracter as Caracteristica, caracteristicasdecasas.observaciones as Observaciones
			from casas
				join caracteristicasdecasas on casas.codcasa = caracteristicasdecasas.codcasa
			where casas.codcasa = CodigoCasa and caracteristicasdecasas.tiene ='1';
end $$ 
delimiter ;
call esimulacro_3_4('5');
select * from casas;



















-- EL 5 NO SE H
-- Prepara un procedimiento que, dado el código de una reserva, 
	-- devuelva el nombre del propietario de la casa que se ha reservado y su teléfono // correo electrónico (teléfono y correo juntos separados por //).
delimiter $$
drop procedure if exists esimulacro_3_6$$
create procedure esimulacro_3_6(in CodigoReserva int)
begin 
		select propietarios.nompropietario as NombrePropietario, concat('', propietarios.tlf_contacto,'//', propietarios.correoelectronico) as DatosContacto
			from reservas
				join casas on reservas.codcasa = casas.codcasa
					join propietarios on casas.codpropi = propietarios.codpropietario
			where reservas.codreserva = CodigoReserva;
end $$
delimiter ; 
call esimulacro_3_6('6');


--  EL DE ARRIBA ESTÁ MAL XQ EL EJERCICIO PIDE QUE DEVUELVA, POR LO QUE POR CADA COSA QUE SALE POR EL SELECT.
delimiter $$
drop procedure if exists esimulacro_3_62$$
create procedure esimulacro_3_62(in CodigoReserva int, out nombrepropietario varchar(100), out telefono_correo_Propietario varchar(75))
begin 
		select propietarios.nompropietario as NombrePropietario, concat('', propietarios.tlf_contacto,'//', propietarios.correoelectronico) as DatosContacto 
			into nombrepropietario, telefono_correo_Propietario
			from reservas
				join casas on reservas.codcasa = casas.codcasa
					join propietarios on casas.codpropi = propietarios.codpropietario
			where reservas.codreserva = CodigoReserva;
end $$
delimiter ;

call esimulacro_3_62('6', @nombrepropietario, @telefono_correo_Propietario);
select @nombrepropietario, @telefono_correo_Propietario;
