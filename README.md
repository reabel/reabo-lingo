# reabo-lingo
A duolingo inspired app to help learn new languages (if they can use AI why can't I?)

## Quickstart

### Prerequisites
- Java 21+
- Maven
- Node.js 18+
- Docker

### 1. Start the database

```bash
cd 1.0-java-vue
docker compose up -d
```

### 2. Start the backend

```bash
cd 1.0-java-vue/backend
mvn spring-boot:run
```

The API will be available at `http://localhost:8080`.

### 3. Start the frontend

```bash
cd 1.0-java-vue/frontend
npm install
npm run dev
```

The app will be available at `http://localhost:5173`.
