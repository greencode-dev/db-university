--1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT students.registration_number, students.name, students.surname, degrees.name
FROM university.students
JOIN degrees ON students.degree_id = degree_id
WHERE degrees.id = 53

--2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT degrees.name, degrees.level, departments.name
FROM university.degrees
JOIN departments ON department_id = departments.id
WHERE department_id =  7

--3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT courses.id AS "id courses", courses.name AS "courses name", teachers.name AS "teacher name", teachers.surname AS "teacher surname"
FROM university.courses
JOIN course_teacher ON courses.id = course_teacher.course_id
JOIN teachers ON teachers.id = course_teacher.teacher_id
WHERE teacher_id = 44
ORDER BY course_id ASC  

--4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT students.surname, students.name, students.registration_number, degrees.name, departments.name
FROM university.students
JOIN degrees ON degrees.id = students.degree_id
JOIN departments ON departments.id = degrees.department_id
ORDER BY students.surname, students.name ASC

--5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT degrees.name AS "degrees name", courses.name AS "courses name", teachers.surname AS "teachers surname", teachers.name AS "teachers name"
FROM university.courses
JOIN degrees ON degrees.id = courses.degree_id
JOIN course_teacher ON courses.id = course_teacher.course_id
JOIN teachers ON teachers.id = course_teacher.teacher_id
ORDER BY degrees.name, courses.name ASC  

--6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (5)

SELECT departments.name AS "departments name", teachers.surname AS "teachers surname", teachers.name AS "teachers name"
FROM university.teachers
JOIN course_teacher ON teachers.id = course_teacher.teacher_id
JOIN courses ON courses.id = course_teacher.course_id
JOIN degrees ON degrees.id = courses.degree_id
JOIN departments ON departments.id = degrees.department_id
WHERE departments.id = 5
ORDER BY teachers.surname, teachers.name ASC

--7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.

SELECT students.surname, students.name, courses.name AS course_name, MAX(exam_student.vote) AS max_vote
FROM university.students
JOIN exam_student ON students.id = exam_student.student_id
JOIN exams ON exam_student.exam_id = exams.id
JOIN courses ON exams.course_id = courses.id
WHERE exam_student.vote >= 18
GROUP BY students.id, exams.id
ORDER BY students.surname, students.name, courses.name ASC
