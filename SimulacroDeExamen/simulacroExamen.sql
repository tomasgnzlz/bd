delimiter $$
drop procedure if exists esimulacro_3_2$$
create procedure esimulacro_3_2()
begin 
	set codNSQ(select restaurador.codres from restaurador);

    select obras.nombreobra as NombreObra
		from obras 
			join restauraciones  on obras.codobra = restauraciones.codobra
				join restaurador on restauraciones.codrestaurador = restaurador.codres
    where restaurador.codres = codNSQ;

end $$
delimiter ;
call esimulacro_3_2();