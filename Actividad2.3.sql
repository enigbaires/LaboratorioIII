-- 1	La cantidad de colaboradores

SELECT COUNT(ID) AS  'Cantidad de Colaboradores' FROM Colaboradores

-- 2	La cantidad de colaboradores nacidos entre 1990 y 2000.

SELECT COUNT(ID) AS  'Cantidad de Colaboradores Centennials' 
FROM Colaboradores
WHERE FechaNacimiento BETWEEN '1990-01-01' AND '2000-12-31'

-- 3	El promedio de precio hora base de los tipos de tareas

SELECT CAST((ROUND(AVG(PrecioHoraBase), 0, 0)) AS INT) AS 'Promedio Hora Base'
FROM TiposTarea

-- 4	El promedio de costo de los proyectos iniciados en el año 2019.

SELECT CAST((ROUND(AVG(CostoEstimado), 0, 0)) AS INT) AS 'Promedio Costo 2019'
FROM Proyectos
WHERE FechaInicio BETWEEN '2019-01-01' AND '2019-12-31'

-- 5	El costo más alto entre los proyectos de clientes de tipo 'Unicornio'

SELECT CAST((ROUND(MAX(P.CostoEstimado), 0, 0)) AS INT) AS 'Costo Max Unicornio'
FROM Proyectos AS P
INNER JOIN Clientes AS C ON P.IDCliente = C.ID
INNER JOIN TiposCliente AS T ON C.IDTipo = T.ID
WHERE T.Nombre = 'Unicornio'

-- 6	El costo más bajo entre los proyectos de clientes del país 'Argentina'

SELECT CAST((ROUND(MIN(PR.CostoEstimado), 0, 0)) AS INT) AS 'Costo Min Argentina'
FROM Proyectos AS PR
INNER JOIN Clientes AS CL ON PR.IDCliente = CL.ID
INNER JOIN Ciudades AS CI ON CL.IDCiudad = CI.ID
INNER JOIN Paises AS PA ON CI.IDPais = PA.ID
WHERE PA.Nombre = 'Argentina'

-- 7	La suma total de los costos estimados entre todos los proyectos.

SELECT CAST((ROUND(SUM(CostoEstimado), 0, 0)) AS INT) AS 'Suma de Costos'
FROM Proyectos

-- 8	Por cada ciudad, listar el nombre de la ciudad y la cantidad de clientes.

SELECT CI.Nombre, COUNT(CL.ID) AS 'Cantidad de Clientes'
FROM Ciudades AS CI
LEFT JOIN Clientes AS CL ON CI.ID = CL.IDCiudad
GROUP BY CI.Nombre

-- 9	Por cada país, listar el nombre del país y la cantidad de clientes.

SELECT P.Nombre, COUNT(CL.ID) AS 'Cantidad de Clientes'
FROM Paises AS P
LEFT JOIN Ciudades AS C ON P.ID = C.IDPais
LEFT JOIN Clientes AS CL ON C.ID = CL.IDCiudad
GROUP BY P.Nombre

-- 10	Por cada tipo de tarea, la cantidad de colaboraciones registradas. 
--      Indicar el tipo de tarea y la cantidad calculada.

SELECT TT.Nombre, COUNT(C.IDColaborador) AS 'Cantidad de Colaboraciones'
FROM TiposTarea AS TT
LEFT JOIN Tareas AS T ON TT.ID = T.IDTipo
LEFT JOIN Colaboraciones AS C ON T.ID = C.IDTarea
GROUP BY TT.Nombre

-- 11	Por cada tipo de tarea, la cantidad de colaboradores distintos que la 
--      hayan realizado. Indicar el tipo de tarea y la cantidad calculada.

SELECT TT.Nombre AS 'Tipo Tarea', COUNT(CC.IDColaborador) AS 'QTY Colaboradores'
FROM TiposTarea AS TT
LEFT JOIN Tareas AS T ON TT.ID = T.IDTipo
LEFT JOIN Colaboraciones AS CC ON T.ID = CC.IDTarea
GROUP BY TT.Nombre

-- 12	Por cada módulo, la cantidad total de horas trabajadas. Indicar el ID, 
--      nombre del módulo y la cantidad totalizada. Mostrar los módulos sin horas 
--      registradas con 0.

