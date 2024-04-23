
----------------------------------- Query 1: Età------------------------------------------
use banca ;
CREATE TEMPORARY TABLE eta AS 
SELECT
    cliente.id_cliente,
    cliente.nome,
    cliente.cognome,
    YEAR(CURRENT_DATE) - YEAR(cliente.data_nascita) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(cliente.data_nascita, '%m%d')) AS eta
FROM
    banca.cliente;

Select* from eta;
----------------------------------------------- Query 2:transazioni_uscita------------------------------------------
CREATE TEMPORARY TABLE  transazioni_uscita AS
SELECT
    cliente.id_cliente,
    COUNT(CASE WHEN transazioni.id_tipo_trans >= '3' THEN transazioni.id_conto END) AS transazioni_uscita
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    banca.transazioni ON conto.id_conto = transazioni.id_conto
GROUP BY
    cliente.id_cliente;

select *
from transazioni_uscita;

----------------------------------------------- Query 3:transazioni_entrata------------------------------------------
CREATE TEMPORARY TABLE  transazioni_entrata AS
SELECT
    cliente.id_cliente,
    COUNT(CASE WHEN transazioni.id_tipo_trans <= '2' THEN transazioni.id_conto END) AS transazioni_entrata
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    banca.transazioni ON conto.id_conto = transazioni.id_conto
GROUP BY
    cliente.id_cliente;
    
    
    select *
from transazioni_entrata;

----------------------------------------------- Query 4:Importo_uscita------------------------------------------

CREATE TEMPORARY TABLE  Importo_uscita AS

SELECT
    cliente.id_cliente,
    SUM(CASE WHEN transazioni.id_tipo_trans >= '3' THEN transazioni.importo ELSE 0 END) AS importo_uscita
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    banca.transazioni ON conto.id_conto = transazioni.id_conto
GROUP BY
    cliente.id_cliente;

select *
from Importo_uscita;
----------------------------------------------- Query 5:Importo_entrata------------------------------------------

CREATE TEMPORARY TABLE  Importo_entrata AS

SELECT
    cliente.id_cliente,
    SUM(CASE WHEN transazioni.id_tipo_trans <= '2' THEN transazioni.importo ELSE 0 END) AS importo_entrata
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    banca.transazioni ON conto.id_conto = transazioni.id_conto
GROUP BY
    cliente.id_cliente;

select *
from Importo_entrata;

----------------------------------------------- Query 6:Totale_conti------------------------------------------
CREATE TEMPORARY TABLE  Totale_conti AS

SELECT
    cliente.id_cliente,
    COUNT(DISTINCT conto.id_conto) AS numero_totale_conti_posseduti
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
GROUP BY
    cliente.id_cliente;


select *
from Totale_conti;

----------------------------------------------- Query 7:Numero_conti_tipologia------------------------------------------
CREATE TEMPORARY TABLE  Numero_conti_tipologia AS

SELECT
    cliente.id_cliente,
    COUNT(DISTINCT CASE WHEN conto.id_tipo_conto = '0' THEN conto.id_conto END) AS conto_base,
    COUNT(DISTINCT CASE WHEN conto.id_tipo_conto = '1' THEN conto.id_conto END) AS conto_business,
    COUNT(DISTINCT CASE WHEN conto.id_tipo_conto = '2' THEN conto.id_conto END) AS conto_privati,
    COUNT(DISTINCT CASE WHEN conto.id_tipo_conto = '3' THEN conto.id_conto END) AS conto_famiglie
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
GROUP BY
    cliente.id_cliente;


select *
from Numero_conti_tipologia;
----------------------------------------------- Query 8:transazioni_uscita_tipologia_conto------------------------------------------
CREATE TEMPORARY TABLE  transazioni_uscita_tipologia_conto AS
SELECT
    cliente.id_cliente,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '3' THEN transazioni.id_conto END) AS transazioni_Acquisti_Amazon,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '4' THEN transazioni.id_conto END) AS transazioni_Rata_Mutuo,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '5' THEN transazioni.id_conto END) AS transazioni_Hotel,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '6' THEN transazioni.id_conto END) AS transazioni_Biglietto_Aereo,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '7' THEN transazioni.id_conto END) AS transazioni_Supermercato
   
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    banca.transazioni ON conto.id_conto = transazioni.id_conto
GROUP BY
    cliente.id_cliente;



select *
from  transazioni_uscita_tipologia_conto;
----------------------------------------------- Query 9:transazioni_entrata_tipologia_conto------------------------------------------

CREATE TEMPORARY TABLE  transazioni_entrata_tipologia_conto AS
SELECT
    cliente.id_cliente,
COUNT(CASE WHEN transazioni.id_tipo_trans = '0' THEN transazioni.id_conto END) AS transazioni_Stipendio,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '1' THEN transazioni.id_conto END) AS transazioni_Pensione,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '2' THEN transazioni.id_conto END) AS transazioni_Dividendi
   
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    banca.transazioni ON conto.id_conto = transazioni.id_conto
GROUP BY
    cliente.id_cliente;



