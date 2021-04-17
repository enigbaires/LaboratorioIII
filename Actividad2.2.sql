-- 1) Por cada cliente listar razón social, cuit y nombre del tipo de cliente.

SELECT C.RazonSocial, C.Cuit, T.Nombre AS 'Tipo de Cliente' FROM Clientes AS C
INNER JOIN TiposCliente AS T ON C.IDTipo = T.ID

-- 2) Por cada cliente listar razón social, cuit y nombre de la ciudad y nombre del país. Sólo de aquellos clientes que posean ciudad y país.

SELECT CL.RazonSocial, CL.Cuit, CI.Nombre AS 'Ciudad', P.Nombre AS 'Pais' FROM Clientes AS CL
INNER JOIN Ciudades AS CI ON CL.IDCiudad = CI.ID
INNER JOIN Paises AS P ON CI.IDPais = P.ID

-- 3) Por cada cliente listar razón social, cuit y nombre de la ciudad y nombre del país. 
--    Listar también los datos de aquellos clientes que no tengan ciudad relacionada.

SELECT CL.RazonSocial, CL.Cuit, CI.Nombre AS 'Ciudad', P.Nombre AS 'Pais' FROM Clientes AS CL
LEFT JOIN Ciudades AS CI ON CL.IDCiudad = CI.ID
LEFT JOIN Paises AS P ON CI.IDPais = P.ID

-- 4) Por cada cliente listar razón social, cuit y nombre de la ciudad y nombre del país. 
--    Listar también los datos de aquellas ciudades y países que no tengan clientes relacionados.

SELECT CL.RazonSocial, CL.Cuit, CI.Nombre AS 'Ciudad', P.Nombre AS 'Pais' FROM Clientes AS CL
RIGHT JOIN Ciudades AS CI ON CL.IDCiudad = CI.ID
RIGHT JOIN Paises AS P ON CI.IDPais = P.ID

-- 5) Listar los nombres de las ciudades que no tengan clientes asociados. 
--    Listar también el nombre del país al que pertenece la ciudad.

SELECT CI.Nombre AS 'Ciudad', P.Nombre AS 'Pais' FROM Clientes AS CL  
RIGHT JOIN Ciudades AS CI ON CL.IDCiudad = CI.ID
INNER JOIN Paises AS P ON CI.IDPais = P.ID
WHERE CL.IDCiudad IS NULL

-- 6) Listar para cada proyecto el nombre del proyecto, el costo, la razón social del cliente, el nombre del tipo 
--    de cliente y el nombre de la  ciudad (si la tiene registrada) de aquellos clientes cuyo tipo de cliente sea 
--    'Extranjero' o 'Unicornio'.

SELECT	P.Nombre, P.CostoEstimado, 
		CL.RazonSocial, 
		T.Nombre AS 'Tipo de Cliente',
		CI.Nombre AS 'Ciudad'
FROM Proyectos AS P
LEFT JOIN Clientes AS CL ON P.IDCliente = CL.ID
INNER JOIN TiposCliente AS T ON CL.IDTipo = T.ID
INNER JOIN Ciudades AS CI ON CL.IDCiudad = CI.ID
WHERE T.Nombre = 'Extranjero' OR T.Nombre = 'Unicornio'

-- 7) Listar los nombre de los proyectos de aquellos clientes que sean de los países 'Argentina' o 'Italia'.

SELECT	PR.Nombre AS 'Proyecto'				
FROM Proyectos AS PR
INNER JOIN Clientes AS CL ON PR.IDCliente = CL.ID
INNER JOIN Ciudades AS CI ON CL.IDCiudad = CI.ID
INNER JOIN Paises AS PA ON CI.IDPais = PA.ID
WHERE PA.Nombre IN('Argentina', 'Italia')

-- 8) Listar para cada módulo el nombre del módulo, el costo estimado del módulo, el nombre del proyecto, 
--    la descripción del proyecto y el costo estimado del proyecto de todos aquellos proyectos que hayan finalizado.

