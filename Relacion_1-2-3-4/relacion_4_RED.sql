use empresaclase;
-- 26. Borrar de la tabla EMPLEADOS a los empleados cuyo salario (sin incluir la comisión) supere al salario medio de los empleados de su departamento.
delete empleados
	from empleados
		where empleados.salarem >  all (select empleados.salarem
									from empleados
										join departamentos on empleados.numde = departamentos.numde
									where departamentos.numde = 110
									-- where empleados.numde = empleados.numde -- NO SE COMO HACER LO DE QUE EMPLEADOS DE SU DEPARTAMENTO
                                    );

-- 27. Disminuir en la tabla EMPLEADOS un 5% el salario de los empleados que superan el 50% del salario máximo de su departamento.
update empleados
	set salarem = ( salarem - (salarem*0.05) )
		where salarem > ( 0.5 * ( select  max(salarem)	
									from empleados
										join departamentos on empleados.numde = departamentos.numde
									where empleados.numde=110 )
						);



-- -------------------------------------------------------------------------------------------------------------------------------

use gbdturrural2015;
 -- Para la base de datos de turismo rural, queremos obtener las casas disponibles para una zona y un rango de fecha dados.
 select casas.codcasa as CódigoCasa, casas.nomcasa as NombreCasa
	from casas
		join zonas on casas.codzona = zonas.numzona
			join reservas on casas.codcasa = reservas.codcasa
	where zonas.nomzona = 'Axarquía'
		and reservas.fecreserva between '2012-03-20' and '2013-03-20';
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    