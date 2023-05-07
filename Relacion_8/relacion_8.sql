-- Para la base de datos empresa_clase:
-- 1. Sabiendo que en la extensión de teléfono que utilizan los empleados,el primer dígito corresponde con el edificio, el segundo con la planta 
-- y el tercero con la puerta. Busca aquellos empleados que trabajan en la misma planta (aunque sea en edificios diferentes) que el empleado 120.
use empresaclase;
	select empleados.extelem as ExtensionTelefónica
		from empleados
		where empleados.extelem regexp "[0-9]{1}[4]{1}[0-9]{1}";

-- Para la base de datos turRural:
use gbdturrural2015;
-- 1. Sabiendo que los dos primeros dígitos del código postal se corresponden con la provincia y los 3 siguientes a la población dentro de esa provincia. 
--    Busca los clientes (todos sus datos) de las 9 primeras poblaciones de la provincia de Málaga (29001 a 29009). ¿?¿?¿ NO LO ENTIENDO
-- 2. Sabiendo que los dos primeros dígitos del código postal se corresponden con la provincia y los 3 siguientes a la población dentro de esa provincia. 
--    Busca los clientes (todos sus datos) de las 20 primeras poblaciones de la provincia de Málaga (29001 a 29020). ¿?¿?¿ NO ENTIENDO

-- 3. Queremos encontrar clientes con direcciones de correo válidas, para ello queremos 
--    buscar aquellos clientes cuya dirección de email contiene una “@”, y termina en un símbolo punto (.) seguido de “com”, “es”, “eu” o “net”.

	select * 	
		from clientes
			where clientes.correoelectronico regexp "[a-z A-Z 0-9][@][a-z A-Z][.com|.es|.eu|.net]";
    
-- 4. Queremos encontrar ahora aquellos clientes que no cumplan con la expresión regular anterior.

	select *
		from clientes
			where clientes.correoelectronico not regexp "[a-z A-Z 0-9][@][a-z A-Z][.com|.es|.eu|.net]";
