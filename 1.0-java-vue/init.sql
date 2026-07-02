-- Initialize the database with sample data

-- Sample Languages
INSERT INTO languages (name, code, flag_emoji, description, is_active) VALUES
('Spanish', 'es', '🇪🇸', 'Learn Spanish - one of the most spoken languages', true),
('French', 'fr', '🇫🇷', 'Learn French - the language of love', true),
('German', 'de', '🇩🇪', 'Learn German - a powerful business language', true),
('Japanese', 'ja', '🇯🇵', 'Learn Japanese - explore Asian culture', true),
('Italian', 'it', '🇮🇹', 'Learn Italian - the language of art and cuisine', true),
('Russian', 'ru', '🇷🇺', 'Learn Russian - a major Slavic language', true),
('Dutch', 'nl', '🇳🇱', 'Learn Dutch - the language of the Netherlands', true),
('Portuguese', 'pt', '🇵🇹', 'Learn Portuguese - spoken across four continents', true)
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
(6, 'What does "Bonsoir" mean?', 'multiple_choice', 'Good evening', NULL, '["Good morning", "Good night", "Good evening", "Hello"]', 4),
(6, 'Translate to French: Please', 'translate', 'S''il vous plaît', NULL, NULL, 5),
(6, 'How do you say "You''re welcome"?', 'multiple_choice', 'De rien', NULL, '["De rien", "Merci", "Bonjour", "Bonsoir"]', 6),
(6, 'What does "Excusez-moi" mean?', 'multiple_choice', 'Excuse me', NULL, '["Excuse me", "Hello", "Goodbye", "Thank you"]', 7),
(6, 'Translate to French: Good morning', 'translate', 'Bonjour', NULL, NULL, 8),
(6, 'How do you say "Good night"?', 'multiple_choice', 'Bonne nuit', NULL, '["Bonne nuit", "Bonsoir", "Bonjour", "Au revoir"]', 9)
ON CONFLICT DO NOTHING;

-- Questions for French Lesson 7 (Nombres 1-10)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(7, 'How do you say "1" in French?', 'multiple_choice', 'Un', NULL, '["Un", "Deux", "Trois", "Quatre"]', 1),
(7, 'Translate: Two', 'translate', 'Deux', NULL, NULL, 2),
(7, 'What number is "Cinq"?', 'multiple_choice', '5', NULL, '["3", "5", "7", "9"]', 3),
(7, 'How do you say "10" in French?', 'multiple_choice', 'Dix', NULL, '["Huit", "Neuf", "Dix", "Sept"]', 4),
(7, 'Translate: Three', 'translate', 'Trois', NULL, NULL, 5),
(7, 'What number is "Sept"?', 'multiple_choice', '7', NULL, '["6", "7", "8", "9"]', 6),
(7, 'How do you say "4"?', 'translate', 'Quatre', NULL, NULL, 7),
(7, 'What does "Six" mean?', 'multiple_choice', '6', NULL, '["4", "5", "6", "7"]', 8),
(7, 'Translate: Eight', 'translate', 'Huit', NULL, NULL, 9),
(7, 'How do you say "9" in French?', 'multiple_choice', 'Neuf', NULL, '["Sept", "Huit", "Neuf", "Dix"]', 10)
ON CONFLICT DO NOTHING;

-- Questions for French Lesson 8 (Nourriture)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(8, 'How do you say "bread" in French?', 'multiple_choice', 'Le pain', NULL, '["Le pain", "Le lait", "Le fromage", "La pomme"]', 1),
(8, 'Translate: Water', 'translate', 'L''eau', NULL, NULL, 2),
(8, 'What does "Le fromage" mean?', 'multiple_choice', 'Cheese', NULL, '["Bread", "Milk", "Cheese", "Apple"]', 3),
(8, 'How do you say "apple"?', 'multiple_choice', 'La pomme', NULL, '["La poire", "La pomme", "La banane", "L''orange"]', 4),
(8, 'Translate: Milk', 'translate', 'Le lait', NULL, NULL, 5),
(8, 'What does "Le poulet" mean?', 'multiple_choice', 'Chicken', NULL, '["Fish", "Beef", "Chicken", "Pork"]', 6),
(8, 'How do you say "egg" in French?', 'multiple_choice', 'L''œuf', NULL, '["Le beurre", "Le sucre", "L''œuf", "La farine"]', 7),
(8, 'Translate: Orange', 'translate', 'L''orange', NULL, NULL, 8),
(8, 'What does "Le vin" mean?', 'multiple_choice', 'Wine', NULL, '["Beer", "Wine", "Juice", "Coffee"]', 9),
(8, 'How do you say "coffee"?', 'translate', 'Le café', NULL, NULL, 10)
ON CONFLICT DO NOTHING;

