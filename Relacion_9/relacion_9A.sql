use empresaclase;
/*1. 
	Queremos obtener un listado en el que se muestren los nombres de departamento y el número de empleados de cada uno. 
    Ten en cuenta que algunos departamentos no tienen empleados, 
    queremos que se muestren también estos departamentos sin empleados. 
    En este caso, el número de empleados se mostrará como null.
*/
delimiter $$
	drop procedure if exists ej1_9$$
	create procedure ej1_9 ()
	begin
		  select count(*) as nºEmpleados, departamentos.nomde
			from empleados
				join departamentos on empleados.numde = departamentos.numde
                -- where count(*) = 0 and count(*) >=1;
                group by departamentos.nomde; 
	end $$
delimiter ;
call ej1_9();
select * from departamentos;


/*  2. 
		Queremos averiguar si tenemos algún departamento sin dirección, 
			para ello queremos mostrar el nombre de cada departamento y el nombre del director actual, 
            para aquellos departamentos que en la actualidad no tengan director: 
				queremos mostrar el nombre del departamento y el nombre de la dirección como null. 
*/
delimiter $$
	drop procedure if exists ej2_9$$
	create procedure ej2_9 ()
	begin
		 select departamentos.nomde, empleados.nomem as EmpleadoDirector, dirigir.fecfindir as fechaMala
			from departamentos
				left join dirigir on departamentos.numde = dirigir.numdepto
				left join empleados on dirigir.numempdirec = empleados.numem-- si esto no coincide no me mostraría datos, ya que el left join solo muestra aquello que coincide con la tabla que está a la izquierda en este caso. 
                where dirigir.fecfindir is null;
	end $$
delimiter ;
call ej2_9();