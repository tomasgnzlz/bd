use empresaclase;
select* from empleados;
-- 1. 
delimiter $$
    drop procedure if exists prueba1;
    create procedure prueba1()
    begin
		  select max(empleados.salarem) -- para minimo (min) y para máximo (max)
		from empleados;
    end $$
delimiter ;
call prueba1;
-- 4 
delimiter $$
	drop procedure if exists prueba2 $$
	create procedure prueba2 ()
	begin
		 select max(salarem) as salarioMaximo, 
				min(salarem) as salarioMinimo, 
				avg(salarem) as mediaSalario
			from empleados;
	end $$
delimiter ;

call prueba2;

select 
				max(salarem) as salarioMaximo, 
				min(salarem) as salarioMinimo, 
				avg(salarem) as mediaSalario
			from empleados
				join departamentos on empleados.numde = departamentos.numde
                join centros on departamentos.numce = centros.numce
            where trim(nomce) = 'Organización';
            --    icojsariov
select count(distinct empleados.extelem)
			from empleados
            group by empleados.extelem;
            
SELECT departamentos.nomde, empleados.nomem, COUNT(DISTINCT empleados.extelem)
	FROM empleados
		JOIN departamentos ON empleados.numde = departamentos.numde
	GROUP BY empleados.nomem, departamentos.numde;
    
-- ver
select departamentos.nomde,  empleados.nomem, count(distinct empleados.extelem)
			from empleados
				join departamentos on empleados.numde = departamentos.numde
			where trim(departamentos.nomde)= 'FINANZAS'
            group by empleados.nomem, departamentos.nomde;
            
select *
		from departamentos;
        
-- RELCION 4 DE EJERRCICIOS DE MYSQL
-- 1. 
select empleados.nomem, empleados.salarem
			from empleados
				where empleados.numhiem >3
			order by empleados.nomem; 
-- 2. 
select  empleados.nomem as Empleados, 
		concat_ws('', empleados.numde, ' ', departamentos.nomde) as Departamentos, 
		empleados.comisem as ComisionPersonal
			from empleados
				join departamentos on empleados.numde = departamentos.numde
			where empleados.salarem < 19000.00
            order by departamentos asc, empleados.comisem desc;
-- 4. 
select empleados.nomem, empleados.numem, empleados.extelem
			from empleados
				join departamentos on empleados.numde = departamentos.numde
			where departamentos.numde =121
            order by departamentos.nomde;
-- 5. 
select empleados.nomem, empleados.salarem, concat_ws('', ifnull(empleados.comisem, '0')) as comisionEmpleado
			from empleados
            where empleados.numhiem > 3
            order by empleados.nomem asc;
            
-- 6 .             
select empleados.nomem, concat_ws('', ifnull(empleados.salarem, '0')) + concat_ws('', ifnull(empleados.comisem, '0')) as salarioTotal
			from empleados
            where empleados.salarem + empleados.comisem > 3000.00
            order by empleados.numem asc; 
            
select * from empleados;
            
-- 7.             

select concat_ws('', departamentos.numde, ' ', empleados.nomem) as Resultados
			from empleados
				join departamentos on empleados.numde = departamentos.numde
			where (empleados.comisem / empleados.salarem) > 0.2
            order by empleados.numem asc; 

            
-- 8.
select empleados.nomem
			from empleados
			where (empleados.comisem = (100 * empleados.numhiem)) <= salarem * 0.1
            order by empleados.nomem; 
            
/* 9. 
	Llamaremos presupuesto medio mensual de un depto. al resultado de dividir su presupuesto anual por 12. 
    Supongamos que se decide aumentar los presupuestos medios de todos los deptos en un 10% a partir del mes de octubre inclusive. 
    Para los deptos. cuyo presupuesto mensual anterior a octubre es de más de 500.000 u.m.
	Hallar por orden alfabético el nombre de departamento y su presupuesto anual total después del incremento.
*/
select departamentos.nomde, sum(departamentos.presude + ((departamentos.presude/12)+((departamentos.presude/12)*0.1)) )
			from departamentos
			where departamentos.presude > 500.00
            order by departamentos.nomde;
-- 15. 

select empleados.nomem, empleados.comisem
			from empleados
               where empleados.comisem = 0 or empleados.comisem is null
			-- where coalesce(empleados.comisem, 0) = 0
			order by length(empleados.nomem),empleados.nomem;
            
-- 18. 
select ( (max(empleados.salarem)) - (min(empleados.salarem)) ) as Diferencia_Salarial
			from empleados;      
            
-- 19. 
select empleados.nomem,   avg(empleados.numhiem) as MediaHijosEmpleados
			from empleados
            where empleados.numhiem <= 2
            group by empleados.nomem
            order by empleados.nomem;     
-- 21.
select * from dirigir;     
select count(*)  as nºEmUsandoExtelem,empleados.nomem, empleados.extelem,  avg(empleados.salarem) as salarioMedio
			from empleados
            where empleados.extelem =  (350)
				group by empleados.nomem
				order by empleados.nomem;      
            
-- 24. 
select empleados.nomem 
			from empleados
				join dirigir on empleados.numde = dirigir.numdepto
            where dirigir.numempdirec = empleados.numem
				group by empleados.nomem
				order by empleados.nomem;            
-- 25.  
select empleados.nomem,  (empleados.salarem * 1.05) as nuevoSalario
			from empleados
				join dirigir on empleados.numde = dirigir.numdepto
            where dirigir.numempdirec = empleados.numem
				group by empleados.nomem, empleados.salarem
				order by empleados.nomem;
