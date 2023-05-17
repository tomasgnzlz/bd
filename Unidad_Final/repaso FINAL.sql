CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT,
    salario DECIMAL(10, 2)
);

create table if not exists profesorado (
	
    coddepto int unsigned,
    codprof int unsigned,
    codciudadano int unsigned,
    
    constraint pk_coddepto primary key (coddepto , codprof),
    
    constraint fk_profesorado_deptos  foreign key (coddepto)
        references deptos(coddepto)
			on delete no action on update cascade,
        
	constraint fk_profesorado_ciudadanos  foreign key (codciudadano)
		references ciudadanos(codciudadano)
			on delete no action on update cascade

);

INSERT INTO empleados (nombre, edad, salario)
VALUES ('Juan Pérez', 30, 2500.00);


UPDATE empleados
SET salario = 3000.00
WHERE id = 1;


DELETE FROM empleados
WHERE id = 1;

/*SELECT: Se utiliza para recuperar datos de una o varias tablas.*/
SELECT * FROM empleados;

/*WHERE: Se utiliza para filtrar los resultados de una consulta.*/
SELECT * FROM empleados WHERE edad > 25;

/*ORDER BY: Se utiliza para ordenar los resultados de una consulta en función de una o más columnas.*/
SELECT * FROM empleados ORDER BY salario DESC;

/*JOIN: Se utiliza para combinar registros de dos o más tablas en función de una condición de unión.*/
SELECT empleados.nombre, departamentos.nombre
FROM empleados
JOIN departamentos ON empleados.departamento_id = departamentos.id;

/*GROUP BY: Se utiliza para agrupar los resultados de una consulta en función de una o más columnas.*/
SELECT departamento_id, AVG(salario)
FROM empleados
GROUP BY departamento_id;

/*HAVING: Se utiliza para filtrar los resultados de una consulta agrupada.*/
SELECT departamento_id, AVG(salario)
FROM empleados
GROUP BY departamento_id
HAVING AVG(salario) > 3000;


