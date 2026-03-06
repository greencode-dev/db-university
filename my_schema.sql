-- -----------------------------------------------------
-- Schema per Database Università
-- -----------------------------------------------------

-- 1. Tabella Dipartimenti
CREATE TABLE `departments`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

-- 2. Tabella Corsi di Laurea
CREATE TABLE `degrees`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `department_id` INT UNSIGNED NOT NULL COMMENT 'FK',
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(100) NOT NULL
);

-- 3. Tabella Studenti
CREATE TABLE `students`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `degree_id` INT UNSIGNED NOT NULL COMMENT 'FK',
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `registration_number` VARCHAR(20) NOT NULL
);

-- 4. Tabella Insegnanti
CREATE TABLE `teachers`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `phone` VARCHAR(15) NOT NULL
);

-- 5. Tabella Corsi (Materie)
CREATE TABLE `courses`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `degree_id` INT UNSIGNED NOT NULL COMMENT 'FK',
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL
);

-- 6. Tabella Appelli d'Esame
CREATE TABLE `exams`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `course_id` INT UNSIGNED NOT NULL COMMENT 'FK',
    `date` DATE NOT NULL,
    `location` VARCHAR(255) NOT NULL
);

-- 7. Tabella Ponte: Corso <-> Insegnante (Relazione N:N)
CREATE TABLE `course_teacher`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `course_id` INT UNSIGNED NOT NULL COMMENT 'FK',
    `teacher_id` INT UNSIGNED NOT NULL COMMENT 'FK'
);

-- 8. Tabella Ponte: Studente <-> Esame (Relazione N:N con Voto)
CREATE TABLE `exam_student`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `student_id` INT UNSIGNED NOT NULL COMMENT 'FK',
    `exam_id` INT UNSIGNED NOT NULL COMMENT 'FK',
    `vote` TINYINT UNSIGNED NOT NULL
);

-- -----------------------------------------------------
-- INDICI E VINCOLI DI UNICITÀ
-- -----------------------------------------------------

-- Indice per velocizzare la ricerca degli studenti per cognome
ALTER TABLE `students` ADD INDEX `students_last_name_index`(`last_name`);

-- Vincolo di unicità per la matricola dello studente
ALTER TABLE `students` ADD UNIQUE `students_registration_number_unique`(`registration_number`);

-- -----------------------------------------------------
-- VINCOLI DI INTEGRITÀ (CHECK)
-- -----------------------------------------------------

-- Controllo del range del voto (0-31, dove 31 è 30 e lode)
ALTER TABLE `exam_student` 
ADD CONSTRAINT `exam_student_vote_check` 
CHECK (`vote` >= 0 AND `vote` <= 31);

-- -----------------------------------------------------
-- RELAZIONI (FOREIGN KEYS)
-- -----------------------------------------------------

-- Relazioni tabella Studenti e Corsi verso i Corsi di Laurea
ALTER TABLE `students` ADD CONSTRAINT `students_degree_id_foreign` FOREIGN KEY(`degree_id`) REFERENCES `degrees`(`id`);
ALTER TABLE `courses` ADD CONSTRAINT `courses_degree_id_foreign` FOREIGN KEY(`degree_id`) REFERENCES `degrees`(`id`);

-- Relazione Corsi di Laurea verso Dipartimenti
ALTER TABLE `degrees` ADD CONSTRAINT `degrees_department_id_foreign` FOREIGN KEY(`department_id`) REFERENCES `departments`(`id`);

-- Relazione Appelli verso Corsi
ALTER TABLE `exams` ADD CONSTRAINT `exams_course_id_foreign` FOREIGN KEY(`course_id`) REFERENCES `courses`(`id`);

-- Relazioni Tabella Ponte Insegnanti
ALTER TABLE `course_teacher` ADD CONSTRAINT `course_teacher_course_id_foreign` FOREIGN KEY(`course_id`) REFERENCES `courses`(`id`);
ALTER TABLE `course_teacher` ADD CONSTRAINT `course_teacher_teacher_id_foreign` FOREIGN KEY(`teacher_id`) REFERENCES `teachers`(`id`);

-- Relazioni Tabella Ponte Esami/Voti
ALTER TABLE `exam_student` ADD CONSTRAINT `exam_student_exam_id_foreign` FOREIGN KEY(`exam_id`) REFERENCES `exams`(`id`);
ALTER TABLE `exam_student` ADD CONSTRAINT `exam_student_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `students`(`id`);