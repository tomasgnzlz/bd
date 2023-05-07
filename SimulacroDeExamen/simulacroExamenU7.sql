/*LO PRIMERO ES QUE HAY QUE SABER QUE LA BASE DE DATOS REGISTRA TODAS LAS VENTAS DE UNA SERIE DE ARTICULOS, NO ARTICULOS, SINO LAS VENTAS DE LOS MISMOS QUE PUEDEN SERVIR PARA HACER ESTUDIOS DEL MERCADO.*/

use ventapromoscompleta;
-- 1. Queremos saber el importe de las ventas de artículos a cada uno de nuestros clientes (muestra el nombre). 
--    Queremos que cada cliente se muestre una sola vez y que aquellos a los que hayamos vendido más se muestren primero.

select clientes.codcli as CódigoCliente ,clientes.nomcli as nombreCliente, sum(articulos.precioventa) as ImporteTotal 
	from clientes
		join ventas on clientes.codcli = ventas.codcli
			join detalleventa on ventas.codventa = detalleventa.codventa
				join articulos on detalleventa.refart = articulos.refart
	group by clientes.nomcli, clientes.codcli 
		order by sum(articulos.precioventa) desc; -- ESTO HACE QUE SALGAN PRIMERO AQUELLOS QUE 
	
    



-- 2. Muestra un listado de todos los artículos vendidos, queremos mostrar la descripción del artículo 
--    y entre paréntesis la descripción de la categoría a la que pertenecen 
--    y la fecha de la venta con el formato “march - 2016, 1 (tuesday)”. 
--    Haz que se muestren todos los artículos de la misma categoría juntos.

	select articulos.refart as CódigoArticulos, articulos.nomart as NombreArticulo, 
		concat('', articulos.desart,'(',categorias.descat,')') as DescripcionesArt,
			concat('', monthname(ventas.fecventa),' - ',year(ventas.fecventa),', ', day(ventas.fecventa),'(',dayname(ventas.fecventa),')' ) as FechaVenta
		from clientes
			join ventas on clientes.codcli = ventas.codcli
				join detalleventa on ventas.codventa = detalleventa.codventa
					join articulos on detalleventa.refart = articulos.refart
						join categorias on articulos.codcat = categorias.codcat
		order by categorias.nomcat;


-- 3. Obtener el precio medio de los artículos de cada promoción (muestra la descripción de la promoción) del año 2012. (Se usará en el ejercicio 7).

	/*select articulos.refart as CódigoArticulos, articulos.nomart as NombreArticulo, avg(catalogospromos.precioartpromo) as media, promociones.despromo 
		from clientes
			join ventas on clientes.codcli = ventas.codcli
				join detalleventa on ventas.codventa = detalleventa.codventa
					join articulos on detalleventa.refart = articulos.refart
						join categorias on articulos.codcat = categorias.codcat
							join catalogospromos on articulos.refart = catalogospromos.refart
								join promociones on catalogospromos.codpromo = promociones.codpromo
		where year(promociones.fecinipromo) = 2012
			group by articulos.refart, articulos.nomart, promociones.despromo
            order by promociones.despromo;*/
            
        -- EVA
select despromo, avg(precioartpromo)
	from articulos 
		join catalogospromos on articulos.refart = catalogospromos.refart
			join promociones on catalogospromos.codpromo = promociones.codpromo
	where year(fecinipromo)=2012
		group by promociones.codpromo;





-- 4. Prepara una rutina que muestre un listado de artículos, su referencia, su nombre y la categoría que no hayan estado en ninguna promoción que haya empezado en este año.
	drop procedure if exists ex_ej4_u7;
	delimiter $$
	create procedure ex_ej4_u7()
	begin
		select articulos.nomart, articulos.refart, categorias.descat
			from articulos
				join categorias on articulos.codcat = categorias.codcat
					join catalogospromos on articulos.refart = catalogospromos.refart
						join promociones on catalogospromos.codpromo = promociones.codpromo
			where year(promociones.fecinipromo) !=  year(curdate());
				
	end $$
	delimiter ;
    call ex_ej4_u7(); 
    
    /** EJERCICIO 4 **/
	select refart, nomart, codcat
		from articulos
		where refart not in (  select refart
								   from catalogospromos 
									  join promociones on catalogospromos.codpromo = promociones.codpromo
								   where year(fecinipromo) = year(curdate()) );

    
    
    
    
    
    

