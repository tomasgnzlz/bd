use empresaclase;
-- UNA VISTA ES UNA TABLA VIRTUAL EN LA QUE NOSOTROS DECIMOS QUE TIPOS DE DATOS SE ENCUENTRAN Y SERÁN MOSTRADOS, ES COMO UNA TABLA DE NUESTRA BBDD PERO
-- EN ESTA SOLO SE ENCUENTRAN LOS PARAMETROS QUE TU QUIERAS, NO TODOS LOS DE LA BBDD O DE LA TABLA REAL DE LA QUE HABLAS. 
	-- creo la vista.
	drop view if exists nombre_vista;
	create view nombre_vista as
		select * from empleados;
	-- muestro la vista
	select * from nombre_vista;
		
		
    