SELECT M.Nombre AS 'Modulo', M.CostoEstimado, P.Nombre AS 'Proyecto', P.Descripcion AS 'Descripcion Proyecto'
FROM Modulos AS M
INNER JOIN Proyectos AS P ON M.IDProyecto = P.ID
WHERE P.FechaFin IS NOT NULL

-- 9) Listar los nombres de los módulos y el nombre del proyecto de aquellos módulos cuyo tiempo estimado de realización 
--    sea de más de 100 horas.

SELECT M.Nombre AS 'Modulo', P.Nombre AS 'Proyecto'
FROM Modulos AS M
INNER JOIN Proyectos AS P ON M.IDProyecto = P.ID
WHERE M.TiempoEstimado > 100

-- 10) Listar nombres de módulos, nombre del proyecto, descripción y tiempo estimado de aquellos módulos cuya fecha 
--     estimada de fin sea mayor a la  fecha real de fin y el costo estimado del proyecto sea mayor a cien mil.

SELECT M.Nombre AS 'Modulo', P.Nombre AS 'Proyecto', P.Descripcion, M.TiempoEstimado
FROM Modulos AS M
INNER JOIN Proyectos AS P ON M.IDProyecto = P.ID
WHERE M.FechaEstimadaFin > M.FechaFin AND P.CostoEstimado > 100000

-- 11) Listar nombre de proyectos, sin repetir, que registren módulos que hayan finalizado antes que el tiempo estimado. 3

SELECT DISTINCT P.Nombre
FROM Proyectos AS P
INNER JOIN Modulos AS M ON P.ID = M.IDProyecto
WHERE M.FechaEstimadaFin > M.FechaFin

-- 12) Listar nombre de ciudades, sin repetir, que no registren clientes pero sí colaboradores.

SELECT DISTINCT CI.Nombre
FROM Ciudades AS CI
LEFT JOIN Clientes AS CL ON CL.IDCiudad = CI.ID
LEFT JOIN Colaboradores AS CO ON CO.IDCiudad = CI.ID
WHERE CL.ID IS NULL AND CO.ID IS NOT NULL

-- 13) Listar el nombre del proyecto y nombre de módulos de aquellos módulos que contengan la palabra 'login' 
--     en su nombre o descripción.

SELECT P.Nombre AS 'Proyecto', M.Nombre AS 'Modulo', M.Descripcion
FROM Proyectos AS P
INNER JOIN Modulos AS M ON P.ID = M.IDProyecto
WHERE M.Nombre NOT LIKE '%LOGIN%' AND M.Descripcion NOT LIKE '%LOGIN%'

-- 14) Listar el nombre del proyecto y el nombre y apellido de todos los colaboradores que hayan realizado algún 
--     tipo de tarea cuyo nombre contenga  'Programación' o 'Testing'. Ordenarlo por nombre de proyecto de manera ascendente.

SELECT P.Nombre AS 'Nombre del proyecto', CB.Nombre AS 'Nombre del colaborador', CB.Apellido, TT.Nombre AS 'Tipo Tarea'
FROM Tareas AS T
INNER JOIN Colaboraciones AS CC ON T.ID = CC.IDTarea
INNER JOIN Modulos AS M ON T.IDModulo = M.ID
INNER JOIN Colaboradores AS CB ON CC.IDColaborador = CB.ID
INNER JOIN Proyectos AS P ON M.IDProyecto = P.ID
INNER JOIN TiposTarea AS TT ON T.IDTipo = TT.ID
WHERE TT.Nombre LIKE '%PROGRAMACIÓN%' OR TT.Nombre LIKE '%TESTING%'
ORDER BY P.Nombre ASC

-- 15) Listar nombre y apellido del colaborador, nombre del módulo, nombre del tipo de tarea, precio hora de la 
--     colaboración y precio hora base de aquellos colaboradores que hayan cobrado su valor hora de colaboración más 
--     del 50% del valor hora base.

