--Corroborar el estado actual de la tabla
SELECT * FROM clientes;

--------------------------------------------------------
--Agregar los atributos NOM_CORTO y EDAD
ALTER TABLE CLIENTES
ADD(
    NOM_CORTO VARCHAR2(100),
    EDAD NUMBER(3,0)
);
COMMIT;
--Verificar actualizaci�n de atributos
DESC clientes;
-------------------------------------------------------
--Actualizar el atributo NOM_CORTO
UPDATE clientes
SET NOM_CORTO = INITCAP(VAL_NOM1)||' '||INITCAP(VAL_APE1);
COMMIT;
--Corroborar actualizaci�n correcta de NOM_CORTO
SELECT VAL_NOM1,VAL_APE1,NOM_CORTO
FROM clientes;
-------------------------------------------------------
--Actualizar el atributo Edad
UPDATE clientes
SET EDAD = TRUNC(MONTHS_BETWEEN(SYSDATE, FEC_NACI)/12);
COMMIT;
--Corroborar actualizaci�n correcta de EDAD
SELECT fec_naci, EDAD
FROM clientes;
------------------------------------------------------
--Actualizar atributos VAL_APE1 y VAL_APE2
UPDATE clientes
SET VAL_APE1 = REPLACE(VAL_APE1,'�','N'),
    VAL_APE2 = REPLACE(VAL_APE2,'�','N');
COMMIT;
--Corroborar actualizaci�n de los atributos
SELECT val_ape1, val_ape2
FROM clientes;   
------------------------------------------------------
--Creaci�n de vistas
CREATE VIEW VISTA_ACTUALIZACIONES as
SELECT (VAL_NOM1||' '||VAL_APE1||' '||VAL_APE2) as NOMBRES,
        NOM_CORTO, FEC_NACI, EDAD
FROM clientes;
COMMIT;
--Corroborar creaci�n de vista
SELECT * FROM VISTA_ACTUALIZACIONES;

      
    
    
