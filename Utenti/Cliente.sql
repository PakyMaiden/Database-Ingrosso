-- Cliente

GRANT CONNECT, CREATE SESSION              TO Cliente;
GRANT EXECUTE ON Cancella_Carte_Scadute    TO Cliente; -- procedura
GRANT SELECT ON Clienti_con_Iva_Prodotti   TO Cliente; -- vista
GRANT SELECT ON Clienti_Senza_Iva_Prodotti TO Cliente; -- vista
