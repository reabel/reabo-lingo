-- Initialize the database with sample data

-- Sample Languages
WITH seed_languages (name, code, flag_emoji, description, is_active) AS (
VALUES
('Spanish', 'es', '🇪🇸', 'Learn Spanish - one of the most spoken languages', true),
('French', 'fr', '🇫🇷', 'Learn French - the language of love', true),
('German', 'de', '🇩🇪', 'Learn German - a powerful business language', true),
('Japanese', 'ja', '🇯🇵', 'Learn Japanese - explore Asian culture', true),
('Italian', 'it', '🇮🇹', 'Learn Italian - the language of art and cuisine', true),
('Russian', 'ru', '🇷🇺', 'Learn Russian - a major Slavic language', true),
('Dutch', 'nl', '🇳🇱', 'Learn Dutch - the language of the Netherlands', true),
('Portuguese', 'pt', '🇵🇹', 'Learn Portuguese - spoken across four continents', true)
)
INSERT INTO languages (name, code, flag_emoji, description, is_active)
SELECT seed_languages.*
FROM seed_languages
WHERE NOT EXISTS (
  SELECT 1 FROM languages existing
  WHERE existing.code = seed_languages.code OR existing.name = seed_languages.name
);

-- Sample Lessons for Spanish
WITH seed_language AS (SELECT id FROM languages WHERE code = 'es' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'Greetings', 'Learn basic greetings in Spanish', 1, 1, 10, true),
( 'Numbers 1-10', 'Count from 1 to 10 in Spanish', 1, 2, 10, true),
( 'Food & Drinks', 'Learn common food and drink words', 1, 3, 15, true),
( 'Colors', 'Learn basic colors in Spanish', 1, 4, 10, true),
( 'Family', 'Learn family member names', 2, 5, 15, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Sample Questions for Spanish Greetings
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'es' AND lesson.title = 'Greetings'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "Hello" in Spanish?', 'multiple_choice', 'Hola', NULL, '["Hola", "Adiós", "Gracias", "Por favor"]', 1),
( 'Translate to Spanish: Goodbye', 'translate', 'Adiós', NULL, NULL, 2),
( 'How do you say "Thank you"?', 'multiple_choice', 'Gracias', NULL, '["Gracias", "De nada", "Buenos días", "Buenas noches"]', 3),
( 'What does "Buenos días" mean?', 'multiple_choice', 'Good morning', NULL, '["Good morning", "Good night", "Good afternoon", "Hello"]', 4),
( 'Translate to Spanish: Please', 'translate', 'Por favor', NULL, NULL, 5)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Sample Questions for Spanish Numbers
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'es' AND lesson.title = 'Numbers 1-10'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "1" in Spanish?', 'multiple_choice', 'Uno', NULL, '["Uno", "Dos", "Tres", "Cuatro"]', 1),
( 'Translate: Five', 'translate', 'Cinco', NULL, NULL, 2),
( 'What number is "Diez"?', 'multiple_choice', '10', NULL, '["5", "8", "10", "7"]', 3),
( 'How do you say "3"?', 'translate', 'Tres', NULL, NULL, 4)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Lessons for French
WITH seed_language AS (SELECT id FROM languages WHERE code = 'fr' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'Salutations', 'Learn basic greetings in French', 1, 1, 10, true),
( 'Nombres 1-10', 'Count from 1 to 10 in French', 1, 2, 10, true),
( 'Nourriture', 'Learn common food words', 1, 3, 15, true),
( 'Couleurs', 'Learn basic colors in French', 1, 4, 10, true),
( 'Famille', 'Learn family member names', 2, 5, 15, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Lessons for German
WITH seed_language AS (SELECT id FROM languages WHERE code = 'de' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'Grüße', 'Learn basic greetings in German', 1, 1, 10, true),
( 'Zahlen 1-10', 'Count from 1 to 10 in German', 1, 2, 10, true),
( 'Essen & Trinken', 'Learn common food and drink words', 1, 3, 15, true),
( 'Farben', 'Learn basic colors in German', 1, 4, 10, true),
( 'Familie', 'Learn family member names', 2, 5, 15, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Lessons for Japanese
WITH seed_language AS (SELECT id FROM languages WHERE code = 'ja' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'あいさつ (Greetings)', 'Learn basic greetings in Japanese', 1, 1, 10, true),
( '数字 1-10 (Numbers)', 'Count from 1 to 10 in Japanese', 1, 2, 10, true),
( '食べ物 (Food)', 'Learn common food words', 1, 3, 15, true),
( '色 (Colors)', 'Learn basic colors in Japanese', 1, 4, 10, true),
( '家族 (Family)', 'Learn family member names', 2, 5, 15, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Lessons for Italian
WITH seed_language AS (SELECT id FROM languages WHERE code = 'it' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'Saluti', 'Learn basic greetings in Italian', 1, 1, 10, true),
( 'Numeri 1-10', 'Count from 1 to 10 in Italian', 1, 2, 10, true),
( 'Cibo e Bevande', 'Learn common food and drink words', 1, 3, 15, true),
( 'Colori', 'Learn basic colors in Italian', 1, 4, 10, true),
( 'Famiglia', 'Learn family member names', 2, 5, 15, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Lessons for Russian
WITH seed_language AS (SELECT id FROM languages WHERE code = 'ru' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'Приветствия (Greetings)', 'Learn basic greetings in Russian', 1, 1, 10, true),
( 'Числа 1-10 (Numbers)', 'Count from 1 to 10 in Russian', 1, 2, 10, true),
( 'Еда и Напитки (Food)', 'Learn common food and drink words', 1, 3, 15, true),
( 'Цвета (Colors)', 'Learn basic colors in Russian', 1, 4, 10, true),
( 'Семья (Family)', 'Learn family member names', 2, 5, 15, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Lessons for Dutch
WITH seed_language AS (SELECT id FROM languages WHERE code = 'nl' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'Begroetingen (Greetings)', 'Learn basic greetings in Dutch', 1, 1, 10, true),
( 'Getallen 1-10 (Numbers)', 'Count from 1 to 10 in Dutch', 1, 2, 10, true),
( 'Eten en Drinken (Food)', 'Learn common food and drink words', 1, 3, 15, true),
( 'Kleuren (Colors)', 'Learn basic colors in Dutch', 1, 4, 10, true),
( 'Familie (Family)', 'Learn family member names', 2, 5, 15, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Questions for French Lesson 6 (Salutations)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'fr' AND lesson.title = 'Salutations'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "Hello" in French?', 'multiple_choice', 'Bonjour', NULL, '["Bonjour", "Au revoir", "Merci", "S''il vous plaît"]', 1),
( 'Translate to French: Goodbye', 'translate', 'Au revoir', NULL, NULL, 2),
( 'How do you say "Thank you"?', 'multiple_choice', 'Merci', NULL, '["Merci", "De rien", "Bonjour", "Bonsoir"]', 3),
( 'What does "Bonsoir" mean?', 'multiple_choice', 'Good evening', NULL, '["Good morning", "Good night", "Good evening", "Hello"]', 4),
( 'Translate to French: Please', 'translate', 'S''il vous plaît', NULL, NULL, 5),
( 'How do you say "You''re welcome"?', 'multiple_choice', 'De rien', NULL, '["De rien", "Merci", "Bonjour", "Bonsoir"]', 6),
( 'What does "Excusez-moi" mean?', 'multiple_choice', 'Excuse me', NULL, '["Excuse me", "Hello", "Goodbye", "Thank you"]', 7),
( 'Translate to French: Good morning', 'translate', 'Bonjour', NULL, NULL, 8),
( 'How do you say "Good night"?', 'multiple_choice', 'Bonne nuit', NULL, '["Bonne nuit", "Bonsoir", "Bonjour", "Au revoir"]', 9)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for French Lesson 7 (Nombres 1-10)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'fr' AND lesson.title = 'Nombres 1-10'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "1" in French?', 'multiple_choice', 'Un', NULL, '["Un", "Deux", "Trois", "Quatre"]', 1),
( 'Translate: Two', 'translate', 'Deux', NULL, NULL, 2),
( 'What number is "Cinq"?', 'multiple_choice', '5', NULL, '["3", "5", "7", "9"]', 3),
( 'How do you say "10" in French?', 'multiple_choice', 'Dix', NULL, '["Huit", "Neuf", "Dix", "Sept"]', 4),
( 'Translate: Three', 'translate', 'Trois', NULL, NULL, 5),
( 'What number is "Sept"?', 'multiple_choice', '7', NULL, '["6", "7", "8", "9"]', 6),
( 'How do you say "4"?', 'translate', 'Quatre', NULL, NULL, 7),
( 'What does "Six" mean?', 'multiple_choice', '6', NULL, '["4", "5", "6", "7"]', 8),
( 'Translate: Eight', 'translate', 'Huit', NULL, NULL, 9),
( 'How do you say "9" in French?', 'multiple_choice', 'Neuf', NULL, '["Sept", "Huit", "Neuf", "Dix"]', 10)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for French Lesson 8 (Nourriture)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'fr' AND lesson.title = 'Nourriture'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "bread" in French?', 'multiple_choice', 'Le pain', NULL, '["Le pain", "Le lait", "Le fromage", "La pomme"]', 1),
( 'Translate: Water', 'translate', 'L''eau', NULL, NULL, 2),
( 'What does "Le fromage" mean?', 'multiple_choice', 'Cheese', NULL, '["Bread", "Milk", "Cheese", "Apple"]', 3),
( 'How do you say "apple"?', 'multiple_choice', 'La pomme', NULL, '["La poire", "La pomme", "La banane", "L''orange"]', 4),
( 'Translate: Milk', 'translate', 'Le lait', NULL, NULL, 5),
( 'What does "Le poulet" mean?', 'multiple_choice', 'Chicken', NULL, '["Fish", "Beef", "Chicken", "Pork"]', 6),
( 'How do you say "egg" in French?', 'multiple_choice', 'L''œuf', NULL, '["Le beurre", "Le sucre", "L''œuf", "La farine"]', 7),
( 'Translate: Orange', 'translate', 'L''orange', NULL, NULL, 8),
( 'What does "Le vin" mean?', 'multiple_choice', 'Wine', NULL, '["Beer", "Wine", "Juice", "Coffee"]', 9),
( 'How do you say "coffee"?', 'translate', 'Le café', NULL, NULL, 10)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for French Lesson 9 (Couleurs)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'fr' AND lesson.title = 'Couleurs'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "red" in French?', 'multiple_choice', 'Rouge', NULL, '["Rouge", "Bleu", "Vert", "Jaune"]', 1),
( 'Translate: Blue', 'translate', 'Bleu', NULL, NULL, 2),
( 'What does "Vert" mean?', 'multiple_choice', 'Green', NULL, '["Red", "Blue", "Green", "Yellow"]', 3),
( 'How do you say "yellow"?', 'multiple_choice', 'Jaune', NULL, '["Orange", "Jaune", "Violet", "Rose"]', 4),
( 'Translate: Black', 'translate', 'Noir', NULL, NULL, 5),
( 'What does "Blanc" mean?', 'multiple_choice', 'White', NULL, '["Black", "White", "Grey", "Brown"]', 6),
( 'How do you say "orange"?', 'translate', 'Orange', NULL, NULL, 7),
( 'What does "Rose" mean?', 'multiple_choice', 'Pink', NULL, '["Purple", "Pink", "Red", "Grey"]', 8),
( 'How do you say "purple"?', 'multiple_choice', 'Violet', NULL, '["Violet", "Gris", "Marron", "Beige"]', 9),
( 'Translate: Brown', 'translate', 'Marron', NULL, NULL, 10)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for French Lesson 10 (Famille)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'fr' AND lesson.title = 'Famille'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "mother" in French?', 'multiple_choice', 'La mère', NULL, '["La mère", "Le père", "La sœur", "Le frère"]', 1),
( 'Translate: Father', 'translate', 'Le père', NULL, NULL, 2),
( 'What does "Le frère" mean?', 'multiple_choice', 'Brother', NULL, '["Sister", "Brother", "Son", "Daughter"]', 3),
( 'How do you say "sister"?', 'multiple_choice', 'La sœur', NULL, '["La mère", "La fille", "La sœur", "La tante"]', 4),
( 'Translate: Son', 'translate', 'Le fils', NULL, NULL, 5),
( 'What does "La fille" mean?', 'multiple_choice', 'Daughter', NULL, '["Mother", "Sister", "Daughter", "Aunt"]', 6),
( 'How do you say "grandfather"?', 'multiple_choice', 'Le grand-père', NULL, '["Le grand-père", "La grand-mère", "L''oncle", "La tante"]', 7),
( 'Translate: Grandmother', 'translate', 'La grand-mère', NULL, NULL, 8),
( 'What does "L''oncle" mean?', 'multiple_choice', 'Uncle', NULL, '["Aunt", "Cousin", "Uncle", "Nephew"]', 9),
( 'How do you say "cousin"?', 'translate', 'Le cousin', NULL, NULL, 10)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for Russian Lesson 26 (Приветствия)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'ru' AND lesson.title = 'Приветствия (Greetings)'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "Hello" in Russian?', 'multiple_choice', 'Здравствуйте', 'Zdravstvuyte', '["Здравствуйте", "До свидания", "Спасибо", "Пожалуйста"]', 1),
( 'Translate to Russian: Goodbye', 'translate', 'До свидания', 'Do svidaniya', NULL, 2),
( 'How do you say "Thank you"?', 'multiple_choice', 'Спасибо', 'Spasibo', '["Спасибо", "Пожалуйста", "Привет", "Пока"]', 3),
( 'What does "Привет" mean?', 'multiple_choice', 'Hi/Hello', 'Privet', '["Goodbye", "Thank you", "Hi/Hello", "Please"]', 4)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for Dutch Lesson 31 (Begroetingen)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'nl' AND lesson.title = 'Begroetingen (Greetings)'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "Hello" in Dutch?', 'multiple_choice', 'Hallo', NULL, '["Hallo", "Dag", "Dank je", "Alsjeblieft"]', 1),
( 'Translate to Dutch: Goodbye', 'translate', 'Tot ziens', NULL, NULL, 2),
( 'How do you say "Thank you"?', 'multiple_choice', 'Dank je', NULL, '["Dank je", "Alsjeblieft", "Goedemorgen", "Goedendag"]', 3),
( 'What does "Goedendag" mean?', 'multiple_choice', 'Good day', NULL, '["Good morning", "Good night", "Good day", "Hello"]', 4)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for Japanese Lesson 16 (あいさつ - Greetings)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'ja' AND lesson.title = 'あいさつ (Greetings)'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "Hello" in Japanese?', 'multiple_choice', 'こんにちは', 'Konnichiwa', '["こんにちは", "さようなら", "ありがとう", "おねがいします"]', 1),
( 'Translate to Japanese: Thank you', 'translate', 'ありがとう', 'Arigatou', NULL, 2),
( 'How do you say "Good morning"?', 'multiple_choice', 'おはよう', 'Ohayou', '["おはよう", "こんばんは", "さようなら", "こんにちは"]', 3),
( 'What does "さようなら" mean?', 'multiple_choice', 'Goodbye', 'Sayounara', '["Hello", "Thank you", "Goodbye", "Please"]', 4),
( 'Translate to Japanese: Please', 'translate', 'おねがいします', 'Onegaishimasu', NULL, 5)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for Japanese Lesson 17 (数字 - Numbers)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'ja' AND lesson.title = '数字 1-10 (Numbers)'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "1" in Japanese?', 'multiple_choice', 'いち', 'Ichi', '["いち", "に", "さん", "よん"]', 1),
( 'Translate: Five', 'translate', 'ご', 'Go', NULL, 2),
( 'What number is "じゅう"?', 'multiple_choice', '10', 'Juu', '["5", "8", "10", "7"]', 3),
( 'How do you say "3"?', 'translate', 'さん', 'San', NULL, 4)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Additional Russian Questions for Lesson 27 (Числа - Numbers)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'ru' AND lesson.title = 'Числа 1-10 (Numbers)'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "1" in Russian?', 'multiple_choice', 'один', 'Odin', '["один", "два", "три", "четыре"]', 1),
( 'Translate: Five', 'translate', 'пять', 'Pyat', NULL, 2),
( 'What number is "десять"?', 'multiple_choice', '10', 'Desyat', '["5", "8", "10", "7"]', 3),
( 'How do you say "3"?', 'translate', 'три', 'Tri', NULL, 4)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Lessons for Portuguese
WITH seed_language AS (SELECT id FROM languages WHERE code = 'pt' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'Saudações', 'Learn basic greetings in Portuguese', 1, 1, 10, true),
( 'Números 1-10', 'Count from 1 to 10 in Portuguese', 1, 2, 10, true),
( 'Comida e Bebida', 'Learn common food and drink words', 1, 3, 15, true),
( 'Cores', 'Learn basic colors in Portuguese', 1, 4, 10, true),
( 'Família', 'Learn family member names', 2, 5, 15, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Questions for Portuguese Lesson 36 (Saudações)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'pt' AND lesson.title = 'Saudações'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "Hello" in Portuguese?', 'multiple_choice', 'Olá', NULL, '["Olá", "Tchau", "Obrigado", "Por favor"]', 1),
( 'Translate to Portuguese: Goodbye', 'translate', 'Tchau', NULL, NULL, 2),
( 'How do you say "Thank you"?', 'multiple_choice', 'Obrigado', NULL, '["Obrigado", "De nada", "Bom dia", "Boa noite"]', 3),
( 'What does "Bom dia" mean?', 'multiple_choice', 'Good morning', NULL, '["Good morning", "Good night", "Good afternoon", "Hello"]', 4),
( 'Translate to Portuguese: Please', 'translate', 'Por favor', NULL, NULL, 5),
( 'How do you say "You''re welcome"?', 'multiple_choice', 'De nada', NULL, '["De nada", "Obrigado", "Desculpe", "Olá"]', 6),
( 'What does "Boa tarde" mean?', 'multiple_choice', 'Good afternoon', NULL, '["Good morning", "Good afternoon", "Good evening", "Hello"]', 7),
( 'Translate to Portuguese: Good night', 'translate', 'Boa noite', NULL, NULL, 8)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for Portuguese Lesson 37 (Números 1-10)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'pt' AND lesson.title = 'Números 1-10'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "1" in Portuguese?', 'multiple_choice', 'Um', NULL, '["Um", "Dois", "Três", "Quatro"]', 1),
( 'Translate: Two', 'translate', 'Dois', NULL, NULL, 2),
( 'What number is "Cinco"?', 'multiple_choice', '5', NULL, '["3", "5", "7", "9"]', 3),
( 'How do you say "10" in Portuguese?', 'multiple_choice', 'Dez', NULL, '["Oito", "Nove", "Dez", "Sete"]', 4),
( 'Translate: Three', 'translate', 'Três', NULL, NULL, 5),
( 'What number is "Sete"?', 'multiple_choice', '7', NULL, '["6", "7", "8", "9"]', 6),
( 'How do you say "4"?', 'translate', 'Quatro', NULL, NULL, 7),
( 'What does "Seis" mean?', 'multiple_choice', '6', NULL, '["4", "5", "6", "7"]', 8),
( 'Translate: Eight', 'translate', 'Oito', NULL, NULL, 9),
( 'How do you say "9" in Portuguese?', 'multiple_choice', 'Nove', NULL, '["Sete", "Oito", "Nove", "Dez"]', 10)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for Portuguese Lesson 38 (Comida e Bebida)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'pt' AND lesson.title = 'Comida e Bebida'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "bread" in Portuguese?', 'multiple_choice', 'O pão', NULL, '["O pão", "O leite", "O queijo", "A maçã"]', 1),
( 'Translate: Water', 'translate', 'A água', NULL, NULL, 2),
( 'What does "O queijo" mean?', 'multiple_choice', 'Cheese', NULL, '["Bread", "Milk", "Cheese", "Apple"]', 3),
( 'How do you say "apple"?', 'multiple_choice', 'A maçã', NULL, '["A pera", "A maçã", "A banana", "A laranja"]', 4),
( 'Translate: Milk', 'translate', 'O leite', NULL, NULL, 5),
( 'What does "O frango" mean?', 'multiple_choice', 'Chicken', NULL, '["Fish", "Beef", "Chicken", "Pork"]', 6),
( 'How do you say "coffee"?', 'multiple_choice', 'O café', NULL, '["O chá", "O suco", "O café", "A cerveja"]', 7),
( 'Translate: Orange', 'translate', 'A laranja', NULL, NULL, 8)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for Portuguese Lesson 39 (Cores)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'pt' AND lesson.title = 'Cores'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "red" in Portuguese?', 'multiple_choice', 'Vermelho', NULL, '["Vermelho", "Azul", "Verde", "Amarelo"]', 1),
( 'Translate: Blue', 'translate', 'Azul', NULL, NULL, 2),
( 'What does "Verde" mean?', 'multiple_choice', 'Green', NULL, '["Red", "Blue", "Green", "Yellow"]', 3),
( 'How do you say "yellow"?', 'multiple_choice', 'Amarelo', NULL, '["Laranja", "Amarelo", "Roxo", "Rosa"]', 4),
( 'Translate: Black', 'translate', 'Preto', NULL, NULL, 5),
( 'What does "Branco" mean?', 'multiple_choice', 'White', NULL, '["Black", "White", "Grey", "Brown"]', 6),
( 'How do you say "orange"?', 'translate', 'Laranja', NULL, NULL, 7),
( 'What does "Rosa" mean?', 'multiple_choice', 'Pink', NULL, '["Purple", "Pink", "Red", "Grey"]', 8)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for Portuguese Lesson 40 (Família)
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'pt' AND lesson.title = 'Família'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you say "mother" in Portuguese?', 'multiple_choice', 'A mãe', NULL, '["A mãe", "O pai", "A irmã", "O irmão"]', 1),
( 'Translate: Father', 'translate', 'O pai', NULL, NULL, 2),
( 'What does "O irmão" mean?', 'multiple_choice', 'Brother', NULL, '["Sister", "Brother", "Son", "Daughter"]', 3),
( 'How do you say "sister"?', 'multiple_choice', 'A irmã', NULL, '["A mãe", "A filha", "A irmã", "A tia"]', 4),
( 'Translate: Son', 'translate', 'O filho', NULL, NULL, 5),
( 'What does "A filha" mean?', 'multiple_choice', 'Daughter', NULL, '["Mother", "Sister", "Daughter", "Aunt"]', 6),
( 'How do you say "grandfather"?', 'multiple_choice', 'O avô', NULL, '["O avô", "A avó", "O tio", "A tia"]', 7),
( 'Translate: Grandmother', 'translate', 'A avó', NULL, NULL, 8),
( 'What does "O tio" mean?', 'multiple_choice', 'Uncle', NULL, '["Aunt", "Cousin", "Uncle", "Nephew"]', 9),
( 'How do you say "cousin"?', 'translate', 'O primo', NULL, NULL, 10)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Expanded French Lessons
WITH seed_language AS (SELECT id FROM languages WHERE code = 'fr' ORDER BY id LIMIT 1),
     seed_lessons (title, description, level, order_index, xp_reward, is_active) AS (
VALUES
( 'Voyage & Café', 'Order food and navigate French travel moments', 2, 6, 20, true),
( 'Verbes Quotidiens', 'Use practical everyday French action verbs', 2, 7, 20, true)
)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active)
SELECT seed_language.id, seed_lessons.*
FROM seed_language CROSS JOIN seed_lessons
WHERE NOT EXISTS (
  SELECT 1 FROM lessons existing
  WHERE existing.language_id = seed_language.id AND existing.title = seed_lessons.title
);

-- Questions for French Lesson "Voyage & Café"
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'fr' AND lesson.title = 'Voyage & Café'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'How do you ask: "Where is the train station?"', 'translate', 'Ou est la gare?', 'oo eh lah gahr', NULL, 1),
( 'Translate: I would like a coffee', 'translate', 'Je voudrais un cafe', 'zhuh voo-dreh uhn kah-fey', NULL, 2),
( 'What does "L''addition, s''il vous plait" mean?', 'multiple_choice', 'The bill, please', 'lah-dee-syon seel voo pleh', '["The menu, please", "The bill, please", "A table for two", "A coffee to go"]', 3),
( 'How do you say "ticket" in French?', 'multiple_choice', 'Le billet', 'luh bee-yeh', '["Le billet", "Le bagage", "Le passeport", "Le voyage"]', 4),
( 'Translate: A table for two, please', 'translate', 'Une table pour deux, s''il vous plait', 'ewn tah-bluh poor duh seel voo pleh', NULL, 5),
( 'What does "Le metro" mean?', 'multiple_choice', 'Subway', 'luh may-troh', '["Taxi", "Subway", "Airport", "Platform"]', 6),
( 'How do you ask: "Do you speak English?"', 'translate', 'Parlez-vous anglais?', 'par-lay voo ahn-glay', NULL, 7),
( 'Choose the French phrase for "I am lost"', 'multiple_choice', 'Je suis perdu', 'zhuh swee pair-doo', '["Je suis pret", "Je suis perdu", "Je suis fatigue", "Je suis content"]', 8),
( 'Translate: The menu, please', 'translate', 'Le menu, s''il vous plait', 'luh meh-new seel voo pleh', NULL, 9),
( 'How do you say "airport" in French?', 'multiple_choice', 'L''aeroport', 'leh-roh-por', '["Le quai", "La gare", "L''aeroport", "Le pont"]', 10)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);

-- Questions for French Lesson "Verbes Quotidiens"
WITH seed_lesson AS (
  SELECT lesson.id FROM lessons lesson
  JOIN languages language ON language.id = lesson.language_id
  WHERE language.code = 'fr' AND lesson.title = 'Verbes Quotidiens'
  ORDER BY lesson.id LIMIT 1
), seed_questions (prompt, question_type, correct_answer, phonetic, options, order_index) AS (
VALUES
( 'Translate: I eat', 'translate', 'Je mange', 'zhuh mahnzh', NULL, 1),
( 'How do you say "I drink"?', 'multiple_choice', 'Je bois', 'zhuh bwah', '["Je lis", "Je bois", "Je dors", "Je parle"]', 2),
( 'Translate: We speak', 'translate', 'Nous parlons', 'noo par-lohn', NULL, 3),
( 'What does "Elle travaille" mean?', 'multiple_choice', 'She works', 'ell trah-vai', '["She studies", "She works", "She walks", "She sings"]', 4),
( 'How do you say "They live"?', 'translate', 'Ils habitent', 'eel zah-beet', NULL, 5),
( 'Choose the French for "I study"', 'multiple_choice', 'J''etudie', 'zhay-tew-dee', '["J''etudie", "J''ecoute", "J''arrive", "J''attends"]', 6),
( 'Translate: You listen', 'translate', 'Tu ecoutes', 'tew ay-koot', NULL, 7),
( 'What does "Nous marchons" mean?', 'multiple_choice', 'We walk', 'noo mar-shohn', '["We run", "We walk", "We arrive", "We dance"]', 8),
( 'How do you say "I sleep"?', 'translate', 'Je dors', 'zhuh dor', NULL, 9),
( 'Choose the French for "You (formal) write"', 'multiple_choice', 'Vous ecrivez', 'voo zay-kree-vay', '["Vous ecrivez", "Vous chantez", "Vous voyez", "Vous courez"]', 10)
)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index)
SELECT seed_lesson.id, seed_questions.*
FROM seed_lesson CROSS JOIN seed_questions
WHERE NOT EXISTS (
  SELECT 1 FROM questions existing
  WHERE existing.lesson_id = seed_lesson.id AND existing.prompt = seed_questions.prompt
);
