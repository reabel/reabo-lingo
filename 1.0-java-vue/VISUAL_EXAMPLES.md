# Visual Examples - Phonetic Display

## Question Display Examples

### Spanish (Latin Script - No Phonetic Needed)
```
┌─────────────────────────────────────┐
│ How do you say "Hello" in Spanish?  │
│                                     │
│  ┌─────────┐  ┌─────────┐         │
│  │  Hola   │  │ Adiós   │         │
│  └─────────┘  └─────────┘         │
│                                     │
│  ┌─────────┐  ┌─────────┐         │
│  │ Gracias │  │Por favor│         │
│  └─────────┘  └─────────┘         │
└─────────────────────────────────────┘
```

### Russian (Cyrillic + Romanization)
```
┌────────────────────────────────────────┐
│ How do you say "Hello" in Russian?     │
│                                        │
│  ┌──────────────────┐  ┌─────────┐   │
│  │  Здравствуйте    │  │  Привет │   │
│  │  (Zdravstvuyte)  │  │ (Privet)│   │
│  └──────────────────┘  └─────────┘   │
│                                        │
│  ┌──────────────┐  ┌──────────────┐  │
│  │   Спасибо    │  │  Пожалуйста  │  │
│  │  (Spasibo)   │  │(Pozhaluysta) │  │
│  └──────────────┘  └──────────────┘  │
└────────────────────────────────────────┘
```

### Japanese (Hiragana/Kanji + Romaji)
```
┌────────────────────────────────────────┐
│ How do you say "Hello" in Japanese?    │
│                                        │
│  ┌──────────────────┐  ┌─────────┐   │
│  │   こんにちは     │  │さようなら│   │
│  │  (Konnichiwa)    │  │(Sayounara)│  │
│  └──────────────────┘  └─────────┘   │
│                                        │
│  ┌──────────────┐  ┌──────────────┐  │
│  │  ありがとう   │  │おねがいします │  │
│  │  (Arigatou)   │  │(Onegaishimasu)│  │
│  └──────────────┘  └──────────────┘  │
└────────────────────────────────────────┘
```

## Translate Question - Input Field

### Spanish
```
┌───────────────────────────────────────┐
│ Translate to Spanish: Goodbye         │
│                                       │
│ ┌───────────────────────────────────┐ │
│ │ Type your answer...               │ │
│ └───────────────────────────────────┘ │
└───────────────────────────────────────┘
```

### Russian
```
┌───────────────────────────────────────┐
│ Translate to Russian: Goodbye         │
│                                       │
│ ┌───────────────────────────────────┐ │
│ │ Type your answer... (Do svidaniya)│ │
│ └───────────────────────────────────┘ │
└───────────────────────────────────────┘
```

### Japanese
```
┌───────────────────────────────────────┐
│ Translate to Japanese: Thank you      │
│                                       │
│ ┌───────────────────────────────────┐ │
│ │ Type your answer... (Arigatou)    │ │
│ └───────────────────────────────────┘ │
└───────────────────────────────────────┘
```

## Result Panel - Incorrect Answer

### Spanish (Latin Script)
```
┌─────────────────────────────────────┐
│ ❌ Incorrect                        │
│ Correct answer: Adiós               │
│                                     │
│ ┌─────────────┐                    │
│ │  Continue   │                    │
│ └─────────────┘                    │
└─────────────────────────────────────┘
```

### Russian (Cyrillic + Romanization)
```
┌─────────────────────────────────────┐
│ ❌ Incorrect                        │
│ Correct answer: До свидания          │
│ (Do svidaniya)                      │
│                                     │
│ ┌─────────────┐                    │
│ │  Continue   │                    │
│ └─────────────┘                    │
└─────────────────────────────────────┘
```

### Japanese (Hiragana + Romaji)
```
┌─────────────────────────────────────┐
│ ❌ Incorrect                        │
│ Correct answer: ありがとう           │
│ (Arigatou)                          │
│                                     │
│ ┌─────────────┐                    │
│ │  Continue   │                    │
│ └─────────────┘                    │
└─────────────────────────────────────┘
```

## Benefits of This Approach

✅ **Non-intrusive**: Latin script languages work exactly as before
✅ **Helpful**: Users learning new scripts get pronunciation guidance
✅ **Consistent**: Same UI pattern across all languages
✅ **Educational**: Helps users learn both script and pronunciation
✅ **Accessible**: Makes content approachable for beginners

## Technical Implementation

### Display Logic
- If `phonetic` field exists and is not null → Show in parentheses
- If `phonetic` field is null → Display only native text
- Styling: Phonetic text is smaller, lighter, and italic

### When Phonetics Show
1. ✅ Input placeholder hints
2. ✅ Incorrect answer feedback
3. 🔮 Multiple choice options (future enhancement)
4. 🔮 Lesson titles (future enhancement)

### Language Detection
No automatic detection needed - phonetics are manually added per question:
- Russian: Use standard romanization
- Japanese: Use romaji (Hepburn system recommended)
- Chinese: Use pinyin
- Korean: Use revised romanization
- Arabic: Use standard romanization
