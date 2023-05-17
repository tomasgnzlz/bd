
-- ejemplos eventos

-- pocedimiento domiciliaciones(); suponemos que tenemos este evento

delimiter $$
create event llamaDomiciliaciones
on schedule
	every 1 day	
    starts '2022/5/10 02::00:00' -- se le puede poner solo fecha, fecha y hora
    ends '2002/05/10 02:00:00'+ interval 1 year
do
	begin
	call dimiciliaciones;
	end $$

delimiter ;
-- eventos son triggers temporales que se ejecuta cuando le indicamos a modo temporal 
-- el suceso que provoca al trigger es cuando se produce un insert, update, delete


/*
insert (OLD)nada ;insert(NEW)lo que insertas
 delete (OLD) lo que quiero borrar, (NEW) nada
 update (OLD) valor de antes, (NEW) nuevo

la sentencia signal provoca un error controlado, hay documento de  clase con su sintaxsis

*/


/*
controlar mediante triggers que el depto no pueda tener un presupuesto mayor que su superior
si es así no debe permitirse la operación

DETERMINAR PARA QUE TABLA ==> DEPARTAMENTOS

INSERT ==> si
DELETE ==> no
UPDATE ==> si

BEFORE ==> SI
AFTER ==> NO


ESTRUCTURA OLD Y NEW EN ESTE CASO ==> SON ESTRUCTURAS TEMPORALES// 
									  SOLO SE PUEDEN USAR DENTRO DE TRIGGERS
                                      UNICA MANERA QUE YO TENGO DE ACCEDER A CELDAS DE UNA TABLA SIN SELECT .... FROM


OLD Y NEW SON OBJETOS CON LOS CAMPOS DE LA TABLA DEL TRIGGER

old.numde
old.nomde
old.depende
old.numce
old.presude


new.numde
new.nomde
new.depende
new.numce
new.presude

VALORES DE OLD Y NEW

-- trigger INSERT

old.numde -- NULL
old.nomde	-- NULL
old.depende -- NULL
old.numce -- NULL
old.presude -- NULL


new.numde -- VALOR QUE PRETENDO INSERTAR PARA numde
new.nomde  -- VALOR QUE PRETENDO INSERTAR PARA nomde
new.depende  -- VALOR QUE PRETENDO INSERTAR PARA depende
new.numce -- VALOR QUE PRETENDO INSERTAR PARA numce
new.presude -- VALOR QUE PRETENDO INSERTAR PARA presude

VALORES DE OLD Y NEW

-- trigger DELETE

old.numde -- VALOR DE LA FILA QUE PRETENDO BORRAR PARA numde
old.nomde	-- VALOR DE LA FILA QUE PRETENDO BORRAR PARA  nomde
old.depende -- VALOR DE LA FILA QUE PRETENDO BORRAR PARA  depende
old.numce -- VALOR DE LA FILA QUE PRETENDO BORRAR PARA  numce
old.presude -- VALOR DE LA FILA QUE PRETENDO BORRAR PARA  presude


new.numde -- NULL
new.nomde  -- NULL
new.depende  -- NULL
new.numce -- NULL
new.presude -- NULL

VALORES DE OLD Y NEW

-- trigger UPDATE

old.numde -- VALOR ORIGINAL DE LA FILA QUE PRETENDO MODIFICAR PARA numde
old.nomde	-- VALOR ORIGINAL  DE LA FILA QUE PRETENDO MODIFICAR PARA  nomde
old.depende -- VALOR ORIGINAL DE LA FILA QUE PRETENDO MODIFICAR PARA  depende
old.numce -- VALOR ORIGINAL DE LA FILA QUE PRETENDO MODIFICAR PARA  numce
old.presude -- VALOR ORIGINAL DE LA FILA QUE PRETENDO MODIFICAR PARA  presude


new.numde -- VALOR NUEVO DE LA FILA QUE PRETENDO MODIFICAR PARA numde
new.nomde  -- VALOR ORIGINAL DE LA FILA QUE PRETENDO MODIFICAR PARA nomde
new.depende  -- -- VALOR ORIGINAL DE LA FILA QUE PRETENDO MODIFICAR PARA depende
new.numce -- VALOR ORIGINAL DE LA FILA QUE PRETENDO MODIFICAR PARA numce
new.presude -- VALOR ORIGINAL DE LA FILA QUE PRETENDO MODIFICAR PARA presude


update departamentos
set nomde = 'nuevo nombre',
	depende = 120
where numde = 130; -- finanzas depende de 100

old.numde -- 130
old.nomde	-- FINANZAS
old.depende -- 100
old.numce -- 10
old.presude -- 85000


new.numde -- 130
new.nomde  -- 'nuevo nombre'
new.depende  -- 120
new.numce -- 10
new.presude -- 85000

*/

