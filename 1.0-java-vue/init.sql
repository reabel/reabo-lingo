-- Initialize the database with sample data

-- Sample Languages
INSERT INTO languages (name, code, flag_emoji, description, is_active) VALUES
('Spanish', 'es', '🇪🇸', 'Learn Spanish - one of the most spoken languages', true),
('French', 'fr', '🇫🇷', 'Learn French - the language of love', true),
('German', 'de', '🇩🇪', 'Learn German - a powerful business language', true),
('Japanese', 'ja', '🇯🇵', 'Learn Japanese - explore Asian culture', true),
('Italian', 'it', '🇮🇹', 'Learn Italian - the language of art and cuisine', true),
('Russian', 'ru', '🇷🇺', 'Learn Russian - a major Slavic language', true),
('Dutch', 'nl', '🇳🇱', 'Learn Dutch - the language of the Netherlands', true)
ON CONFLICT DO NOTHING;

-- Sample Lessons for Spanish (language_id = 1)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(1, 'Greetings', 'Learn basic greetings in Spanish', 1, 1, 10, true),
(1, 'Numbers 1-10', 'Count from 1 to 10 in Spanish', 1, 2, 10, true),
(1, 'Food & Drinks', 'Learn common food and drink words', 1, 3, 15, true),
(1, 'Colors', 'Learn basic colors in Spanish', 1, 4, 10, true),
(1, 'Family', 'Learn family member names', 2, 5, 15, true)
ON CONFLICT DO NOTHING;

-- Sample Questions for Lesson 1 (Greetings)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(1, 'How do you say "Hello" in Spanish?', 'multiple_choice', 'Hola', NULL, '["Hola", "Adiós", "Gracias", "Por favor"]', 1),
(1, 'Translate to Spanish: Goodbye', 'translate', 'Adiós', NULL, NULL, 2),
(1, 'How do you say "Thank you"?', 'multiple_choice', 'Gracias', NULL, '["Gracias", "De nada", "Buenos días", "Buenas noches"]', 3),
(1, 'What does "Buenos días" mean?', 'multiple_choice', 'Good morning', NULL, '["Good morning", "Good night", "Good afternoon", "Hello"]', 4),
(1, 'Translate to Spanish: Please', 'translate', 'Por favor', NULL, NULL, 5)
ON CONFLICT DO NOTHING;

-- Sample Questions for Lesson 2 (Numbers)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(2, 'How do you say "1" in Spanish?', 'multiple_choice', 'Uno', NULL, '["Uno", "Dos", "Tres", "Cuatro"]', 1),
(2, 'Translate: Five', 'translate', 'Cinco', NULL, NULL, 2),
(2, 'What number is "Diez"?', 'multiple_choice', '10', NULL, '["5", "8", "10", "7"]', 3),
(2, 'How do you say "3"?', 'translate', 'Tres', NULL, NULL, 4)
ON CONFLICT DO NOTHING;

-- Lessons for French (language_id = 2)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(2, 'Salutations', 'Learn basic greetings in French', 1, 1, 10, true),
(2, 'Nombres 1-10', 'Count from 1 to 10 in French', 1, 2, 10, true),
(2, 'Nourriture', 'Learn common food words', 1, 3, 15, true),
(2, 'Couleurs', 'Learn basic colors in French', 1, 4, 10, true),
(2, 'Famille', 'Learn family member names', 2, 5, 15, true)
ON CONFLICT DO NOTHING;

-- Lessons for German (language_id = 3)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(3, 'Grüße', 'Learn basic greetings in German', 1, 1, 10, true),
(3, 'Zahlen 1-10', 'Count from 1 to 10 in German', 1, 2, 10, true),
(3, 'Essen & Trinken', 'Learn common food and drink words', 1, 3, 15, true),
(3, 'Farben', 'Learn basic colors in German', 1, 4, 10, true),
(3, 'Familie', 'Learn family member names', 2, 5, 15, true)
ON CONFLICT DO NOTHING;

-- Lessons for Japanese (language_id = 4)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(4, 'あいさつ (Greetings)', 'Learn basic greetings in Japanese', 1, 1, 10, true),
(4, '数字 1-10 (Numbers)', 'Count from 1 to 10 in Japanese', 1, 2, 10, true),
(4, '食べ物 (Food)', 'Learn common food words', 1, 3, 15, true),
(4, '色 (Colors)', 'Learn basic colors in Japanese', 1, 4, 10, true),
(4, '家族 (Family)', 'Learn family member names', 2, 5, 15, true)
ON CONFLICT DO NOTHING;

-- Lessons for Italian (language_id = 5)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(5, 'Saluti', 'Learn basic greetings in Italian', 1, 1, 10, true),
(5, 'Numeri 1-10', 'Count from 1 to 10 in Italian', 1, 2, 10, true),
(5, 'Cibo e Bevande', 'Learn common food and drink words', 1, 3, 15, true),
(5, 'Colori', 'Learn basic colors in Italian', 1, 4, 10, true),
(5, 'Famiglia', 'Learn family member names', 2, 5, 15, true)
ON CONFLICT DO NOTHING;