select *
from  transazioni_entrata_tipologia_conto;

----------------------------------------------- Query 10:importo_uscita_tipologia_conto------------------------------------------

CREATE TEMPORARY TABLE  importo_uscita_tipologia_conto AS
SELECT
    cliente.id_cliente,
    SUM(CASE WHEN transazioni.id_tipo_trans = '3' THEN transazioni.importo ELSE 0 END) AS Importi_uscita_Amazon,
    SUM(CASE WHEN transazioni.id_tipo_trans = '4' THEN transazioni.importo ELSE 0 END) AS Importi_uscita_Mutuo,
    SUM(CASE WHEN transazioni.id_tipo_trans = '5' THEN transazioni.importo ELSE 0 END) AS Importi_uscita_Hotel,
    SUM(CASE WHEN transazioni.id_tipo_trans = '6' THEN transazioni.importo ELSE 0 END) AS Importi_uscita_Biglietto_Aereo,
    SUM(CASE WHEN transazioni.id_tipo_trans = '7' THEN transazioni.importo ELSE 0 END) AS Importi_uscita_Supermercato
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    banca.transazioni ON conto.id_conto = transazioni.id_conto
GROUP BY
    cliente.id_cliente;



select *
from importo_uscita_tipologia_conto;

----------------------------------------------- Query 11:Importo_entrata_tipologia_di_conto------------------------------------------

CREATE TEMPORARY TABLE  Importo_entrata_tipologia_di_conto AS
SELECT
    cliente.id_cliente,
    SUM(CASE WHEN transazioni.id_tipo_trans = '0' THEN transazioni.importo ELSE 0 END) AS Importi_Entrata_Stipendio,
    SUM(CASE WHEN transazioni.id_tipo_trans = '1' THEN transazioni.importo ELSE 0 END) AS Importi_Entrata_Pensioni,
    SUM(CASE WHEN transazioni.id_tipo_trans = '2' THEN transazioni.importo ELSE 0 END) AS Importi_Entrata_Dividendi
FROM
    banca.cliente
LEFT JOIN
    banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    banca.transazioni ON conto.id_conto = transazioni.id_conto
GROUP BY
    cliente.id_cliente;




select *
from Importo_entrata_tipologia_di_conto;

----------------------------------------------- Tabella------------------------------------------

SELECT
    cliente.id_cliente,
    cliente.nome,
    cliente.cognome,
    YEAR(CURRENT_DATE) - YEAR(cliente.data_nascita) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(cliente.data_nascita, '%m%d')) AS eta,
    COUNT(DISTINCT conto.id_conto) AS numero_totale_conti_posseduti,
    COUNT(DISTINCT CASE WHEN conto.id_tipo_conto = '0' THEN conto.id_conto END) AS conto_base,
    COUNT(DISTINCT CASE WHEN conto.id_tipo_conto = '1' THEN conto.id_conto END) AS conto_business,
    COUNT(DISTINCT CASE WHEN conto.id_tipo_conto = '2' THEN conto.id_conto END) AS conto_privati,
    COUNT(DISTINCT CASE WHEN conto.id_tipo_conto = '3' THEN conto.id_conto END) AS conto_famiglie,
    COUNT(CASE WHEN transazioni.id_tipo_trans >= '3' THEN conto.id_cliente END) AS transazioni_uscita,
    COUNT( CASE WHEN transazioni.id_tipo_trans <= '2' THEN conto.id_cliente END) AS transazioni_entrata,
    SUM(CASE WHEN importo < 0 THEN importo ELSE 0 END) AS somma_importi_negativi,
    SUM(CASE WHEN importo > 0 THEN importo ELSE 0 END) AS somma_importi_positivi,
	COUNT(CASE WHEN transazioni.id_tipo_trans = '3' THEN transazioni.id_conto END) AS transazioni_Acquisti_Amazon,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '4' THEN transazioni.id_conto END) AS transazioni_Rata_Mutuo,
	COUNT(CASE WHEN transazioni.id_tipo_trans = '5' THEN transazioni.id_conto END) AS transazioni_Hotel,
	COUNT(CASE WHEN transazioni.id_tipo_trans = '6' THEN transazioni.id_conto END) AS transazioni_Biglietto_Aereo,
    COUNT(CASE WHEN transazioni.id_tipo_trans = '7' THEN transazioni.id_conto END) AS transazioni_Supermercato,
	COUNT(CASE WHEN transazioni.id_tipo_trans = '0' THEN transazioni.id_conto END) AS transazioni_Stipendio,
	COUNT(CASE WHEN transazioni.id_tipo_trans = '1' THEN transazioni.id_conto END) AS transazioni_Pensione,
	COUNT(CASE WHEN transazioni.id_tipo_trans = '2' THEN transazioni.id_conto END) AS transazioni_Dividendi,
	SUM(CASE WHEN transazioni.id_tipo_trans = '3' THEN transazioni.importo ELSE 0 END) AS Importi_Uscita_Amazon,
    SUM(CASE WHEN transazioni.id_tipo_trans = '4' THEN transazioni.importo ELSE 0 END) AS Importi_Uscita_Mutuo,
    SUM(CASE WHEN transazioni.id_tipo_trans = '5' THEN transazioni.importo ELSE 0 END) AS Importi_Uscita_Hotel,
    SUM(CASE WHEN transazioni.id_tipo_trans = '6' THEN transazioni.importo ELSE 0 END) AS Importi_Uscita_Biglietto_Aereo,
    SUM(CASE WHEN transazioni.id_tipo_trans = '7' THEN transazioni.importo ELSE 0 END) AS Importi_Entrata_Supermercato,
    SUM(CASE WHEN transazioni.id_tipo_trans = '0' THEN transazioni.importo ELSE 0 END) AS Importi_Entrata_Stipendio,
    SUM(CASE WHEN transazioni.id_tipo_trans = '1' THEN transazioni.importo ELSE 0 END) AS Importi_Entrata_Pensioni,
    SUM(CASE WHEN transazioni.id_tipo_trans = '2' THEN transazioni.importo ELSE 0 END) AS Importi_Entrata_Dividendi
    
      
