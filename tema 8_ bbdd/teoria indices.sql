create unique index dniempleado
	on empleados (dniem);
    create index buscanombre
		on empleados (ape1em(4), ape2em(4), nomem(3)); -- busque por los primeros cuatro  caracteres (4)
select * from empleados;


-- sentencia para ver los indices

show index from empleados;

-- para ver que va usar el select
explain select nomem 
from empleados use index (buscanombre) 
where ape1em like '%tort%' and ape2em  like'%per%'
order by ape1em;
-- como forzar a que se use el indice

select nomem 
from empleados use index (buscanombre) -- aqui le digo que use el index / o ignore index para que lo ignore
where ape1em like '%tort%' and ape2em  like'%per%';



select nomem 
from empleados ignore index (buscanombre) -- aqui le digo que use el index / o ignore index para que lo ignore
where ape1em like '%tort%' and ape2em  like'%per%';



explain select *
from empleados  join departamentos on empleados.numde = departamentos.numde
where dniem='456131313q';
