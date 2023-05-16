use empresaclase;

-- ^ --> Cuando quiero indicar que empiece por algo. 
select e.nomem
	from empleados e
		where e.nomem regexp '^A';
        
-- $ --> Cuando quiero indicar que termine por algo. 
select e.nomem
	from empleados e
		where e.nomem regexp 'A$';