FROM
   banca.cliente

LEFT JOIN
   
   banca.conto ON cliente.id_cliente = conto.id_cliente
LEFT JOIN
    
    banca.transazioni ON conto.id_conto = transazioni.id_conto
    


GROUP BY
    1, 2, 3, 4;



select *
from report_cliente;
----------------------------------------------- Tabella seconda versione ------------------------------------------
SELECT
    eta.id_cliente,
    eta.nome,
    eta.cognome,
    eta.eta,
    transazioni_uscita.transazioni_uscita,
    transazioni_entrata.transazioni_entrata,
    Importo_uscita.importo_uscita,
    Importo_entrata.importo_entrata,
    Totale_conti.numero_totale_conti_posseduti,
    Numero_conti_tipologia.conto_base,
    Numero_conti_tipologia.conto_business,
    Numero_conti_tipologia.conto_privati,
    Numero_conti_tipologia.conto_famiglie,
    transazioni_uscita_tipologia_conto.transazioni_Acquisti_Amazon,
    transazioni_uscita_tipologia_conto.transazioni_Rata_Mutuo,
    transazioni_uscita_tipologia_conto.transazioni_Hotel,
    transazioni_uscita_tipologia_conto.transazioni_Biglietto_Aereo,
    transazioni_uscita_tipologia_conto.transazioni_Supermercato,
    transazioni_entrata_tipologia_conto.transazioni_Stipendio,
    transazioni_entrata_tipologia_conto.transazioni_Pensione,
    transazioni_entrata_tipologia_conto.transazioni_Dividendi,
    importo_uscita_tipologia_conto.Importi_uscita_Amazon,
    importo_uscita_tipologia_conto.Importi_uscita_Mutuo,
    importo_uscita_tipologia_conto.Importi_uscita_Hotel,
    importo_uscita_tipologia_conto.Importi_uscita_Biglietto_Aereo,
    importo_uscita_tipologia_conto.Importi_uscita_Supermercato,
    Importo_entrata_tipologia_di_conto.Importi_Entrata_Stipendio,
    Importo_entrata_tipologia_di_conto.Importi_Entrata_Pensioni,
    Importo_entrata_tipologia_di_conto.Importi_Entrata_Dividendi
FROM
    eta
JOIN transazioni_uscita ON eta.id_cliente = transazioni_uscita.id_cliente
JOIN transazioni_entrata ON eta.id_cliente = transazioni_entrata.id_cliente
JOIN Importo_uscita ON eta.id_cliente = Importo_uscita.id_cliente
JOIN Importo_entrata ON eta.id_cliente = Importo_entrata.id_cliente
JOIN Totale_conti ON eta.id_cliente = Totale_conti.id_cliente
JOIN Numero_conti_tipologia ON eta.id_cliente = Numero_conti_tipologia.id_cliente
JOIN transazioni_uscita_tipologia_conto ON eta.id_cliente = transazioni_uscita_tipologia_conto.id_cliente
JOIN transazioni_entrata_tipologia_conto ON eta.id_cliente = transazioni_entrata_tipologia_conto.id_cliente
JOIN importo_uscita_tipologia_conto ON eta.id_cliente = importo_uscita_tipologia_conto.id_cliente
JOIN Importo_entrata_tipologia_di_conto ON eta.id_cliente = Importo_entrata_tipologia_di_conto.id_cliente;



