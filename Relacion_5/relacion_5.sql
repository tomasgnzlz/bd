use bdalmacen; -- Esto se usa para decir la bbdd de la que tiene que hacer las consultas. 
select * from productos;
-- 1. Obtener todos los productos que comiencen por una letra determinada
	select descripcion
		 from productos
		 where descripcion regexp '^B';
 
-- 2. Se ha diseñado un sistema para que los proveedores puedan acceder a ciertos datos, la contraseña que se les da es el teléfono de la empresa al revés. 
-- Se pide elaborar un procedimiento almacenado que dado un proveedor obtenga su contraseña y la muestre en los resultados.
	drop function if exists ej5_2;
	delimiter $$ 
	create function ej5_2(CodigoProveedor int)
		returns char(9)
		deterministic
	begin 
			return(
				select reverse(concat(proveedores.telefono)) as contraseñaProveedor
					from proveedores
					where proveedores.codproveedor = CodigoProveedor 
				);
	end $$
	 delimiter ;
	 select ej5_2(1); -- FUNCIONA
 
 
 -- 3. Obtener el mes previsto de entrega para los pedidos que no se han recibido aún 
 --    y para una categoría determinada.
	 select monthname(date_add(pedidos.fecpedido,interval 30 day)) as FechaEntregaPrevista
		from pedidos
			join productos on pedidos.codproducto = productos.codproducto
				join categorias on productos.codcategoria = categorias.codcategoria
		where categorias.codcategoria = 1  
			and pedidos.fecentrega >= curdate() or pedidos.fecentrega is null;
 
-- 4. Obtener un listado con todos los productos, ordenados por categoría, en el que se muestre
-- 	  solo las tres primeras letras de la categoría.
select productos.codproducto as CodigoProducto, productos.descripcion as DescripcionProducto,
		left(categorias.Nomcategoria,3) as NombreCategoria 
	from productos
		join categorias on productos.codcategoria = categorias.codcategoria
	order by categorias.codcategoria;
        
-- 5. Obtener el cuadrado y el cubo de los precios de los productos.
	select productos.preciounidad as PrecioUnidad ,productos.descripcion as nombreProducto, 
			power(productos.preciounidad,2) as CuadradoProductos, power(productos.preciounidad,3) as CuboProductos
		from productos;
-- 6. Devuelve la fecha del mes actual.
	select curdate();
    
-- 7. Para los pedidos entregados el mismo mes que el actual, obtener cuantos días hace que se entregaron.¿?¿?¿?¿?¿?
	select pedidos.fecentrega as FechaEntrega, count(pedidos.codpedido)
		from pedidos
        where pedidos.fecentrega = month(curdate()); 
-- 8. En el nombre de los productos, sustituir “tarta” por “pastel”.

	select productos.descripcion as NombreReal, replace(productos.descripcion,"tarta", "pastel")
		from productos;
		-- where trim(productos.descripcion) like "tarta" or  "pastel";
        -- where trim(productos.descripcion) regexp 'tarta' or  'pastel';

-- 9. Obtener la población del código postal de los proveedores (los primeros dos caracteres se refieren a
--    la provincia y los tres últimos a la población). 33007 ¿¿?¿?¿?¿?
	select proveedores.ciudad, right(proveedores.codpostal, 3) as Poblacion
		from proveedores;
        
-- 10. Obtén el número de productos de cada categoría, haz que el nombre de la categoría se muestre en mayúsculas.
	select count(productos.codproducto) as numeroProductos, upper(categorias.Nomcategoria) as NombreCategoria
		from productos
			join categorias on productos.codcategoria = categorias.codcategoria
		where categorias.codcategoria >= 1 
			group by categorias.Nomcategoria; -- ME FALTAVA EL GROUP BY
        
            
-- 11. Obtén un listado de productos por categoría y dentro de cada categoría del nombre de producto más corto al más largo.
	select productos.codproducto as CódigoProducto, productos.descripcion as NombreProducto, categorias.Nomcategoria as NombreCategoria
		from productos
			join categorias on productos.codcategoria = categorias.codcategoria
		order by length(categorias.codcategoria) desc; 
                
-- 12. Asegúrate de que los nombres de los productos no tengan espacios en blanco al principio o al final de dicho nombre.
	select trim(productos.descripcion) as NombreProductos
		from productos;
-- 13. Lo mismo que en el ejercicio 2, pero ahora, además, sustituye el 4 y 5 número del resultado por las 2 últimas letras del nombre de la empresa.
	-- 2. Se ha diseñado un sistema para que los proveedores puedan acceder a ciertos datos, la contraseña que se les da es el teléfono de la empresa al revés. 
-- Se pide elaborar un procedimiento almacenado que dado un proveedor obtenga su contraseña y la muestre en los resultados.

	drop function if exists ej5_13;
	delimiter $$ 
	create function ej5_13(CodigoProveedor int)
		returns char(9)
		deterministic
	begin 
			return(
				select reverse(concat(proveedores.telefono)) as contraseñaProveedor
					from proveedores
					where proveedores.codproveedor = CodigoProveedor 
				);
	end $$
	 delimiter ;
	 select ej5_13(1); -- FUNCIONA

-- 14. Obtén el 10 por ciento del precio de los productos redondeados a dos decimales.
	select round( ( ( productos.preciounidad * 10 ) / 100 ),2 ) as PorcentajePrecio
		from productos;
        
-- 15. Muestra un listado de productos en que aparezca el nombre del producto y el código de producto y 
--     el de categoría repetidos (por ejemplo para la tarta de azucar se mostrará “623623”).

select productos.descripcion as nombreProductos, repeat(concat('', productos.codproducto, '', productos.codcategoria, ''), 2) as idRepetido
	from productos;
