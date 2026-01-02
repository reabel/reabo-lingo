# ReaboLingo - Duolingo Clone

A full-stack language learning application built with Java Spring Boot and Vue.js 3.

## 🚀 Features

- **Multiple Languages**: Learn Spanish, French, German, Japanese, and Italian
- **Interactive Lessons**: Engaging lessons with multiple question types
- **Progress Tracking**: Track XP, streaks, and completed lessons
- **Modern UI**: Clean, responsive design inspired by Duolingo
- **RESTful API**: Well-structured backend with JPA/Hibernate

## 🛠️ Tech Stack

### Backend
- Java 17
- Spring Boot 3.2.1
- Spring Data JPA
- PostgreSQL
- Maven

### Frontend
- Vue.js 3 (Composition API)
- Vue Router
- Pinia (State Management)
- Axios
- Vite

### Database
- PostgreSQL 16
- Docker Compose

## 📋 Prerequisites

- Java 17 or higher
- Node.js 18+ and npm
- Docker and Docker Compose
- Maven 3.6+

## 🚀 Getting Started

### 1. Clone the Repository

```bash
cd /Users/ryanreabel/workspace-2026/reabo-lingo/1.0-java-vue
```

### 2. Start PostgreSQL Database

```bash
docker-compose up -d
```

This will:
- Start PostgreSQL on port 5432
- Create the `reabolingo` database
- Load sample data (languages, lessons, questions)

### 3. Start the Backend

```bash
cd backend
./mvnw spring-boot:run
```

The backend will be available at `http://localhost:8080`

### 4. Start the Frontend

```bash
cd frontend
npm install
npm run dev
```

The frontend will be available at `http://localhost:5173`

## 📁 Project Structure

```
reabolingo/
├── backend/                    # Spring Boot backend
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/reabolingo/app/
│   │   │   │   ├── config/    # Configuration classes
│   │   │   │   ├── controller/# REST controllers
│   │   │   │   ├── model/     # JPA entities
│   │   │   │   └── repository/# Data repositories
│   │   │   └── resources/
│   │   │       └── application.properties
│   │   └── test/
│   └── pom.xml
│
├── frontend/                   # Vue.js frontend
│   ├── src/
│   │   ├── components/        # Reusable components
│   │   ├── views/            # Page components
│   │   ├── router/           # Vue Router config
│   │   ├── services/         # API services
│   │   ├── stores/           # Pinia stores
│   │   ├── App.vue
│   │   └── main.js
│   ├── index.html
│   ├── vite.config.js
│   └── package.json
│
├── docker-compose.yml          # PostgreSQL setup
├── init.sql                   # Sample data
└── README.md
```

## 🌐 API Endpoints

### Languages
- `GET /api/languages` - Get all active languages
- `GET /api/languages/{id}` - Get language by ID
- `POST /api/languages` - Create new language

### Lessons
- `GET /api/lessons` - Get all lessons
- `GET /api/lessons/{id}` - Get lesson by ID
- `GET /api/lessons/language/{languageId}` - Get lessons for a language
- `POST /api/lessons` - Create new lesson

### Questions
- `GET /api/questions/lesson/{lessonId}` - Get questions for a lesson
- `GET /api/questions/{id}` - Get question by ID
- `POST /api/questions` - Create new question

### Users
- `GET /api/users` - Get all users
- `GET /api/users/{id}` - Get user by ID
- `POST /api/users` - Create new user
- `PUT /api/users/{id}` - Update user

### Progress
- `GET /api/progress/user/{userId}` - Get user progress
- `GET /api/progress/user/{userId}/completed` - Get completed lessons
- `POST /api/progress` - Create progress entry
- `PUT /api/progress/{id}` - Update progress

## 🗄️ Database Schema

### Main Tables
- **users**: User accounts with streaks and XP
- **languages**: Available languages to learn
- **lessons**: Lessons organized by language and level
- **questions**: Questions with multiple types (translate, multiple_choice, fill_blank)
- **user_progress**: Tracks user completion and scores

## 🎮 Usage

1. **Home Page**: Welcome screen with feature highlights
2. **Languages**: Choose a language to learn
3. **Lessons**: View available lessons in a path format
4. **Lesson Play**: Complete questions and earn XP
5. **Profile**: View stats, streaks, and achievements

## 🔧 Configuration

### Backend Configuration
Edit `backend/src/main/resources/application.properties`:

```properties
server.port=8080
spring.datasource.url=jdbc:postgresql://localhost:5432/reabolingo
spring.datasource.username=postgres
spring.datasource.password=postgres
```

### Frontend Configuration
Edit `frontend/vite.config.js` for proxy settings and port configuration.

## 🐳 Docker Commands

```bash
# Start database
docker-compose up -d

# Stop database
docker-compose down

# View logs
docker-compose logs -f

# Restart database
docker-compose restart
```

## 📝 Sample Data

The project includes sample data for:
- 5 languages (Spanish, French, German, Japanese, Italian)
- Multiple lessons for Spanish
- Questions for greeting and number lessons

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 License

This project is for educational purposes.

## 🙏 Acknowledgments

- Inspired by Duolingo's gamified learning approach
- Built with modern web technologies

## 📞 Support

For issues and questions, please open a GitHub issue.

---

**Happy Learning! 🦉📚**