SELECT	CB.Apellido + ' ' + CB.Nombre AS 'Nombre y Apellido',
		M.Nombre AS 'Modulo',
		TT.Nombre AS 'Tipo Tarea',
		CC.PrecioHora AS 'Precio Hora Colaboracion',
		TT.PrecioHoraBase AS 'Precio Hora Base'
FROM Colaboradores AS CB
INNER JOIN Colaboraciones AS CC ON CB.ID = CC.IDColaborador
INNER JOIN Tareas AS T ON CC.IDTarea = T.ID
INNER JOIN Modulos AS M ON T.IDModulo = M.ID
INNER JOIN TiposTarea AS TT ON T.IDTipo = TT.ID
WHERE CC.PrecioHora > TT.PrecioHoraBase*1.5

-- 16) Listar nombres y apellidos de las tres colaboraciones de colaboradores externos que más hayan demorado en realizar 
--     alguna tarea cuyo nombre de  tipo de tarea contenga 'Testing'.

SELECT TOP 3 CB.Apellido + ' ' + CB.Nombre AS 'Nombre y Apellido'				
FROM Colaboraciones AS CC
INNER JOIN Colaboradores AS CB ON CC.IDColaborador = CB.ID
INNER JOIN Tareas AS T ON CC.IDTarea = T.ID
INNER JOIN TiposTarea AS TT ON T.IDTipo = TT.ID
WHERE CB.Tipo = 'E' AND TT.Nombre LIKE '%TESTING%'
ORDER BY CC.Tiempo DESC

-- 17) Listar apellido, nombre y mail de los colaboradores argentinos que sean internos y cuyo mail no contenga '.com'.

SELECT	CO.Apellido + ' ' + CO.Nombre AS 'Nombre y Apellido', CO.EMail
FROM Colaboradores AS CO
INNER JOIN Ciudades AS CI ON CO.IDCiudad = CI.ID
INNER JOIN Paises AS P ON CI.IDPais = P.ID
WHERE CO.Tipo = 'I' AND P.Nombre = 'Argentina' AND CO.EMail NOT LIKE '%.com%'

-- 18) Listar nombre del proyecto, nombre del módulo y tipo de tarea de aquellas tareas realizadas por colaboradores externos.

SELECT DISTINCT P.Nombre AS 'Proyecto', M.Nombre AS 'Modulo', TT.Nombre AS 'Tipo Tarea'
FROM Proyectos AS P
INNER JOIN Modulos AS M ON P.ID = M.IDProyecto
INNER JOIN Tareas AS T ON M.ID = T.IDModulo
INNER JOIN TiposTarea AS TT ON T.IDTipo = TT.ID
INNER JOIN Colaboraciones AS CC ON T.ID = CC.IDTarea
INNER JOIN Colaboradores AS CB ON CC.IDColaborador = CB.ID
WHERE CB.Tipo = 'E'

-- 19) Listar nombre de proyectos que no hayan registrado tareas.

SELECT P.Nombre AS 'Proyecto'
FROM Proyectos AS P
LEFT JOIN Modulos AS M ON P.ID = M.IDProyecto
LEFT JOIN Tareas AS T ON M.ID = T.IDModulo
WHERE T.ID IS NULL

-- 20) Listar apellidos y nombres, sin repeticiones, de aquellos colaboradores que hayan trabajado en algún proyecto 
--     que aún no haya finalizado.

SELECT DISTINCT CB.Apellido + ' ' + CB.Nombre AS 'Nombre y Apellido'
FROM Proyectos AS P
INNER JOIN Modulos AS M ON P.ID = M.IDProyecto
INNER JOIN Tareas AS T ON M.ID = T.IDModulo
INNER JOIN Colaboraciones AS CC ON T.ID = CC.IDTarea
INNER JOIN Colaboradores AS CB ON CC.IDColaborador = CB.ID
WHERE P.FechaFin IS NULL
