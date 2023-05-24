use GBDgestionaTests;
-- EXAMEN TOMAS ARIEL GONZALEZ ATIENZA 1ºDAW BBDD
-- 1.  Creo un trigger que me compare las preguntas que ya hay en la bd con la nueva pregunta 
-- que yo quiero añadir. Si son iguales lanza una excepción, sino sale del if y se realiza la insersion de la pregunta correctamente.
-- PRIMERA PARTE DEL EJERCICIO. 
drop trigger if exists preguntasRepetidas;
delimiter $$
create trigger preguntasRepetidas
	before insert on preguntas
for each row
begin
	-- Con este select compruebo que las preguntas antiguas, asi como el codtests no coincide con los que pertenecen a la pregunta que quiero añadir. 
	if exists (select *
					from preguntas
						where textopreg = new.textopreg and codtest = new.codtest) 
			then		
				signal sqlstate '45000' set message_text = 'ERROR, La pregunta que quiere añadir ya existe dentro de la bbdd';
	end if;
end $$
delimiter ;

-- SEGUNDA PARTE DEL EJERCICIO. 
drop trigger if exists 	modificapregexistentes;
delimiter $$
create trigger modificapregexistentes
	before update on preguntas
for each row
begin
		if new.textopreg <> old.textopreg and exists (select *
														from preguntas
															where textopreg = new.textopreg and codtest = new.codtest) 
		then
			begin
				-- ¿??¿?¿??¿?¿? TIENE QUE MOSTRAR ERROR O NO.
				-- signal sqlstate '45000' set message_text = 'ERROR';
                set new.textopreg = old.textopreg;
                -- hago que la nueva pregunta sea como la que ya estaba, asi no se repuiten las preguntas.
			end;
        end if;
end $$
delimiter ;



-- ----------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------
-- 2. 
-- PROCEDURE QUE HACE LO DE LOS 10 AÑOS. 
drop procedure if exists incrementaNotas;
delimiter $$
create procedure incrementaNotas()
begin 
end $$
delimiter ;
-- EVENTO PARA LLAMAR EL PROCEDURE
delimiter $$
create event actualNumEmpleados
    on schedule
		every 1 quarter
    starts '2023/06/20'
    ends '2033/06/20'
	do
	begin
    -- LLAMAR AL PROCEDIMIENTO QUE HACE LO DE LOS PUNTOS/10AÑOS
		-- call incrementaNotas();
    end $$
delimiter ;
-- ---------------------------------------------------------------------------------------------------

-- 4- 
drop trigger if exists regexpAlumnos;
delimiter $$
create trigger regexpAlumnos 
	before insert on alumnos
	for each row
begin
declare relemail varchar(30);
set relemail = ( email regexp '[@]' and lower(a.email) regexp '[. a-z]$');
    -- expresion regular nombre
    if new.nomalum not regexp '^[a-z][a-z 0-9  = _ ? !]......' then
		begin
			signal sqlstate '45000' set message_text = 'ERROR, El nombre no cumple con la expresion regular';
		end;
	end if;
    
    -- expresion regular email regexp '[@]' and lower(a.email) regexp '[. a-z]$';
    if new.email not regexp '[@]' | new.email <> relemail then
		begin
			signal sqlstate '45000' set message_text = 'ERROR, El email no cumple con la expresion regular';
		end;
	end if;
    
    -- expresion regular telefono(está incompleta)
    if new.email not regexp '^[6|7|9][0-9]{2}' then
		begin
			signal sqlstate '45000' set message_text = 'ERROR, El telefono no cumple con la expresion regular';
		end;
	end if;
    
end $$
delimiter ;


-- ---------------------------------------------------------------------------------------------------
-- 5. 
drop trigger if exists compruebaPreg;
delimiter $$
create trigger compruebaPreg
	before insert on preguntas
for each row
begin
	if exists (select *
					from preguntas
						where textopreg = new.textopreg and codtest = new.codtest) 
	then
		begin
			signal sqlstate '45000' set message_text = 'ERROR';
		end;
	end if;

	if new.resa = new.resb or new.resa = new.resc or new.resb = new.resc 
	then
		begin
			signal sqlstate '45000' set message_text = 'ERROR';
		end;
end if;
end $$
delimiter ;

drop trigger if exists compruebaPreg_2;
delimiter $$
create trigger compruebaPreg_2
	before update on preguntas
for each row
begin

	if new.textopreg <> old.textopreg and exists (select *
														from preguntas
															where textopreg = new.textopreg and codtest = new.codtest) 
	then
		begin
			set new.textopreg = old.textopreg;
		end;
	end if;

	if (new.resa <> old.resa or new.resb <> old.resb or new.resc <> old.resc) 
		and (new.resa = new.resb or new.resa = new.resc or new.resb = new.resc) then
        -- este signal avisa, pero no detiene el proceso de ejecución. 
			signal sqlstate '01001' set message_text = 'ERROR';
	end if;

end $$
delimiter ;