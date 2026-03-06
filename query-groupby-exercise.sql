--1. Contare quanti iscritti ci sono stati ogni anno

SELECT YEAR(enrolment_date) AS "Anno", COUNT(*) AS "Numero Iscritti"
FROM university.students
GROUP BY YEAR(enrolment_date);

--2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT office_address AS "Indirizzo", COUNT(*) AS "Numero Insegnanti"
FROM university.teachers
GROUP BY office_address

--3. Calcolare la media dei voti di ogni appello d'esame

SELECT exam_id AS "Appello d'Esame", AVG(vote) AS "Media Voti"
FROM university.exam_student
GROUP BY exam_id;

--4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT degree_id AS "Dipartimento", COUNT(*) AS "Numero Corsi di Laurea"
FROM university.courses
GROUP BY degree_id
