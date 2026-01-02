<template>
  <div class="lessons-page">
    <header class="header">
      <div class="container">
        <router-link to="/languages" class="back-link">← Back</router-link>
        <div class="stats">
          <span class="stat">🔥 {{ userStore.currentStreak }} day streak</span>
          <span class="stat">⭐ {{ userStore.totalXp }} XP</span>
        </div>
      </div>
    </header>

    <main class="container">
      <h1 class="page-title">Lessons</h1>
      
      <div v-if="loading" class="loading">Loading lessons...</div>
      
      <div v-else class="lesson-path">
        <div 
          v-for="lesson in lessons" 
          :key="lesson.id"
          class="lesson-node"
          @click="startLesson(lesson.id)"
        >
          <div class="lesson-circle">
            <span class="lesson-level">{{ lesson.level }}</span>
          </div>
          <div class="lesson-info">
            <h3>{{ lesson.title }}</h3>
            <p>{{ lesson.description }}</p>
            <span class="xp-badge">+{{ lesson.xpReward }} XP</span>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { lessonService } from '../services/api'
import { useUserStore } from '../stores/user'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const lessons = ref([])
const loading = ref(true)

onMounted(() => {
  userStore.loadUser()
})

onMounted(async () => {
  const languageId = route.params.languageId
  try {
    const response = await lessonService.getLessonsByLanguage(languageId)
    lessons.value = response.data
  } catch (error) {
    console.error('Error loading lessons:', error)
  } finally {
    loading.value = false
  }
})

function startLesson(lessonId) {
  router.push(`/lesson/${lessonId}`)
}
</script>

<style scoped>
.lessons-page {
  min-height: 100vh;
  background: var(--bg-gray);
}

.header {
  background: white;
  border-bottom: 2px solid var(--border-gray);
  padding: 16px 0;
}

.header .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.back-link {
  color: var(--text-dark);
  text-decoration: none;
  font-weight: 600;
}

.back-link:hover {
  color: var(--primary-color);
}

.stats {
  display: flex;
  gap: 24px;
}

.stat {
  font-weight: 600;
  color: var(--text-dark);
}

.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 24px;
}

.page-title {
  font-size: 36px;
  margin-bottom: 40px;
  text-align: center;
}

.loading {
  text-align: center;
  font-size: 18px;
  color: var(--text-light);
}

.lesson-path {
  display: flex;
  flex-direction: column;
  gap: 40px;
  align-items: center;
}

.lesson-node {
  display: flex;
  align-items: center;
  gap: 24px;
  cursor: pointer;
  transition: transform 0.2s;
}

.lesson-node:hover {
  transform: scale(1.05);
}

.lesson-circle {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: var(--primary-color);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  font-weight: bold;
  color: white;
  flex-shrink: 0;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.lesson-info {
  background: white;
  padding: 20px;
  border-radius: 12px;
  border: 2px solid var(--border-gray);
  flex: 1;
}

.lesson-info h3 {
  font-size: 20px;
  margin-bottom: 8px;
  color: var(--text-dark);
}

.lesson-info p {
  color: var(--text-light);
  margin-bottom: 8px;
}

.xp-badge {
  display: inline-block;
  background: var(--primary-color);
  color: white;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 600;
}
</style>
