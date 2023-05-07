use empresaclase;
-- buscar los empleados que ganan más que todos los empleados del depto.110


select empleados.nomem
	from empleados
    where empleados.salarem > all (select salarem -- select max(salarem)
								from empleados
									where numde=110);
/*
expresion o columna 	SOME | ANY		operador logico, (>, <, ...)
						ALL
						IN
*/                                    

-- empleados que ganan lo mismo que  algunos de los del depto 110
select empleados.nomem
	from empleados
    where empleados.salarem = any (select salarem -- select max(salarem)
								from empleados
									where numde=110);
