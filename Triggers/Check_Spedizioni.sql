
--all'inserimento di spedizioni, i numeri e tracking devono essere unici per evitare ambiguità
-- e le date degli ordini vanno sempre prima alle date delle consegne


-- Evento DML: INSERT INTO
-- Tabella di appoggio: SPEDIZIONE
-- Temporizzazione: BEFORE INSERT OR UPDATE


CREATE OR REPLACE TRIGGER Check_Spedizioni
BEFORE INSERT OR UPDATE ON SPEDIZIONE
FOR EACH ROW

DECLARE 
	ERRORE_DATE EXCEPTION;
	SPED_ORD_DATE NUMBER := 0;
	
	CONT NUMBER;
	ERROR_OVERLAP EXCEPTION;

BEGIN
	--Codice che gestisce l'inserimento
	IF INSERTING THEN
	
		--codice per gestire le date degli ordini e delle consegne
		SELECT COUNT(*) INTO SPED_ORD_DATE FROM ORDINE JOIN SPEDIZIONE ON (SPEDIZIONE.NUM_ORDINE = ORDINE.NUM_ORDINE) WHERE TRUNC(:NEW.DATA_CONSEGNA) < DATA_ORDINE;
		
		IF SPED_ORD_DATE > 0 THEN
		RAISE ERRORE_DATE;
		END IF;
		
		--codice per gestire num ordini e tracking
		SELECT COUNT(*) INTO CONT 
		FROM SPEDIZIONE
		WHERE SPEDIZIONE.NUM_ORDINE = :NEW.NUM_ORDINE
			OR SPEDIZIONE.TRACKING_ = :NEW.TRACKING_;

		IF CONT <> 0 THEN
			RAISE ERROR_OVERLAP;
		END IF;
END IF;

EXCEPTION
	WHEN ERRORE_DATE THEN 
		RAISE_APPLICATION_ERROR(-20004,'Attenzione, date ordini-spedizioni incoerent!');
		
	WHEN ERROR_OVERLAP THEN
		RAISE_APPLICATION_ERROR(-20005, 'Attenzione, numeri e tracking delle spedizioni devono essere unici tra loro!');
END;

--TEST: LANCIANDO LO SCRIPT DML CON DATI MODIFICATI, IL TRIGGER SI ATTIVA CON SUCCESSO GESTENDO ENTRAMBI I VINCOLI
