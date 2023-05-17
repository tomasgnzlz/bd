show variables like '%autocommit%';
-- sino cerramos la transaccion  con el autocommit se confirma la transaccion, el autocommit esta a 1 por defecto osea que esta a true
start transaction; -- transaccion 1 explicita (la marco yo)
insert into centros -- transaccion2 implicita (es interna)
	(numce, nomce, dirce)
    values
    (100, 'prueba transaccion', 'direccion prueba transaccion' ); -- finaliza la dos 
    
select * from centros;
commit;    -- rollback; finaliza la transaccion 1
select * from centros;