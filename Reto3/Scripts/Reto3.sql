DESC clientes;
DESC pedidos;
--------------------------------------------------------------
--Clientes que no tienen pedido facturado
CREATE OR REPLACE VIEW Clientes_pedidos_rechazados AS
SELECT c.NOM_CORTO AS NOMBRE_CLIENTE, p.VAL_ESTA_PEDI AS ESTADO_PEDIDO
FROM clientes c
INNER JOIN pedidos p on c.COD_CLIE = p.COD_CLIE
WHERE p.VAL_ESTA_PEDI <> 'FACTURADO';
COMMIT;

SELECT * FROM Clientes_pedidos_rechazados;

--------------------------------------------------------------    
--Pedidos cuyo cliente no existe en la tabla Clientes
CREATE OR REPLACE VIEW Pedidos_sin_clientes AS
SELECT p.VAL_NUME_SOLI AS PEDIDO, p.COD_CLIE AS CODIGO_CLIENTE
FROM pedidos p
LEFT JOIN clientes c ON p.COD_CLIE = c.COD_CLIE
WHERE c.cod_clie IS NULL;
COMMIT;

SELECT * FROM Pedidos_sin_clientes;

--------------------------------------------------------------
--Acumulado de atributo VAL_MONT_SOLI agrupado
CREATE OR REPLACE VIEW Vista_ACUMULADO AS
SELECT
    p.VAL_ESTA_PEDI AS Estado_Pedido,
    p.COD_REGI AS Region,
    SUM(p.VAL_MONT_SOLI) AS Total_Monto, 
    COUNT(*) AS Total_Registros
FROM
    PEDIDOS p
INNER JOIN
    CLIENTES c
ON
    p.COD_CLIE = c.COD_CLIE
WHERE
    TO_CHAR(p.FEC_FACT, 'MM') = '06'
GROUP BY
    p.VAL_ESTA_PEDI,
    p.COD_REGI;
COMMIT;

SELECT * FROM Vista_ACUMULADO;


--Total de registros por cada agrupación 
CREATE OR REPLACE VIEW V_Total_Registros AS
SELECT
    Estado_Pedido,
    Region,
    Total_Monto,
    Total_Registros
FROM
    Vista_ACUMULADO
WHERE
    Total_Registros > 500;
COMMIT;

SELECT * FROM V_Total_Registros;


