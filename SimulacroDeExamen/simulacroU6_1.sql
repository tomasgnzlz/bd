use bdmuseo2021;
-- Obtén todos los datos de las obras de la sala 1 y de la sala 3.
select * 
	from obras
		where obras.codsala= 1 or obras.codsala= 3; -- ESTO NO DEBERÍA SER CON AND? ES RESTRICTIVO EL AND. 
    
-- 2. Prepara una consulta que muestre en la primera columna el nombre de la obra y el autor de la misma entre paréntesis (por ejemplo “El Guernica (Picasso)” y, 
--    en la segunda y tercera columnas, la sala y la valoración de dicha obra respectivamente. 
--    Queremos ver las obras más valoradas primero. Además los encabezados de las columnas deben tener un buen aspecto.
select concat('', obras.nombreobra, ' ' , '(' ,artistas.nomartista, ')') as NombreObra, obras.codsala as Sala,  ifnull(obras.valoracion, 0)  as ValoraciónObra		
	from obras
		join artistas on obras.codartista = artistas.codartista
	order by obras.valoracion desc;


-- 3. Prepara un procedimiento que muestre, de la forma más eficiente posible, 
--    los nombres de las obras restauradas entre dos fechas dadas,
--    así como el restaurador (su nombre) que realizó el trabajo.
delimiter $$
drop procedure if exists esimulacro_3$$
create procedure esimulacro_3( in fechaUno date, in fechaDos date)
begin 
	select obras.nombreobra, concat_ws('', restauraciones.codrestaurador, ' ', restaurador.nomres) as DatosRestaurador
		from obras 
			join restauraciones  on obras.codobra = restauraciones.codobra
				join restaurador on restauraciones.codrestaurador = restaurador.codres
	-- where restauraciones.fecinirest >= fechaDos and restauraciones.fecinirest <= fechaUno;
    where restauraciones.fecinirest between fechaUno and fechaDos; -- Uso el between para ahorrarme el escribir una operación y esta es la manera correcta de trabajar con dos condiciones del mismo tipo si hablamos de rangos. 
end $$
delimiter ;
call esimulacro_3('2022-05-23', '2022-10-23'); 

-- 4. Prepara un procedimiento que, dado el nombre de una obra, devuelva el nombre del autor (si no existe debería devolver ‘obra anónima’) y su valoración.
delimiter $$
drop procedure if exists esimulacro_4$$
create procedure esimulacro_4(in NombreObra varchar(100))
begin 
	select obras.nombreobra as NombreObra, ifnull(artistas.nomartista, 'obra anónima') as Artista, ifnull(obras.valoracion, 0) as ValoraciónObra
		from obras
			join artistas on obras.codartista = artistas.codartista
	where trim(obras.nombreobra)= NombreObra;
end $$
delimiter ;
call esimulacro_4('TE POR LA TARDE');

-- 5. Prepara un procedimiento que muestre las obras (su nombre) y el nombre de su autor de aquellas restauradas entre 2 fechas.
delimiter $$
drop procedure if exists esimulacro_5$$
create procedure esimulacro_5( in fechaUno date, in fechaDos date)
begin 
	select obras.nombreobra, artistas.nomartista
		from obras
			join restauraciones  on obras.codobra = restauraciones.codobra
				join artistas on obras.codartista = artistas.codartista
    where restauraciones.fecfinrest between fechaUno and fechaDos;
end $$
delimiter ;
call esimulacro_5('2022-05-23', '2022-10-23');

-- 6. Prepara un procedimiento que muestre el valor de todas las obras de cada sala (la obras de cada sala deben aparecer juntas
--    y queremos que se muestre también el nombre de la obra). Queremos que se muestre el nombre de la sala. 
--    Ten en cuenta que es posible desconocer el valor de algunas obras.
delimiter $$
drop procedure if exists esimulacro_6$$
create procedure esimulacro_6()
begin 
	select obras.codobra as CodObra, obras.nombreobra as NombreObra, ifnull(obras.valoracion,0) as ValoraciónObra, salas.codsala as CodSala, salas.nomsala as NombreSala
		from obras
			 join salas on obras.codsala = salas.codsala
		order by salas.codsala; -- muestra todos los resultados ordenados. 
        -- group by saca 1 solo resultado
end $$
delimiter ;
call esimulacro_6();

-- EJEMPLO QUE ME SALGAN LAS SALAS QUE NO TIENEN OBRAS ASOCIADAS. 
delimiter $$
drop procedure if exists esimulacro_6_2$$
create procedure esimulacro_6_2()
begin 
	select obras.nombreobra as NombreObra, ifnull(obras.valoracion,0) as ValoraciónObra, salas.nomsala as NombreSala
		from  salas 
			left join obras on salas.codsala = obras.codsala
		order by salas.codsala, nombreobra; 
        
        -- select obras.codobra as CodObra, obras.nombreobra as NombreObra, ifnull(obras.valoracion,0) as ValoraciónObra, salas.codsala as CodSala, salas.nomsala as NombreSala
			-- from obras
				-- right join salas on obras.codsala = salas.codsala
		-- order by salas.codsala; 
end $$
delimiter ;
call esimulacro_6_2();