/*
controlar mediante triggers que el depto no pueda tener un presupuesto mayor que su superior
si es así no debe permitirse la operación
*/
drop trigger if exists insertaDeptosBefore;
delimiter $$
CREATE TRIGGER insertaDeptosBefore
	BEFORE INSERT
	ON departamentos
FOR EACH ROW
begin
declare texto  varchar(100);
/* insert into departamentos (numde, numce, presude, depende, nomde)
				values (1070,20,110000,100, 'probando trigger'),
						(.... );
*/
if (select presude from departamentos where numde  = new.depende)< new.presude then
	-- evitar que se haga la insercción
    begin
		set texto = concat('No se puede insertar el departamento. El presupuesto de ', new.numde, ' es muy alto');
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = texto;
	end;
end if;
end $$
delimiter ;


drop trigger if exists modificaDeptosBefore;
delimiter $$
CREATE TRIGGER modificaDeptosBefore
	BEFORE UPDATE
	ON departamentos
FOR EACH ROW
begin
declare texto  varchar(100);
/* update departamentos
	set nomde = 'nombre cambiado'
   where numde = 110;
   
   update departamentos
	set depende = 120
   where numde = 110;
   
   update departamentos
	set presude = 40000
   where numde = 110;
*/
if old.presude <> new.presude and
	(select presude from departamentos where numde  = new.depende)< new.presude then
	-- evitar que se haga la insercción
    begin
		set texto = concat('No se puede modificar el departamento. El presupuesto de ', new.numde, ' es muy alto');
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = texto;
	end;
end if;
end $$
delimiter ;

-- ejemplo : no quiero que en la tabla empleados no haya menores de 16 años 

use empresaclase2;
delimiter $$ 
 create trigger compruebaEdad
	before insert
	on empleados
for each row
begin 
	if date_add(new.fecnaem, interval 16 year)>curdate() then -- solamente en los tirigger puedo acceder a los valores sin un select 
    
    -- no contratar (no hacer insert)
		signal sqlstate '45000'
        set message_text = 'El empleado no tiene la edad apropiada';
	end if;
end$$
delimiter ;

-- crear un trigger que:
-- la fecha de publicacion no sea anterior a la fecha de creación para gestionaTest

use GBDgestionaTests;
delimiter $$
	create trigger compruebaFecha
		before insert
        on tests
        for each row
	begin
    if new.fecpublic < new.feccreacion then
		signal sqlstate '45000'
        set message_text = 'La fecha es incorrecta';
	end if;
  end$$
  delimiter ;
    
 insert into tests
 (codtest, descrip, unidadtest, codmateria, repetible, feccreacion, fecpublic)
 values
 (0,'prueba', 1,1,0, '2022/5/12', '2022/5/11');

/*
trigger antes de actualizar
old==> los datos antes de la actualizacion
new==> los datos despues de la actualizacion

*/

delimiter $$
	create trigger compruebaFechaTestEditar
		before insert
        on tests
        for each row
	begin
    if (new.fecpublic <> old.fecpublic or new.feccreacion <> old.feccreacion) and new.fecpublic < new.feccreacion then
		signal sqlstate '45000'
        set message_text = 'La fecha es incorrecta';
	end if;
  end $$
  delimiter ;

update tests
set repetible=1
where codtest=8; -- no entrara dentro de if en el trigger

update tests
set fecpublic = '2022/4/30'
where codtest=8; 

/*
trigger sobre respuestas, cuando inserto respuestas

*/
drop trigger if exists compruebaRepiTest;
delimiter $$
	create trigger compruebaRepiTest
		before insert on respuestas
	for each row
    begin
    if (select repetible from tests where codtest = new.codtest)= 0 and 
		(select count(*)from respuestas where codtest = new.codtest and numexped = new.numexped)> 0 then
        signal sqlstate '45000' set message_text =' el tests no se puede repetir';
	end if;
	end$$
delimiter ;


/*
si un empleado es director de un depto en la actualidad no s e podra eliminar.
hacer el control de número de empleados en todas las operaciones de modidicacion de la tabla d empeleados
*/