SELECT M.ID, M.Nombre, ISNULL(SUM(C.Tiempo), 0) AS 'Total Horas Trabajadas'
FROM Modulos AS M
LEFT JOIN Tareas AS T ON M.ID = T.IDModulo
LEFT JOIN Colaboraciones AS C ON T.ID = C.IDTarea
GROUP BY M.ID, M.Nombre

-- 13	Por cada módulo y tipo de tarea, el promedio de horas trabajadas. Indicar el
--      ID y nombre del módulo, el nombre del tipo de tarea y el total calculado.

SELECT	M.ID AS 'ID Modulo', M.Nombre AS 'Nombre del modulo',
		TT.Nombre AS 'Nombre del Tipo de Tarea', CASE WHEN CONVERT(VARCHAR(10), AVG(C.Tiempo)) IS NULL THEN 'Sin Colaboraciones' ELSE CONVERT(VARCHAR(10), AVG(C.Tiempo)) END AS 'Promedio'
FROM Tareas AS T 
INNER JOIN TiposTarea AS TT ON T.IDTipo = TT.ID
LEFT JOIN Modulos AS M ON T.IDModulo = M.ID
LEFT JOIN Colaboraciones AS C ON T.ID = C.IDTarea
GROUP BY M.ID, M.Nombre, TT.Nombre
ORDER BY TT.Nombre

-- 14	Por cada módulo, indicar su ID, apellido y nombre del colaborador y total que
--      se le debe abonar en concepto de colaboraciones realizadas en dicho módulo.

SELECT M.ID AS 'ID Modulo', CB.Apellido +', '+ CB.Nombre AS 'Nombre y Apellido', '$ ' + CONVERT(VARCHAR(15), SUM(CC.Tiempo*CC.PrecioHora)) AS 'Total Abonar'
FROM Modulos AS M
LEFT JOIN Tareas AS T ON M.ID = T.IDModulo
LEFT JOIN Colaboraciones AS CC ON T.ID = CC.IDTarea
RIGHT JOIN Colaboradores AS CB ON CC.IDColaborador = CB.ID
GROUP BY M.ID, CB.Apellido, CB.Nombre
ORDER BY M.ID

-- 15	Por cada proyecto indicar el nombre del proyecto y la cantidad de horas 
--      registradas en concepto de colaboraciones y el total que debe abonar en 
--      concepto de colaboraciones.

SELECT P.Nombre AS 'Nombre del Proyecto', ISNULL(SUM(C.Tiempo), 0) AS Tiempo,  '$ ' + ISNULL(CONVERT(VARCHAR(15), SUM(C.Tiempo*C.PrecioHora)), 0) AS 'Precio a Pagar'
FROM Proyectos AS P
LEFT JOIN Modulos AS M ON P.ID = M.IDProyecto
LEFT JOIN Tareas AS T ON M.ID = T.IDModulo
LEFT JOIN Colaboraciones AS C ON T.ID = C.IDTarea
GROUP BY P.Nombre


-- 16	Listar los nombres de los proyectos que hayan registrado menos de cinco 
--      colaboradores distintos y más de 100 horas total de trabajo.

SELECT P.Nombre
FROM Proyectos AS P
INNER JOIN Modulos AS M ON P.ID = M.IDProyecto
INNER JOIN Tareas AS T ON M.ID = T.IDModulo
INNER JOIN Colaboraciones AS C ON T.ID = C.IDTarea
GROUP BY P.Nombre
HAVING COUNT(C.IDColaborador) < 5 AND SUM(C.Tiempo) > 100

-- 17	Listar los nombres de los proyectos que hayan comenzado en el año 2020 que
--      hayan registrado más de tres módulos.

SELECT P.Nombre --, P.FechaInicio, COUNT(M.ID)
FROM Proyectos AS P
INNER JOIN Modulos AS M ON P.ID = M.IDProyecto
GROUP BY P.Nombre, P.FechaInicio
HAVING COUNT(M.ID) > 3 AND YEAR(P.FechaInicio) = 2020

-- 18	Listar para cada colaborador externo, el apellido y nombres y el tiempo máximo
--      de horas que ha trabajo en una colaboración. 

SELECT CB.Apellido +', '+ CB.Nombre AS 'Nompre y Apellido', MAX(CC.Tiempo) AS 'Tiempo Maximo'
FROM Colaboradores AS CB
INNER JOIN Colaboraciones AS CC ON CB.ID = CC.IDColaborador
WHERE CB.Tipo = 'E'
GROUP BY CB.Apellido, CB.Nombre