-- Lessons for Russian (language_id = 6)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(6, 'Приветствия (Greetings)', 'Learn basic greetings in Russian', 1, 1, 10, true),
(6, 'Числа 1-10 (Numbers)', 'Count from 1 to 10 in Russian', 1, 2, 10, true),
(6, 'Еда и Напитки (Food)', 'Learn common food and drink words', 1, 3, 15, true),
(6, 'Цвета (Colors)', 'Learn basic colors in Russian', 1, 4, 10, true),
(6, 'Семья (Family)', 'Learn family member names', 2, 5, 15, true)
ON CONFLICT DO NOTHING;

-- Lessons for Dutch (language_id = 7)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(7, 'Begroetingen (Greetings)', 'Learn basic greetings in Dutch', 1, 1, 10, true),
(7, 'Getallen 1-10 (Numbers)', 'Count from 1 to 10 in Dutch', 1, 2, 10, true),
(7, 'Eten en Drinken (Food)', 'Learn common food and drink words', 1, 3, 15, true),
(7, 'Kleuren (Colors)', 'Learn basic colors in Dutch', 1, 4, 10, true),
(7, 'Familie (Family)', 'Learn family member names', 2, 5, 15, true)
ON CONFLICT DO NOTHING;

-- Questions for French Lesson 6 (Salutations)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(6, 'How do you say "Hello" in French?', 'multiple_choice', 'Bonjour', NULL, '["Bonjour", "Au revoir", "Merci", "S''il vous plaît"]', 1),
(6, 'Translate to French: Goodbye', 'translate', 'Au revoir', NULL, NULL, 2),
(6, 'How do you say "Thank you"?', 'multiple_choice', 'Merci', NULL, '["Merci", "De rien", "Bonjour", "Bonsoir"]', 3),
(6, 'What does "Bonsoir" mean?', 'multiple_choice', 'Good evening', NULL, '["Good morning", "Good night", "Good evening", "Hello"]', 4)
ON CONFLICT DO NOTHING;

-- Questions for Russian Lesson 26 (Приветствия)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(26, 'How do you say "Hello" in Russian?', 'multiple_choice', 'Здравствуйте', 'Zdravstvuyte', '["Здравствуйте", "До свидания", "Спасибо", "Пожалуйста"]', 1),
(26, 'Translate to Russian: Goodbye', 'translate', 'До свидания', 'Do svidaniya', NULL, 2),
(26, 'How do you say "Thank you"?', 'multiple_choice', 'Спасибо', 'Spasibo', '["Спасибо", "Пожалуйста", "Привет", "Пока"]', 3),
(26, 'What does "Привет" mean?', 'multiple_choice', 'Hi/Hello', 'Privet', '["Goodbye", "Thank you", "Hi/Hello", "Please"]', 4)
ON CONFLICT DO NOTHING;

-- Questions for Dutch Lesson 31 (Begroetingen)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(31, 'How do you say "Hello" in Dutch?', 'multiple_choice', 'Hallo', NULL, '["Hallo", "Dag", "Dank je", "Alsjeblieft"]', 1),
(31, 'Translate to Dutch: Goodbye', 'translate', 'Tot ziens', NULL, NULL, 2),
(31, 'How do you say "Thank you"?', 'multiple_choice', 'Dank je', NULL, '["Dank je", "Alsjeblieft", "Goedemorgen", "Goedendag"]', 3),
(31, 'What does "Goedendag" mean?', 'multiple_choice', 'Good day', NULL, '["Good morning", "Good night", "Good day", "Hello"]', 4)
ON CONFLICT DO NOTHING;

-- Questions for Japanese Lesson 16 (あいさつ - Greetings)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(16, 'How do you say "Hello" in Japanese?', 'multiple_choice', 'こんにちは', 'Konnichiwa', '["こんにちは", "さようなら", "ありがとう", "おねがいします"]', 1),
(16, 'Translate to Japanese: Thank you', 'translate', 'ありがとう', 'Arigatou', NULL, 2),
(16, 'How do you say "Good morning"?', 'multiple_choice', 'おはよう', 'Ohayou', '["おはよう", "こんばんは", "さようなら", "こんにちは"]', 3),
(16, 'What does "さようなら" mean?', 'multiple_choice', 'Goodbye', 'Sayounara', '["Hello", "Thank you", "Goodbye", "Please"]', 4),
(16, 'Translate to Japanese: Please', 'translate', 'おねがいします', 'Onegaishimasu', NULL, 5)
ON CONFLICT DO NOTHING;

-- Questions for Japanese Lesson 17 (数字 - Numbers)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(17, 'How do you say "1" in Japanese?', 'multiple_choice', 'いち', 'Ichi', '["いち", "に", "さん", "よん"]', 1),
(17, 'Translate: Five', 'translate', 'ご', 'Go', NULL, 2),
(17, 'What number is "じゅう"?', 'multiple_choice', '10', 'Juu', '["5", "8", "10", "7"]', 3),
(17, 'How do you say "3"?', 'translate', 'さん', 'San', NULL, 4)
ON CONFLICT DO NOTHING;

-- Additional Russian Questions for Lesson 27 (Числа - Numbers)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(27, 'How do you say "1" in Russian?', 'multiple_choice', 'один', 'Odin', '["один", "два", "три", "четыре"]', 1),
(27, 'Translate: Five', 'translate', 'пять', 'Pyat', NULL, 2),
(27, 'What number is "десять"?', 'multiple_choice', '10', 'Desyat', '["5", "8", "10", "7"]', 3),
(27, 'How do you say "3"?', 'translate', 'три', 'Tri', NULL, 4)
ON CONFLICT DO NOTHING;