-- Questions for French Lesson 9 (Couleurs)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(9, 'How do you say "red" in French?', 'multiple_choice', 'Rouge', NULL, '["Rouge", "Bleu", "Vert", "Jaune"]', 1),
(9, 'Translate: Blue', 'translate', 'Bleu', NULL, NULL, 2),
(9, 'What does "Vert" mean?', 'multiple_choice', 'Green', NULL, '["Red", "Blue", "Green", "Yellow"]', 3),
(9, 'How do you say "yellow"?', 'multiple_choice', 'Jaune', NULL, '["Orange", "Jaune", "Violet", "Rose"]', 4),
(9, 'Translate: Black', 'translate', 'Noir', NULL, NULL, 5),
(9, 'What does "Blanc" mean?', 'multiple_choice', 'White', NULL, '["Black", "White", "Grey", "Brown"]', 6),
(9, 'How do you say "orange"?', 'translate', 'Orange', NULL, NULL, 7),
(9, 'What does "Rose" mean?', 'multiple_choice', 'Pink', NULL, '["Purple", "Pink", "Red", "Grey"]', 8),
(9, 'How do you say "purple"?', 'multiple_choice', 'Violet', NULL, '["Violet", "Gris", "Marron", "Beige"]', 9),
(9, 'Translate: Brown', 'translate', 'Marron', NULL, NULL, 10)
ON CONFLICT DO NOTHING;

-- Questions for French Lesson 10 (Famille)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(10, 'How do you say "mother" in French?', 'multiple_choice', 'La mère', NULL, '["La mère", "Le père", "La sœur", "Le frère"]', 1),
(10, 'Translate: Father', 'translate', 'Le père', NULL, NULL, 2),
(10, 'What does "Le frère" mean?', 'multiple_choice', 'Brother', NULL, '["Sister", "Brother", "Son", "Daughter"]', 3),
(10, 'How do you say "sister"?', 'multiple_choice', 'La sœur', NULL, '["La mère", "La fille", "La sœur", "La tante"]', 4),
(10, 'Translate: Son', 'translate', 'Le fils', NULL, NULL, 5),
(10, 'What does "La fille" mean?', 'multiple_choice', 'Daughter', NULL, '["Mother", "Sister", "Daughter", "Aunt"]', 6),
(10, 'How do you say "grandfather"?', 'multiple_choice', 'Le grand-père', NULL, '["Le grand-père", "La grand-mère", "L''oncle", "La tante"]', 7),
(10, 'Translate: Grandmother', 'translate', 'La grand-mère', NULL, NULL, 8),
(10, 'What does "L''oncle" mean?', 'multiple_choice', 'Uncle', NULL, '["Aunt", "Cousin", "Uncle", "Nephew"]', 9),
(10, 'How do you say "cousin"?', 'translate', 'Le cousin', NULL, NULL, 10)
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

-- Lessons for Portuguese (language_id = 8)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(8, 'Saudações', 'Learn basic greetings in Portuguese', 1, 1, 10, true),
(8, 'Números 1-10', 'Count from 1 to 10 in Portuguese', 1, 2, 10, true),
(8, 'Comida e Bebida', 'Learn common food and drink words', 1, 3, 15, true),
(8, 'Cores', 'Learn basic colors in Portuguese', 1, 4, 10, true),
(8, 'Família', 'Learn family member names', 2, 5, 15, true)
ON CONFLICT DO NOTHING;

-- Questions for Portuguese Lesson 36 (Saudações)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(36, 'How do you say "Hello" in Portuguese?', 'multiple_choice', 'Olá', NULL, '["Olá", "Tchau", "Obrigado", "Por favor"]', 1),
(36, 'Translate to Portuguese: Goodbye', 'translate', 'Tchau', NULL, NULL, 2),
(36, 'How do you say "Thank you"?', 'multiple_choice', 'Obrigado', NULL, '["Obrigado", "De nada", "Bom dia", "Boa noite"]', 3),
(36, 'What does "Bom dia" mean?', 'multiple_choice', 'Good morning', NULL, '["Good morning", "Good night", "Good afternoon", "Hello"]', 4),
(36, 'Translate to Portuguese: Please', 'translate', 'Por favor', NULL, NULL, 5),
(36, 'How do you say "You''re welcome"?', 'multiple_choice', 'De nada', NULL, '["De nada", "Obrigado", "Desculpe", "Olá"]', 6),
(36, 'What does "Boa tarde" mean?', 'multiple_choice', 'Good afternoon', NULL, '["Good morning", "Good afternoon", "Good evening", "Hello"]', 7),
(36, 'Translate to Portuguese: Good night', 'translate', 'Boa noite', NULL, NULL, 8)
ON CONFLICT DO NOTHING;