-- 19	Listar para cada colaborador interno, el apellido y nombres y el promedio 
--      percibido en concepto de colaboraciones.

SELECT CB.Apellido, CB.Nombre, '$ ' + CONVERT(VARCHAR(10),CONVERT(INT, AVG(CC.PrecioHora*CC.Tiempo))) AS 'Promedio Colaboracion'
FROM Colaboradores AS CB
INNER JOIN Colaboraciones AS CC ON CB.ID = CC.IDColaborador
WHERE CB.Tipo = 'I'
GROUP BY CB.Apellido, CB.Nombre

-- 20	Listar el promedio percibido en concepto de colaboraciones para colaboradores 
--      internos y el promedio percibido en concepto de colaboraciones para colaboradores 
--      externos.

SELECT CASE WHEN CB.Tipo = 'I' THEN 'INTERNO' ELSE 'EXTERNO' END AS TIPO, '$  ' + CONVERT(VARCHAR(10), CONVERT(INT, AVG(CC.PrecioHora*CC.Tiempo))) AS Promedio
FROM Colaboraciones AS CC
INNER JOIN Colaboradores AS CB ON CC.IDColaborador = CB.ID
GROUP BY CB.Tipo

-- 21	Listar el nombre del proyecto y el total neto estimado. Este último valor surge
--      del costo estimado menos los pagos que requiera hacer en concepto de colaboraciones.

SELECT P.Nombre, ISNULL(P.CostoEstimado - SUM(C.Tiempo*C.PrecioHora), P.CostoEstimado) AS 'Total Neto Estimado'
FROM Proyectos AS P
LEFT JOIN Modulos AS M ON P.ID = M.IDProyecto
LEFT JOIN Tareas AS T ON M.ID = T.IDModulo
LEFT JOIN Colaboraciones AS C ON T.ID = C.IDTarea
GROUP BY P.Nombre, P.CostoEstimado

-- 22	Listar la cantidad de colaboradores distintos que hayan colaborado en alguna tarea
--      que correspondan a proyectos de clientes de tipo 'Unicornio'.

--SELECT P.Nombre AS PROYECTO, CB.Apellido, M.Nombre AS MODULO, C.RazonSocial, TC.Nombre AS TIPO
SELECT COUNT(DISTINCT CB.ID) AS CANTIDAD
FROM Colaboradores AS CB
INNER JOIN Colaboraciones AS CC ON CB.ID = CC.IDColaborador
INNER JOIN Tareas AS T ON CC.IDTarea = T.ID
INNER JOIN Modulos AS M ON T.IDModulo = M.ID
INNER JOIN Proyectos AS P ON T.IDModulo = T.ID
INNER JOIN Clientes AS C ON P.IDCliente = C.ID
INNER JOIN TiposCliente AS TC ON C.IDTipo = TC.ID
WHERE TC.Nombre = 'Unicornio'
--ORDER BY P.Nombre

-- 23	La cantidad de tareas realizadas por colaboradores del país 'Argentina'.

SELECT COUNT(DISTINCT T.ID) AS CANTIDAD
FROM Paises AS P
INNER JOIN Ciudades AS C ON P.ID = C.IDPais
INNER JOIN Colaboradores AS CB ON C.ID = CB.IDCiudad
INNER JOIN Colaboraciones AS CC ON CB.ID = CC.IDColaborador
INNER JOIN Tareas AS T ON CC.IDTarea = T.ID
WHERE P.Nombre = 'Argentina'

-- 24	Por cada proyecto, la cantidad de módulos que se haya estimado mal la fecha de fin.
--      Es decir, que se haya finalizado antes o después que la fecha estimada. Indicar el 
--      nombre del proyecto y la cantidad calculada.

SELECT P.Nombre AS PROYECTO, COUNT(M.ID) AS CANTIDAD--M.Nombre AS MODULO, M.FechaEstimadaFin, M.FechaFin, DATEDIFF(DAY, M.FechaEstimadaFin, M.FechaFin)AS DIAS
FROM Proyectos AS P
INNER JOIN Modulos AS M ON P.ID = M.IDProyecto
WHERE DATEDIFF(DAY, M.FechaEstimadaFin, M.FechaFin) <> 0
GROUP BY P.Nombre