-- 5. Queremos asignar una contraseña a nuestros clientes para la APP de la cadena, prepara una rutuina que dado un dni y un teléfono,
--  nos devueltva la contraseña inicial que estará formada por: 
--  la inicial del nombre, X
--  los números correspondientes a las posiciones 3ª, 4ª Y 5ª del dni  
--  y el número de caracteres de su nombre completo.
--  Asegúrate que el nombre no lleva espacios a izquierda ni derecha.
	drop function if exists ex_ej5_u7;
	delimiter $$
	create function ex_ej5_u7(DNI char(8),TELEFONO char(9))
    returns varchar(60)
    deterministic
	begin
		return ( select concat('', left(upper(clientes.nomcli),1),'',substring(DNI,3,3),'', length(clientes.nomcli)  ) as Contraseña
					from clientes
						where clientes.dni = DNI and clientes.tlfcli = TELEFONO); --  VA A DAR ERROR XQ NO HAY DNI, SINO CORREO
	end $$
	delimiter ;
    
-- 6. Sabemos que de nuestros vendedores almacenamos en nomvende su nombre y su primer apellido y su segundo apellido, 
--    no hay vendedores con nombres ni apellidos compuestos. Obten su contraseña formada por 
-- 			·la inicial del nombre, 
-- 			·las 3 primeras letras del primer apellido y 
-- 			·las 3 primeras letras del segundo apellido. 

UPDATE `ventapromoscompleta`.`vendedores` SET `nomvende` = 'Pedro González Sánchez' WHERE (`codvende` = '1');
UPDATE `ventapromoscompleta`.`vendedores` SET `nomvende` = 'María Pérez Lima' WHERE (`codvende` = '2');
UPDATE `ventapromoscompleta`.`vendedores` SET `nomvende` = 'Germán Torres Campos' WHERE (`codvende` = '3');
UPDATE `ventapromoscompleta`.`vendedores` SET `nomvende` = 'Anaís Rubio García' WHERE (`codvende` = '4');
	select nomvende, concat(
						substring(nomvende,1,1),
						substring(nomvende, locate(' ',nomvende)+1,3),
						substring(nomvende,locate(' ',nomvende,locate(' ',nomvende) + 1)+1,3)
                        ) as Contraseña
		from vendedores;



-- 7. Queremos saber las promociones que comiencen en el mes actual y para las que la media de los precios de los artículos 
--    de dichas promociones coincidan con alguna de las de un año determinado (utiliza el ejercicio P3. Tendrás que hacer alguna modificación)
	select despromo, avg(precioartpromo) as MediaPrecioPromocionado
		from articulos 
			join catalogospromos on articulos.refart = catalogospromos.refart
				join promociones on catalogospromos.codpromo = promociones.codpromo
		where month(fecinipromo) = month(curdate())
			group by promociones.codpromo
            having avg(precioartpromo) = any (select avg(precioartpromo)
												from articulos 
													join catalogospromos on articulos.refart = catalogospromos.refart
														join promociones on catalogospromos.codpromo = promociones.codpromo
												where year(fecinipromo)= 2012 -- Le paso un  año en concreto.
													group by promociones.codpromo );

-- 8. Obtén un listado de artículos (referencia y nombre) cuyo precio venta sin promocionar sea el mismo que el que han tenido en alguna promoción.
	select articulos.refart as Referencia, articulos.nomart as NombreArticulo
		from articulos 
			join catalogospromos on articulos.refart = catalogospromos.refart
				join promociones on catalogospromos.codpromo = promociones.codpromo
		where articulos.precioventa = any ( select precioartpromo
												from articulos 
													join catalogospromos on articulos.refart = catalogospromos.refart
														join promociones on catalogospromos.codpromo = promociones.codpromo 
												 where catalogospromos.refart = articulos.refart ); -- Si no le pongo esto no tiene como relacionar un precio con otro. 
                                                 /*Es decir, yo le digo que compare una serie de precios de una serie de articulos cuando el precio de venta de estos
                                                 sea parecido o igual a alguno de los otros precios DE OTROS ARTICULOS(TENGO QUE ESPECIFICAR QUE SE COMPARE UN ARTICULO CON OTRO),
                                                 si solo le digo que se parezca a un precio se puede tragar muchos mas resultados.*/
