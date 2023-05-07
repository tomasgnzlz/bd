
drop function if exists funcion_ejer_6_3_1;
delimiter $$
create function funcion_ejer_6_3_1()
    returns decimal(7,2)
begin
	-- select funcion_ejer_6_3_1();
    
	declare maxsalario decimal(7,2);
    
	set maxsalario =(   select max(salarem)
					        from empleados
                        );
	/* o también:
		select max(salarem) into maxsalario
	   from empleados*/
    
    return maxsalario;
	/* o también:
	return (select  max(salarem)
			from empleados);
	*/

end $$
delimiter ;