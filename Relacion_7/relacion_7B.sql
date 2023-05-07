-- Para la base de datos de las promociones: 
use ventapromoscompleta;
-- Prepara un procedimiento que, dado un código de promoción obtenga un listado con el nombre de las categorías que tienen al menos dos productos incluidos en dicha promoción.
	drop procedure if exists ej1_6_b;
	delimiter $$
	create procedure ej1_6_b(in codigoPromocion int)
	begin
		select categorias.nomcat as NombreCategorias, count(articulos.stock) as nºProductos
			from promociones
				join catalogospromos on promociones.codpromo = catalogospromos.codpromo
					join articulos on catalogospromos.refart = articulos.refart
						join categorias on articulos.codcat = categorias.codcat
			where promociones.codpromo = codigoPromocion
				group by categorias.nomcat
					having count(articulos.stock) > 1;
	end $$
	delimiter ;
	call ej1_6_b(1);




-- Prepara un procedimiento que, dado un precio, obtenga un listado con el nombre de las categorías en las que el precio  medio de sus productos supera a dicho precio.
	drop procedure if exists ej2_6_b;
	delimiter $$
	create procedure ej2_6_b(in Precio decimal(5,2))
	begin
		select categorias.nomcat as NombreCategorias, avg(articulos.preciobase) as precioMedio
			from promociones
				join catalogospromos on promociones.codpromo = catalogospromos.codpromo
					join articulos on catalogospromos.refart = articulos.refart
						join categorias on articulos.codcat = categorias.codcat 
			where articulos.precioventa = Precio
				group by categorias.nomcat
					having avg(articulos.preciobase) > Precio;
	end $$
	delimiter ;
	call ej2_6_b(1); -- ME SALE EN BLANCO
    
    
    
    

-- Prepara un procedimiento que muestre el importe total de las ventas por meses de un año dado.
	drop procedure if exists ej3_6_b; 
	delimiter $$ 
	create procedure ej3_6_b() 
	begin 
		select ((articulos.preciobase * 30)) as SS
			from promociones
				join catalogospromos on promociones.codpromo = catalogospromos.codpromo
					join articulos on catalogospromos.refart = articulos.refart
						join categorias on articulos.codcat = categorias.codcat ;
	end $$ 
	delimiter ; 
	call ej3_6_b();

-- Como el ejercicio anterior, pero ahora solo nos interesa mostrar aquellos meses en los que se ha superado a la media del año.
