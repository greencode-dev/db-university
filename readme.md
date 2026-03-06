# DB University - Modellizzazione Database

Questo progetto consiste nella progettazione e modellizzazione della struttura di un database per un sistema universitario. L'obiettivo è gestire le relazioni tra dipartimenti, corsi di laurea, corsi (materie), docenti, studenti e appelli d'esame.

## 📌 Requisiti del Progetto

Il database è stato progettato per soddisfare i seguenti requisiti:

- Ogni **Dipartimento** offre più **Corsi di Laurea**.
- Ogni Corso di Laurea offre diversi **Corsi** (materie).
- Ogni Corso può essere tenuto da più **Insegnanti** (e viceversa).
- Ogni **Studente** è iscritto a un solo Corso di Laurea.
- Ogni Corso prevede diversi **Appelli d'Esame**.
- Uno Studente può iscriversi a più appelli e per ognuno viene memorizzato il **voto** ottenuto.

## 🛠️ Struttura del Database

### Entità Principali

- **Departments**: Contiene l'anagrafica dei dipartimenti (es. Matematica, Lettere).
- **Degrees**: I corsi di laurea offerti dai dipartimenti.
- **Students**: Gli studenti iscritti, con vincolo di unicità sulla matricola.
- **Teachers**: I docenti dell'ateneo.
- **Courses**: Le singole materie d'esame.
- **Exams**: Le sessioni/appelli d'esame per ogni corso.

### Relazioni e Tabelle Ponte

- **course_teacher**: Tabella pivot per gestire la relazione _Molti-a-Molti_ tra Corsi e Insegnanti.
- **exam_student**: Tabella pivot per gestire la relazione _Molti-a-Molti_ tra Studenti ed Esami. Include la colonna `vote` per registrare il risultato.

## 🚀 Caratteristiche Tecniche

- **Integrità dei Dati**: Utilizzo di chiavi esterne (Foreign Keys) per garantire la coerenza tra le tabelle.
- **Validazione**: Implementazione di un vincolo `CHECK` sulla colonna `vote` per limitare i valori nel range 0-31 (dove 31 rappresenta il 30 e lode).
- **Ottimizzazione**: Aggiunta di un indice sulla colonna `last_name` della tabella `students` per velocizzare le ricerche anagrafiche.
- **Unicità**: La colonna `registration_number` degli studenti è impostata come `UNIQUE`.

## 📂 Contenuto della Repository

- `my_schema.sql`: Il codice SQL completo per la creazione delle tabelle e dei vincoli.
- `diagramma.jpg`: L'esportazione visiva dello schema realizzata con DrawSQL.
