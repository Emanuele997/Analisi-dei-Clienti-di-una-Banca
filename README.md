# Analisi-dei-Clienti-di-una-Banca


Per completare il progetto di creare una tabella denormalizzata che contenesse indicatori comportamentali dei clienti basati sulle transazioni e sui prodotti posseduti, ho utilizzato esclusivamente SQL. Ecco come ho proceduto:

1. Analisi delle Strutture delle Tabelle
Ho iniziato con l'analisi delle tabelle nel database fornito, come cliente, conto, tipo_conto, transazioni e tipo_transazione, per comprendere come fossero strutturate e come le informazioni fossero collegate.

2. Progettazione delle Query
Ho progettato diverse query SQL per aggregare i dati necessari e per calcolare gli indicatori richiesti:

Estrazione e Calcolo dell'Età dei Clienti: Ho calcolato l'età dei clienti a partire dalla loro data di nascita, utilizzando funzioni di data in SQL per ottenere la differenza tra la data corrente e la data di nascita.
Transazioni e Importi Aggregati: Per ogni cliente, ho aggregato il numero e l'importo delle transazioni in entrata e in uscita utilizzando GROUP BY su id_cliente. Ho utilizzato le funzioni di somma (SUM) e conteggio (COUNT) per ottenere il totale delle transazioni e gli importi.
Conteggio dei Conti per Cliente: Ho creato una query che contava il numero totale di conti per ogni cliente, così come il numero di conti per ogni tipologia di conto, sempre usando GROUP BY e join tra le tabelle cliente e conto.

3. Aggregazione dei Dati per Cliente

Con i dati aggregati, ho poi proceduto a creare una tabella denormalizzata dove ogni riga rappresentava un cliente e ogni colonna rappresentava uno degli indicatori richiesti:

Join Completo dei Dati: Ho usato varie istruzioni SQL JOIN per combinare tutte le informazioni raccolte nelle query precedenti in una singola vista. Questo includeva unire dati da transazioni, conti, e clienti basandosi sugli id_cliente e id_conto.
Calcolo degli Indicatori Finali: Dopo aver aggregato tutte le informazioni necessarie, ho calcolato gli indicatori finali direttamente nella query finale. Questo includeva indicatori complessi come l'importo transato in entrata per tipologia di conto e l'importo transato in uscita per tipologia di conto.

