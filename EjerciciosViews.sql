/*Para la bd promociones:
	Prepara una vista que se llamará CATALOGOPRODUCTOS  que tenga la referencia del artículo,código y nombre de categoría, nombre del artículo,el precio base y el precio de venta HOY*/
use ventapromoscompleta;
drop view CATALOGOPRODUCTOS;
create view CATALOGOPRODUCTOS as
	select articulos.refart as ReferenciaArticulo, articulos.nomart as nombreArticulo, articulos.preciobase as PrecioBase, articulos.precioventa as Precioventa,
			categorias.nomcat as nombreCategorias
		from promociones
			join catalogospromos on promociones.codpromo = catalogospromos.codpromo
				join articulos on catalogospromos.refart = articulos.refart
					join categorias on articulos.codcat = categorias.codcat;

select * from CATALOGOPRODUCTOS;
-- ---------------------------------------------------------
/*QUEREMOS TENER PREPARADO SIEMPRE (VISTA) UN LISTADO CON LOS PRECIOS A DÍA DE HOY (CUANDO SE CONSULTE) DE LOS ARTÍCULOS
NECESITO: refart, nomarticulo preciobase, pecioHoy, codcat*/
create view catalogoprecios as
select refart, nomart, preciobase, precioventa, codcaat
from articulos
where refarticulo not in ( select catalogospromos.refarticulo
							from catalogospromos 
								join promociones on catalogospromos.codpromo = promociones.codpromo	
							where curdate() between promociones.fecinipromo and date_add (promociones.fecinipromo, interval promociones.duracion day) )
union all /* se repiten */
-- union  /* no se repiten */
select articulos.desarticulo, catalogospromos.precioventa
	from catalogospromos 
		join promociones on catalogospromos.codpromo = promociones.codpromo	
	where curdate() between promociones.fecinipromo and date_add (promociones.fecinipromo, interval promociones.duracion day)


/* Para la bd de empresaclase:
Prepara una vista que se llamerá LISTINTELEFONICO en la que cada usuario podrá consultar la extensión
telefónica de los empleados de SU DEPARTAMENTO
PISTA ==> USAR FUNCIÓN DE MYSQL USER()
AL CREAR LA VISTA TENER EN CUENTA ESTO:
[SQL SECURITY { DEFINER | INVOKER }]
*/
use empresaclase;
drop view if exists LISTINTELEFONICO;
create view LISTINTELEFONICO as 
select distinct empleados.numem as CodEmpleado,empleados.extelem as ExtensionTelefonica,empleados.numde as NºEmpleado, departamentos.nomde as nombreDepto, departamentos.numde as NºDepto
	from empleados
		join departamentos on empleados.numde = departamentos.numde;

select * from LISTINTELEFONICO
	where NºDepto = 110;
    
-- ---------------------------------------------------------------------------------------
-- PARA PROBAR, VAMOS A USAR DOS USUARIOS: EL HABITUAL Y OTRO AL QUE LLAMAREMOS PRUEBA.
-- EN LA BD, TENDREMOS A UN EMPLEADO CON userem = usuario con el que accedmos habitualmente a mysql
-- (en mi caso 'eva', lo voy a asignar a la empleada 890, que está en el depto 121
-- EN LA BD, TENDREMOS A OTRO EMPLEADO CON userem = prueba
-- (lo voy a asignar a la empleada 180, que está en el depto 110
-- El usuario eva ya existe, solo tenemos que crear el usuario prueba y grabar en userem de los empleados mencionados el usuario adecuado
drop user 'prueba'@'192.168.56.1';
create user 'prueba'@'192.168.56.1' identified by '1234';

grant all on *.* to 'prueba'@'192.168.56.1'; 
-- vemaos la función user() que devuelve el usuario conectado:
select user(),
	locate('@', user()),
	left(user(),locate('@', user())),
    locate('@', user())-1;
select left(user(),locate('@', user())-1);
select version();
-- POR TANTO:
CREATE 
	SQL SECURITY INVOKER -- SOLO NECESARIO EN VERSIONES ANTERIORES A MYSQL 8.0.19
	VIEW LISTIN
	(Nombre, extension)
AS
	select concat (ape1em, ifnull(concat(' ', ape2em),''), ', ', nomem), extelem
    from empleados
    where numde = (select numde
				   from empleados
                   where userem = left(user(),locate('@',user())-1 )
				  );

-- cuando ejecutemos la siguiente sentencia conectados con el usuario 'eva', veremos los empleados del depto. 121
-- cuando ejecutemos la siguiente sentencia conectados con el usuario 'prueba', veremos los empleados del depto. 110
select *
from LISTIN;
select current_user();                  