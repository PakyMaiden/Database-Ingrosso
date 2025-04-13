--all'inserimento di fornitori i nomi delle società devono essere unici tra loro

-- Evento DML: INSERT INTO
-- Tabella di appoggio: FORNITORE
-- Temporizzazione: BEFORE INSERT 

CREATE OR REPLACE TRIGGER Check_Fornitore
BEFORE INSERT  ON FORNITORE
FOR EACH ROW

DECLARE
	COUNT_FORNITORE  NUMBER :=0;
	ERR              EXCEPTION;
	
BEGIN
	--codice che gestisce l'inserimento
		SELECT COUNT(*) INTO COUNT_FORNITORE 
        FROM FORNITORE 
        WHERE NOME_SOCIETA = :NEW.NOME_SOCIETA;

		--se tale numero è maggiore di 0, attiva l'eccezione
		IF COUNT_FORNITORE > 0 THEN
			RAISE ERR;
		END IF;


EXCEPTION
	WHEN ERR THEN
		RAISE_APPLICATION_ERROR (-20006, 'Attenzione, i nomi di fornitori devono essere diversi!');
END;

--TEST:

--LANCIARE SCRIPT DML
--INSERT INTO FORNITORE (P_IVA_FORNITORE, NOME_SOCIETA, VIA_F, CITTA_F, CAP_F , NR_CIVICO_F) VALUES ('32310711032', 'SKALITH', 'BUTTERFIELD DRIVE', 'PALHOÇA', '42742', '105');
