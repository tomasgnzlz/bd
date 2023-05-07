
    /*Buscar el numero de empleados de cada depto con salario mayor
    de 1500 pero no me interesan los deptos de menos de 3 miembros*/
use empresaclase;
    select numde, count(*) as numEmple -- (5)
        from empleados  -- (1)
        where salarem >1500  -- (2)
            group by numde -- (3)
                having count(*)>=3; -- (4)
                   -- order by count(*) desc; -- (6)
                    -- order by numEmple desc; 
                  
/*Entonces si en el Select yo hago uso de alguna funcion y despues quiero hacer filtros con respecto a dicha funcion uso el having?
	Exacto, así es. Si deseas aplicar filtros a los resultados de una consulta basándote en los valores de una función de agregación 
	que se encuentra en la lista de selección (SELECT), puedes utilizar el HAVING. En este caso, el HAVING se utiliza después de la 
	cláusula GROUP BY para filtrar los resultados agregados.
	Por ejemplo, si tienes una tabla de ventas con columnas como producto, cantidad y precio_unitario, y quieres obtener el total de 
	ventas por producto y filtrar aquellos que tengan un total de ventas mayor a 1000, puedes utilizar el HAVING de la siguiente manera:

	SELECT producto, SUM(cantidad * precio_unitario) as total_ventas
		FROM ventas
			GROUP BY producto
				HAVING total_ventas > 1000;*/    
						
