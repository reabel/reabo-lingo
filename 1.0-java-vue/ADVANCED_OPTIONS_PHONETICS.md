# Advanced: Multiple Choice Options with Phonetics

## Overview

This is an optional enhancement to show phonetic text for each option in multiple choice questions.

## Current Implementation

Currently, options are stored as a simple JSON array of strings:
```json
["こんにちは", "さようなら", "ありがとう", "おねがいします"]
```

## Enhanced Implementation (Optional)

To support phonetics in options, you can store them as objects:

```json
[
  {"text": "こんにちは", "phonetic": "Konnichiwa"},
  {"text": "さようなら", "phonetic": "Sayounara"},
  {"text": "ありがとう", "phonetic": "Arigatou"},
  {"text": "おねがいします", "phonetic": "Onegaishimasu"}
]
```

### Database Update Example

```sql
-- Update a Russian multiple choice question
UPDATE questions 
SET options = '[
  {"text": "Здравствуйте", "phonetic": "Zdravstvuyte"},
  {"text": "До свидания", "phonetic": "Do svidaniya"},
  {"text": "Спасибо", "phonetic": "Spasibo"},
  {"text": "Пожалуйста", "phonetic": "Pozhaluysta"}
]'
WHERE id = 26 AND question_type = 'multiple_choice';
```

### Frontend Update

Update the LessonPlay.vue computed properties:

```javascript
const options = computed(() => {
  if (!currentQuestion.value?.options) return []
  try {
    const parsed = JSON.parse(currentQuestion.value.options)
    // Support both formats: array of strings OR array of objects
    if (parsed.length > 0 && typeof parsed[0] === 'object') {
      return parsed.map(opt => opt.text)
    }
    return parsed
  } catch {
    return []
  }
})

const optionPhonetics = computed(() => {
  if (!currentQuestion.value?.options) return []
  try {
    const parsed = JSON.parse(currentQuestion.value.options)
    // Check if options contain phonetic data
    if (parsed.length > 0 && typeof parsed[0] === 'object' && parsed[0].phonetic) {
      return parsed.map(opt => opt.phonetic)
    }
    return []
  } catch {
    return []
  }
})
```

## Benefits

✅ Users see pronunciation for all options, not just the correct answer
✅ Helps with recognition of unfamiliar scripts
✅ Backward compatible - still supports simple string arrays

## Recommendation

**Start Simple**: The current implementation (phonetics only for correct answers) is sufficient for most use cases. Add option phonetics later if user feedback indicates it would be valuable.

## Example SQL Migration (Optional)

```sql
-- Update Japanese greetings lesson with option phonetics
UPDATE questions 
SET options = '[
  {"text": "こんにちは", "phonetic": "Konnichiwa"},
  {"text": "さようなら", "phonetic": "Sayounara"},
  {"text": "ありがとう", "phonetic": "Arigatou"},
  {"text": "おねがいします", "phonetic": "Onegaishimasu"}
]'
WHERE lesson_id = 16 AND order_index = 1;

-- Update Russian greetings lesson with option phonetics
UPDATE questions 
SET options = '[
  {"text": "Здравствуйте", "phonetic": "Zdravstvuyte"},
  {"text": "До свидания", "phonetic": "Do svidaniya"},
  {"text": "Спасибо", "phonetic": "Spasibo"},
  {"text": "Пожалуйста", "phonetic": "Pozhaluysta"}
]'
WHERE lesson_id = 26 AND order_index = 1;
```
