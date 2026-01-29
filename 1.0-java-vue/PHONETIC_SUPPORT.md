# Phonetic Support for Non-Latin Scripts

This feature adds phonetic romanization support for languages that use non-Latin characters (e.g., Russian Cyrillic, Japanese Hiragana/Katakana/Kanji, Arabic, Korean, etc.).

## Overview

For languages with non-standard character sets, the application now displays both:
1. **Native characters** - The word/phrase in its original script (e.g., こんにちは, Здравствуйте)
2. **Phonetic equivalent** - A romanized version for pronunciation (e.g., Konnichiwa, Zdravstvuyte)

## Implementation

### Backend (Java/Spring Boot)

**Model Changes:**
- Added `phonetic` field to the `Question` model ([Question.java](backend/src/main/java/com/reabolingo/app/model/Question.java#L30))
- Field is nullable - only populated for non-Latin script languages
- Stored as TEXT in database

### Database

**Schema:**
```sql
ALTER TABLE questions ADD COLUMN phonetic TEXT;
```

**Sample Data:**

Russian example:
```sql
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(26, 'How do you say "Hello" in Russian?', 'multiple_choice', 'Здравствуйте', 'Zdravstvuyte', ...);
```

Japanese example:
```sql
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) VALUES
(16, 'Translate to Japanese: Thank you', 'translate', 'ありがとう', 'Arigatou', NULL, 2);
```

### Frontend (Vue.js)

**Display Logic:**
1. **Input placeholder** - Shows phonetic hint when typing answers
2. **Result panel** - Displays both native and phonetic when showing correct answer
3. **Future enhancement** - Multiple choice options can show phonetics

**Key Changes in [LessonPlay.vue](frontend/src/views/LessonPlay.vue):**
- Input placeholder includes phonetic hint if available
- Correct answer display shows phonetic in parentheses
- CSS styling for phonetic text (lighter, italic)

## Languages Supported

### Currently Implemented:
- **Russian** (Cyrillic) - Uses standard romanization
- **Japanese** (Hiragana/Katakana/Kanji) - Uses romaji

### Easy to Add:
- **Korean** - Use romanization (Hangul → Latin)
- **Arabic** - Use romanization
- **Greek** - Use romanization
- **Chinese** - Use pinyin
- **Thai** - Use romanization
- **Hebrew** - Use romanization

### Latin-Script Languages (No phonetics needed):
- Spanish, French, German, Italian, Portuguese, Dutch, etc.

## Adding Phonetics to New Questions

When creating questions for non-Latin script languages, add the phonetic field:

```sql
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) 
VALUES (
  123, 
  'How do you say "Goodbye"?', 
  'translate', 
  'さようなら',  -- Native characters
  'Sayounara',   -- Phonetic romanization
  NULL, 
  1
);
```

## Migration

For existing databases, run:
```bash
psql -U your_user -d reabolingo < migration_add_phonetic.sql
```

## Examples

### Russian (Cyrillic → Latin)
| Native | Phonetic | Meaning |
|--------|----------|---------|
| Здравствуйте | Zdravstvuyte | Hello (formal) |
| До свидания | Do svidaniya | Goodbye |
| Спасибо | Spasibo | Thank you |
| Привет | Privet | Hi |

### Japanese (Hiragana/Kanji → Romaji)
| Native | Phonetic | Meaning |
|--------|----------|---------|
| こんにちは | Konnichiwa | Hello |
| ありがとう | Arigatou | Thank you |
| おはよう | Ohayou | Good morning |
| さようなら | Sayounara | Goodbye |
| おねがいします | Onegaishimasu | Please |

## UI Examples

**Translate Question:**
```
Prompt: "Translate to Japanese: Thank you"
Input placeholder: "Type your answer... (Arigatou)"
```

**Result (Incorrect):**
```
❌ Incorrect
Correct answer: ありがとう
(Arigatou)
```

**Multiple Choice (Future):**
```
[こんにちは]
[Konnichiwa]

[さようなら]  
[Sayounara]
```

## Benefits

1. **Helps pronunciation** - Users can learn how to say words correctly
2. **Easier typing** - Users can see romanized version when typing
3. **Better learning** - Connects native script to familiar alphabet
4. **Accessibility** - Assists users unfamiliar with the script
