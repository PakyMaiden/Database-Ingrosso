--La carta non deve essere scaduta per poter convalidare gli acquisti

-- Evento DML: INSERT INTO
-- Tabella di appoggio: CARTA
-- Temporizzazione: BEFORE INSERT


--Intestazione
CREATE OR REPLACE TRIGGER Check_Carta
BEFORE INSERT ON CARTA
FOR EACH ROW

DECLARE
    DS_CARTA DATE;
    CARTA_SCADUTA EXCEPTION;

BEGIN
    --Codice che gestisce l'inserimento
    IF INSERTING THEN
        SELECT MAX(DATA_SCADENZA_CARTA) INTO DS_CARTA
        FROM CARTA
        WHERE NUM_CARTA = :NEW.NUM_CARTA;

        IF DS_CARTA <= SYSDATE THEN
            RAISE CARTA_SCADUTA;
        END IF;

    END IF;

EXCEPTION
    WHEN CARTA_SCADUTA THEN
        		RAISE_APPLICATION_ERROR(-20001, 'Attenzione la carta del cliente è scaduta!');

END;


--TEST:

--INSERT INTO CLIENTE(ID_CLIENTE) VALUES (1);

--INSERT INTO CARTA (NUM_CARTA, ID_CLIENTE, DATA_SCADENZA_CARTA, TIPO_CARTA) VALUES ('PIPPO17140339096', 1, TO_DATE('04/2020', 'MM/YYYY'), 'JCB');