-- Questions for Portuguese Lesson 37 (Números 1-10)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(37, 'How do you say "1" in Portuguese?', 'multiple_choice', 'Um', NULL, '["Um", "Dois", "Três", "Quatro"]', 1),
(37, 'Translate: Two', 'translate', 'Dois', NULL, NULL, 2),
(37, 'What number is "Cinco"?', 'multiple_choice', '5', NULL, '["3", "5", "7", "9"]', 3),
(37, 'How do you say "10" in Portuguese?', 'multiple_choice', 'Dez', NULL, '["Oito", "Nove", "Dez", "Sete"]', 4),
(37, 'Translate: Three', 'translate', 'Três', NULL, NULL, 5),
(37, 'What number is "Sete"?', 'multiple_choice', '7', NULL, '["6", "7", "8", "9"]', 6),
(37, 'How do you say "4"?', 'translate', 'Quatro', NULL, NULL, 7),
(37, 'What does "Seis" mean?', 'multiple_choice', '6', NULL, '["4", "5", "6", "7"]', 8),
(37, 'Translate: Eight', 'translate', 'Oito', NULL, NULL, 9),
(37, 'How do you say "9" in Portuguese?', 'multiple_choice', 'Nove', NULL, '["Sete", "Oito", "Nove", "Dez"]', 10)
ON CONFLICT DO NOTHING;

-- Questions for Portuguese Lesson 38 (Comida e Bebida)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(38, 'How do you say "bread" in Portuguese?', 'multiple_choice', 'O pão', NULL, '["O pão", "O leite", "O queijo", "A maçã"]', 1),
(38, 'Translate: Water', 'translate', 'A água', NULL, NULL, 2),
(38, 'What does "O queijo" mean?', 'multiple_choice', 'Cheese', NULL, '["Bread", "Milk", "Cheese", "Apple"]', 3),
(38, 'How do you say "apple"?', 'multiple_choice', 'A maçã', NULL, '["A pera", "A maçã", "A banana", "A laranja"]', 4),
(38, 'Translate: Milk', 'translate', 'O leite', NULL, NULL, 5),
(38, 'What does "O frango" mean?', 'multiple_choice', 'Chicken', NULL, '["Fish", "Beef", "Chicken", "Pork"]', 6),
(38, 'How do you say "coffee"?', 'multiple_choice', 'O café', NULL, '["O chá", "O suco", "O café", "A cerveja"]', 7),
(38, 'Translate: Orange', 'translate', 'A laranja', NULL, NULL, 8)
ON CONFLICT DO NOTHING;

-- Questions for Portuguese Lesson 39 (Cores)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(39, 'How do you say "red" in Portuguese?', 'multiple_choice', 'Vermelho', NULL, '["Vermelho", "Azul", "Verde", "Amarelo"]', 1),
(39, 'Translate: Blue', 'translate', 'Azul', NULL, NULL, 2),
(39, 'What does "Verde" mean?', 'multiple_choice', 'Green', NULL, '["Red", "Blue", "Green", "Yellow"]', 3),
(39, 'How do you say "yellow"?', 'multiple_choice', 'Amarelo', NULL, '["Laranja", "Amarelo", "Roxo", "Rosa"]', 4),
(39, 'Translate: Black', 'translate', 'Preto', NULL, NULL, 5),
(39, 'What does "Branco" mean?', 'multiple_choice', 'White', NULL, '["Black", "White", "Grey", "Brown"]', 6),
(39, 'How do you say "orange"?', 'translate', 'Laranja', NULL, NULL, 7),
(39, 'What does "Rosa" mean?', 'multiple_choice', 'Pink', NULL, '["Purple", "Pink", "Red", "Grey"]', 8)
ON CONFLICT DO NOTHING;

-- Questions for Portuguese Lesson 40 (Família)
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(40, 'How do you say "mother" in Portuguese?', 'multiple_choice', 'A mãe', NULL, '["A mãe", "O pai", "A irmã", "O irmão"]', 1),
(40, 'Translate: Father', 'translate', 'O pai', NULL, NULL, 2),
(40, 'What does "O irmão" mean?', 'multiple_choice', 'Brother', NULL, '["Sister", "Brother", "Son", "Daughter"]', 3),
(40, 'How do you say "sister"?', 'multiple_choice', 'A irmã', NULL, '["A mãe", "A filha", "A irmã", "A tia"]', 4),
(40, 'Translate: Son', 'translate', 'O filho', NULL, NULL, 5),
(40, 'What does "A filha" mean?', 'multiple_choice', 'Daughter', NULL, '["Mother", "Sister", "Daughter", "Aunt"]', 6),
(40, 'How do you say "grandfather"?', 'multiple_choice', 'O avô', NULL, '["O avô", "A avó", "O tio", "A tia"]', 7),
(40, 'Translate: Grandmother', 'translate', 'A avó', NULL, NULL, 8),
(40, 'What does "O tio" mean?', 'multiple_choice', 'Uncle', NULL, '["Aunt", "Cousin", "Uncle", "Nephew"]', 9),
(40, 'How do you say "cousin"?', 'translate', 'O primo', NULL, NULL, 10)
ON CONFLICT DO NOTHING;

