-- Sobre la base de datos empresa_clase (POR EJEMPLO):
use empresaclase;

-- 1. Crea un procedimiento que devuelva el año actual
drop procedure if exists añoActual;
delimiter $$
create procedure añoActual ()
begin
	select curdate() as AñoActual;
end $$
delimiter ;
-- call añoActual();
-- 2. Crea una función que devuelva el año actual.
drop function if exists añoActualfuncion;
delimiter $$
create function añoActualfuncion ()
returns date
deterministic
begin
	return(
			select curdate() as AñoActual
		  );
end $$
delimiter ;
-- select añoActualfuncion();
-- 3. Crea un procedimiento que muestre las tres primeras letras de una cadena pasada como parámetro en mayúsculas.
drop procedure if exists letras;
delimiter $$
create procedure letras (in txt varchar(30))
begin
	select upper(left(txt, 3));
end $$
delimiter ;
call letras('tomas');
-- 4. Crea un procedimiento que devuelva una cadena formada por dos cadenas, pasadas como parámetros, concatenadas y en mayúsculas.
drop procedure if exists letras_2;
delimiter $$
create procedure letras_2 (in txt1 varchar(30), in txt2 varchar(30))
begin
	select upper(concat(txt1,txt2)) as CadenaConcatenadaMayus;
end $$
delimiter ;
call letras_2('tomas','ariel');
-- 5. Crea una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.
drop function if exists hipotenusa;
delimiter $$
create function hipotenusa(lado1 int, lado2 int)
returns double
deterministic
begin 
	return(
		select sqrt( (lado1*lado1) + (lado2*lado2) ) as Hipotenusa
    );
end $$
delimiter ;
 -- select hipotenusa(16, 36); ¿?¿?
-- 6. Crea una función que devuelva 1 ó 0 en función de si un número es o no divisible por otro.
drop function if exists unoCero;
delimiter $$
create function unoCero(dividendo int, divisor int)
returns int
deterministic
begin 
	declare resultado int;
    -- Compruebo que el numero por el qe se quiere dividir no es CERO, si lo es se pone a resultado como null
	  if divisor <> 0 then -- <> diferente
		set resultado = dividendo % divisor;
	  else
		set resultado = null;
	  end if;
	  -- si lo de arriba no es null, entonces se devuelve 1 ó 0 dependiendo si el resto da cero o no
	  if resultado = 0 then
		return 1;
	  else
		return 0;
	  end if;
end $$
delimiter ;
select unoCero(5,9);

-- 7. Crea una función que devuelva el día de la semana (lunes, martes, ...) en función de un número de entrada (1: lunes, 2:martes, ...).
drop function if exists weekDays;
delimiter $$
create function weekDays(num int)
returns varchar(30)
deterministic
begin 
	return(
			(CASE
				WHEN num = 1 then "Lunes"
                WHEN num = 2 then "Martes"
                WHEN num = 3 then "Miercoles"
                WHEN num = 4 then "Jueves"
                WHEN num = 5 then "Viernes"
                WHEN num = 6 then "Sabado"
                WHEN num = 7 then "Domingo"
				ELSE "ERROR, Introduce un n1 correcto(1-7)"
			END)
    );
end $$
delimiter ;
-- select weekDays(2);

-- 8. Crea una función que devuelva el mayor de tres números que pasamos como parámetros.
drop function if exists numMayor;
delimiter $$
create function numMayor(num1 int, num2 int, num3 int)
returns int
deterministic
begin 
	declare resultado int;
			if num1 > num2 and num1 > num3  then
				set resultado = num1;
			elseif num2 > num3 and num2 > num1  then
				set resultado = num2;
			else
				set resultado = num3;
			end if;
              return (resultado);
end $$
delimiter ;
-- select numMayor (1,2,3);

-- 9. Crea una función que diga si una palabra, que pasamos como parámetros, es palíndroma.
-- 10. Crea un procedimiento que muestre la suma de los primeros n números enteros, siendo n un parámetro de entrada.
-- 11. Prepara un procedimiento que muestre la suma de los términos 1/n con n entre 1
-- y m (1/2 + 1/3 + 1⁄4 +...), siendo m un parámetro de entrada.
-- 12. Crea una función que determine si un número es primo o no (devolverá 0 ó 1).
drop function if exists numPrimo;
delimiter $$
create function numPrimo(num int)
returns int
deterministic
begin 
	declare i int;
    declare limite int;
    set i = 2;
    set limite = floor(sqrt(num));
    while (i <= limite) do
       iF (num % i = 0) then
            return 0;
        end if;
        set i = i + 1;
    end while;
    return 1;
end $$
delimiter ;
-- select numPrimo(5);
-- 13. Crea una función que calcule la suma de los primeros m números primos empezando por el 1. Utiliza la función del apartado anterior.
DROP FUNCTION IF EXISTS sumaPrimerosPrimos;
DELIMITER $$
CREATE FUNCTION sumaPrimerosPrimos(m INT) 
RETURNS INT
deterministic
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE contador INT DEFAULT 0;
    DECLARE suma INT DEFAULT 0;
    WHILE (contador < m) DO
        IF (numPrimo(i) = 1) THEN
            SET suma = suma + i;
            SET contador = contador + 1;
        END IF;
        SET i = i + 1;
    END WHILE;
    RETURN suma;
END $$
DELIMITER ;
SELECT sumaPrimerosPrimos(10);
-- 14. Crea un procedimiento que almacene en una tabla (primos (id, numero)) los
-- primeros números primos comprendidos entre 1 y m (m es parámetro de entrada).
-- 15. Modifica el procedimiento anterior para que se almacene en un parámetro de salida el número de primos almacenados.