set @depto = (select numde
				from empleados
				where numem=120);

-- ej_1
insert into empleados
	(numem, numde, nomem, ape1em, ...)
    (1999, @depto, 'pepe', 'peps', ...)

-- ej_1_1
insert into empleados
	(numem, numde, nomem, ape1em, ...)
    (1999, (select numde
				from empleados
				where numem=120), 'pepe', 'peps', ...)    
                
create table centros_new	
		(numce, int primary key,nomce varchar(60) );
        
