-- Migration to add phonetic column to questions table
-- Run this if you have an existing database

ALTER TABLE questions ADD COLUMN IF NOT EXISTS phonetic TEXT;

-- Update existing Russian questions with phonetics
UPDATE questions SET phonetic = 'Zdravstvuyte' WHERE correct_answer = 'Здравствуйте';
UPDATE questions SET phonetic = 'Do svidaniya' WHERE correct_answer = 'До свидания';
UPDATE questions SET phonetic = 'Spasibo' WHERE correct_answer = 'Спасибо';
UPDATE questions SET phonetic = 'Privet' WHERE correct_answer = 'Привет';

-- Update existing Japanese questions with phonetics (if any exist)
UPDATE questions SET phonetic = 'Konnichiwa' WHERE correct_answer = 'こんにちは';
UPDATE questions SET phonetic = 'Arigatou' WHERE correct_answer = 'ありがとう';
UPDATE questions SET phonetic = 'Ohayou' WHERE correct_answer = 'おはよう';
UPDATE questions SET phonetic = 'Sayounara' WHERE correct_answer = 'さようなら';
UPDATE questions SET phonetic = 'Onegaishimasu' WHERE correct_answer = 'おねがいします';