-- Expanded French Lessons (language_id = 2)
INSERT INTO lessons (language_id, title, description, level, order_index, xp_reward, is_active) VALUES
(2, 'Voyage & Café', 'Order food and navigate French travel moments', 2, 6, 20, true),
(2, 'Verbes Quotidiens', 'Use practical everyday French action verbs', 2, 7, 20, true)
ON CONFLICT DO NOTHING;

-- Questions for French Lesson "Voyage & Café"
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'How do you ask: "Where is the train station?"', 'translate', 'Ou est la gare?', 'oo eh lah gahr', NULL, 1),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'Translate: I would like a coffee', 'translate', 'Je voudrais un cafe', 'zhuh voo-dreh uhn kah-fey', NULL, 2),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'What does "L''addition, s''il vous plait" mean?', 'multiple_choice', 'The bill, please', 'lah-dee-syon seel voo pleh', '["The menu, please", "The bill, please", "A table for two", "A coffee to go"]', 3),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'How do you say "ticket" in French?', 'multiple_choice', 'Le billet', 'luh bee-yeh', '["Le billet", "Le bagage", "Le passeport", "Le voyage"]', 4),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'Translate: A table for two, please', 'translate', 'Une table pour deux, s''il vous plait', 'ewn tah-bluh poor duh seel voo pleh', NULL, 5),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'What does "Le metro" mean?', 'multiple_choice', 'Subway', 'luh may-troh', '["Taxi", "Subway", "Airport", "Platform"]', 6),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'How do you ask: "Do you speak English?"', 'translate', 'Parlez-vous anglais?', 'par-lay voo ahn-glay', NULL, 7),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'Choose the French phrase for "I am lost"', 'multiple_choice', 'Je suis perdu', 'zhuh swee pair-doo', '["Je suis pret", "Je suis perdu", "Je suis fatigue", "Je suis content"]', 8),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'Translate: The menu, please', 'translate', 'Le menu, s''il vous plait', 'luh meh-new seel voo pleh', NULL, 9),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Voyage & Café' LIMIT 1), 'How do you say "airport" in French?', 'multiple_choice', 'L''aeroport', 'leh-roh-por', '["Le quai", "La gare", "L''aeroport", "Le pont"]', 10)
ON CONFLICT DO NOTHING;

-- Questions for French Lesson "Verbes Quotidiens"
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'Translate: I eat', 'translate', 'Je mange', 'zhuh mahnzh', NULL, 1),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'How do you say "I drink"?', 'multiple_choice', 'Je bois', 'zhuh bwah', '["Je lis", "Je bois", "Je dors", "Je parle"]', 2),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'Translate: We speak', 'translate', 'Nous parlons', 'noo par-lohn', NULL, 3),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'What does "Elle travaille" mean?', 'multiple_choice', 'She works', 'ell trah-vai', '["She studies", "She works", "She walks", "She sings"]', 4),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'How do you say "They live"?', 'translate', 'Ils habitent', 'eel zah-beet', NULL, 5),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'Choose the French for "I study"', 'multiple_choice', 'J''etudie', 'zhay-tew-dee', '["J''etudie", "J''ecoute", "J''arrive", "J''attends"]', 6),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'Translate: You listen', 'translate', 'Tu ecoutes', 'tew ay-koot', NULL, 7),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'What does "Nous marchons" mean?', 'multiple_choice', 'We walk', 'noo mar-shohn', '["We run", "We walk", "We arrive", "We dance"]', 8),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'How do you say "I sleep"?', 'translate', 'Je dors', 'zhuh dor', NULL, 9),
((SELECT id FROM lessons WHERE language_id = 2 AND title = 'Verbes Quotidiens' LIMIT 1), 'Choose the French for "You (formal) write"', 'multiple_choice', 'Vous ecrivez', 'voo zay-kree-vay', '["Vous ecrivez", "Vous chantez", "Vous voyez", "Vous courez"]', 10)
ON CONFLICT DO NOTHING;
