use GBDgestionaTests
-- procedimiento para el examen !!!!!!
/*** PROCEDIMIENTO PARA AÑADIR LAS MATRÍCULAS DEL ALUMNADO    ***/


-- NOTA: Para poder hacer este ejercicio, debes añadir una columna en la tabla matrículas:
-- (este campo valdrá 0 la primera vez que un alumno/a curse una materia y 1, 2, etc. cuando repita)
alter table matriculas
	add column repite tinyint default 0,
    drop primary key,
    add constraint pk_matriculas primary key (numexped, codmateria, repite);

delimiter $$
create procedure matriculaAlumnado
 (in numeroexped char(12),
  in nombrealum varchar(30),
  in apellido1alum varchar(30),
  in apellido2alum varchar(30),
  in fechanacimalum date,
  in callealum varchar(60),
  in poblacionalum varchar(60),
  in codpostalalum char(5),
  in emailalum varchar(60),
  in telefonoalum char(12),
  in nomuseralum char(8),
  in passwordalum char(12),
  in cursomatricula char(6)
)
begin
	declare exit handler for sqlstate '45000'
    rollback;
	/*Zona de declaración.*/
	declare alumnomatriculado boolean default false;
    declare numrepeticion tinyint default 0;
    
    /*Zona de código.*/
/* A. Buscamos si el alumno/a ha estado dado de alta anteriormente */
start transaction;
	set alumnomatriculado = exists (select * from alumnos where numexped = numeroexped);
    
/* B. Si el alumno estaba matriculado anteriormente, nos aseguramos que sus datos sean los que nos han pasado,
	  si no, insertaremos al alumno  */
    if alumnomatriculado then
		update alumnos
        set nomalum = nombrealum,
			ape1alum = apellido1alum,
			ape2alum = apellido2alum,
			fecnacim = fechanacimalum,
			calle = callealum,
			poblacion = poblacionalum,
			codpostal = codpostalalum,
			email = emailalum,
			telefono = telefonoalum,
			nomuser = nomuseralum,
			password = passwordalum
		where numexped = numeroexped;
	else
		insert into alumnos
			(numexped, nomalum, ape1alum, ape2alum, fecnacim, calle, poblacion, codpostal, email, telefono, nomuser,password)
		values
			(numeroexped,nombrealum,apellido1alum,apellido2alum,fechanacimalum,callealum,poblacionalum,codpostalalum,emailalum,telefonoalum,nomuseralum,passwordalum);
	end if;
	
    /* C. Si el alumno estaba matriculado, comprobamos el número de veces de repetición de un curso */
    if alumnomatriculado then
		set numrepeticion = (......) /* PUNTO EXTRA */
	else
		set numrepeticion = 0;
	end if;
 
/* D. Añadimos las matrículas */
	.......... /* PUNTO EXTRA */
commit;
end $$
delimiter ;
/* --------------------------EXAMEN-----------------------------------------  */
-- ejercicio p1
-- insert
delimiter $$
drop trigger if exists comprobarPregunta $$
create trigger comprobarPregunta
  before insert on preguntas
  for each row
  begin
	if new.numpreg = (select numpreg from preguntas where new.codtest = costest)then
		signal sqlstate '4500'set message_text = 'el codigo de la pregunta ya existe';
	end if;
    end $$
delimiter ;

-- update
delimiter $$
drop trigger if exists comprobarPregunta $$
create trigger comprobarPregunta
  before update on preguntas
  for each row
  begin
	if new.numpreg = (select numpreg from preguntas where new.codtest = costest)then
		signal sqlstate '4500'set message_text = 'el codigo de la pregunta ya existe';
	end if;
    end $$
delimiter ;


-- ejercicio p3
/* considero que existe un procedimiento llamado SubidaPunto que realiza el filtro de los diez Test y genero 
 un evento para que llame al procedimiento en el momento que indica el ejercicio   */
delimiter $$

create event llamadasubidaPunto
on schedule
every 3 month
	starts '2021-09-15 00:00'
    ends '2021-06-30 00:00'
do
	begin
    call SubidaPunto();
    end $$
delimiter ;

-- ejercicio p4
delimiter $$
drop trigger if exists respuestasDiferentes $$
create trigger respuestasDiferentes
	before update on tests
    for each row
begin
	if old.respuesta <> new.respuesta =
			(select respuesta from respuestas join preguntas 
				on codtest.respuestas = codtest.pregutas
				where tests.codtest = preguntas.codtest)
			then
				
                signal sqlstate '4500'set message_text = 'las respuestas son iguales';
	
    end if;
end$$
delimiter ;    
		
    

