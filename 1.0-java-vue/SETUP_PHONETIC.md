# Quick Setup Guide - Phonetic Support

## What Was Changed

✅ **Backend Model** - Added `phonetic` field to Question entity
✅ **Database Schema** - Updated init.sql with phonetic column
✅ **Sample Data** - Added phonetic romanizations for Russian and Japanese
✅ **Frontend UI** - Updated to display phonetic text alongside native characters

## How to Apply Changes

### Option 1: Fresh Database (Recommended for Development)

If you're okay with resetting your database:

```bash
cd 1.0-java-vue

# Stop and remove existing containers & volumes
docker-compose down -v

# Start fresh with updated schema
docker-compose up -d postgres

# Wait for database to be ready (about 10 seconds)
sleep 10

# Rebuild and start backend
cd backend
./mvnw clean package
./mvnw spring-boot:run
```

### Option 2: Migrate Existing Database

If you want to keep existing data:

```bash
cd 1.0-java-vue

# Apply migration to running database
docker exec -i reabolingo-db psql -U postgres -d reabolingo < migration_add_phonetic.sql

# Or if database is not in Docker:
psql -U postgres -d reabolingo < migration_add_phonetic.sql

# Restart backend to pick up model changes
cd backend
./mvnw clean package
./mvnw spring-boot:run
```

### Frontend (No changes needed)

The frontend will automatically use the new phonetic field when available.

```bash
cd frontend
npm install  # Only if you haven't already
npm run dev
```

## Testing the Feature

1. **Navigate to Russian Lesson 26** (Приветствия - Greetings)
   - You'll see Cyrillic characters with romanization
   - Example: "Здравствуйте (Zdravstvuyte)"

2. **Navigate to Japanese Lesson 16** (あいさつ - Greetings)
   - You'll see Japanese characters with romaji
   - Example: "ありがとう (Arigatou)"

3. **Try a translate question**
   - The input placeholder will show the phonetic hint
   - If you answer incorrectly, the correct answer shows both scripts

4. **Check multiple choice questions**
   - Native characters are displayed
   - Phonetic text shows in the result panel if answered incorrectly

## What You'll See

### Before (Spanish - Latin script):
```
Correct answer: Hola
```

### After (Russian - Cyrillic):
```
Correct answer: Здравствуйте
(Zdravstvuyte)
```

### After (Japanese - Hiragana):
```
Correct answer: ありがとう
(Arigatou)
```

## Adding More Phonetic Data

To add phonetic support to more questions, edit [init.sql](init.sql):

```sql
INSERT INTO questions (lesson_id, prompt, question_type, correct_answer, phonetic, options, order_index) 
VALUES (
  lesson_id, 
  'Your prompt here', 
  'translate', 
  'Native characters',
  'Phonetic romanization',  -- Add this field
  NULL, 
  order_num
);
```

See [PHONETIC_SUPPORT.md](PHONETIC_SUPPORT.md) for detailed documentation.
