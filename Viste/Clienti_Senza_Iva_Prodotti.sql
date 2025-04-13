
--Clienti senza Partita Iva visualizzano i prodotti
                        
CREATE VIEW Clienti_Senza_Iva_Prodotti AS
(
SELECT CL.ID_CLIENTE, PERS.NOME_PERSONA, PROD.MARCA, PROD.TIPO, PROD.MODELLO
FROM ((CLIENTE CL JOIN PRODOTTO PROD ON CL.ID_CLIENTE = PROD.ID_CLIENTE)
                  JOIN PERSONA PERS ON CL.ID_CLIENTE = PERS.ID_CLIENTE)
);

--SELECT * FROM CLIENTI_NO_IVA_PRODOTTI