-- 29.Seleccionar los nombres de los departamentos que no dependan de ningún otro.                
select *,empleados.nomem from departamentos join empleados on departamentos.numde = empleados.numde;
select departamentos.nomde
			from departamentos
            where departamentos.depende is null;
            
select empleados.nomem, empleados.salarem
			from empleados
            where empleados.salarem = empleados.comisem;    
            
-- 34. 
select empleados.nomem, empleados.salarem
			from empleados
				join departamentos on empleados.numde = departamentos.numde
            -- where departamentos.numde = 111 and departamentos.numde = 120 CON EL Nº DE LOS DEPARTAMENTOS NO ME SALEN LOS EMPLEADOS.
			where trim(departamentos.nomde) = 'ORGANIZACION' 
            -- where trim(departamentos.nomde) = 'DIRECC.COMERCIAL'
            order by empleados.nomem;
            
select * from empleados;
select * from centros;


-- 37.Hallar el centro de trabajo (nombre y dirección) de los empleados sin comisión.

		select centros.nomce as NombreCentro, empleados.nomem as NombreEmpleados, empleados.comisem as Comision
			from empleados
				join departamentos on empleados.numde = departamentos.numde
                join dirigir on departamentos.numde = dirigir.numdepto
                join centros on departamentos.numce = centros.numce
			where empleados.comisem = 0 or empleados.comisem is null and trim(centros.nomce) = 'RELACION CON CLIENTES'
            order by centros.nomce;
			
            
            
            
            
-- 39.Hallar cuantos empleados no tienen comisión por cada centro de trabajo.            

select  count(empleados.nomem) as NºEmpleados
			from empleados
				join departamentos on empleados.numde = departamentos.numde
					join dirigir on departamentos.numde = dirigir.numdepto
						join centros on departamentos.numce = centros.numce
				where empleados.comisem = 0 or empleados.comisem is null and trim(centros.nomce) = 'RELACION CON CLIENTES'
					order by centros.nomce;
        
-- relacion 9 relacion 9 relacion 9 relacion 9 relacion 9 relacion 9 
/*  1. 
		Queremos obtener un listado en el que se muestren los nombres de departamento y el número de empleados de cada uno. 
		Ten en cuenta que algunos departamentos no tienen empleados, 
		queremos que se muestren también estos departamentos sin empleados. 
		En este caso, el número de empleados se mostrará como null.
*/

select count(*) as nºEmpleados, departamentos.nomde
	from empleados join departamentos on empleados.numde = departamentos.numde
			-- where count(*) = 0 and count(*) >=1
                group by departamentos.nomde;
                
/*  2. Queremos averiguar si tenemos algún departamento sin dirección, para ello queremos
		mostrar el nombre de cada departamento y el nombre del director actual, para aquellos
		departamentos que en la actualidad no tengan director, queremos mostrar el nombre del
		departamento y el nombre de la dirección como null.*/





-- EJERCICO APARTE.

delimiter $$
	drop procedure if exists PRUEBACLASE$$
	create procedure PRUEBACLASE()
	begin
		 -- como obtener el nombre del director de un departamento
         select concat_ws('', empleados.nomem,' ', dirigir.numempdirec) as nombreEmpleadoDirector
			from empleados
				join departamentos on empleados.numde = departamentos.numde
					join dirigir on departamentos.numde = dirigir.numdepto;
	end $$
delimiter ;
call PRUEBACLASE();


-- 8. Obtener el nombre de los centros de trabajo cuyo presupuesto esté entre 100000 € y 150000 €.
	select  departamentos.nomde, departamentos.presude, centros.nomce, centros.numce
			from departamentos	
				join centros on departamentos.numce = centros.numce
			where departamentos.presude between 100000 and 150000 ;		

	                

select departamentos.nomde as NombreDepartamento, ((((departamentos.presude/12)*0.1)*3)+departamentos.presude) as PresupuestoAnual
	from departamentos
	where (departamentos.presude/12) > 500
		order by departamentos.nomde asc;
select 
				max(empleados.salarem) as salarioMaximo, 
				min(empleados.salarem) as salarioMinimo, 
				avg(empleados.salarem) as mediaSalario
			from empleados
				join departamentos on empleados.numde = departamentos.numde
                join centros on departamentos.numce = centros.numce
            where trim(centros.nomce) = nombreCentro
            group by centros.nomce;  
            
            
            
select  empleados.nomem as nomEmpleado,
		count(distinct empleados.extelem) as numExtDiferentes, 
		concat_ws('', empleados.nomem, ' ', empleados.extelem) as Nombre_Extension
			from empleados
            group by empleados.nomem, empleados.extelem;
            
            
            
                
                
                
                
                
                
                
                
                
                
                
        
       select empleados.nomem as Nombre, (empleados.salarem*12) as sueldoAnual,
			((empleados.salarem*1.06)*12) as SueldoSubida_1, 
             ((empleados.salarem*1.12)*12) as SueldoSubida_2,
              ((empleados.salarem*1.18)*12) as SueldoSubida_3
			from empleados
			where empleados.numhiem > 4
            order by empleados.nomem asc; 
        
        
        
select 
			empleados.nomem, empleados.numde, 
            max(empleados.salarem) as salarioMaximo, 
				min(empleados.salarem) as salarioMinimo, 
				avg(empleados.salarem) as mediaSalario
			from empleados
				join departamentos on empleados.numde = departamentos.numde
            -- where departamentos.numde = 110
             where trim(departamentos.nomde) = 'ORGANIZACION'
				group by empleados.nomem, empleados.numde;        
        select* from departamentos
        
        
        
        
        
        