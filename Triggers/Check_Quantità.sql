--Va notificato se una quantità di prodotti è esaurita (la quantità non può assumere un valore negativo)

-- Evento DML: INSERT INTO
-- Tabella di appoggio: INVENTARIO
-- Temporizzazione: BEFORE INSERT

--Intestazione
CREATE OR REPLACE TRIGGER Check_Quantita
BEFORE INSERT ON INVENTARIO
FOR EACH ROW

DECLARE
    ESAURITO EXCEPTION;
    QUANTITA_ NUMBER :=0;

BEGIN
    --Codice che gestisce l'inserimento
    IF INSERTING THEN
        SELECT MAX(QUANTITA_INV) INTO QUANTITA_
        FROM INVENTARIO
        WHERE QUANTITA_INV = :NEW.QUANTITA_INV;

        IF :NEW.QUANTITA_INV = QUANTITA_ THEN
            RAISE ESAURITO;
        END IF;
    END IF;

EXCEPTION
    WHEN ESAURITO THEN
    RAISE_APPLICATION_ERROR(-20002,'Attenzione, il prodotto è esaurito!');

END;

--TEST:

--INSERT INTO INVENTARIO (SKU, DESCRIZIONE_INV, POSIZIONE, UNITA, QUANTITA_INV) VALUES ('PIPPO5', 'SCARPE', 'REPARTO P FILA P', 'SCATOLA P', 0);

