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
      <section class="page-hero" v-if="language">
        <div class="hero-copy">
          <p class="hero-kicker">Your next adventure</p>
          <h1 class="page-title">{{ language.flagEmoji }} {{ language.name }} lessons</h1>
          <p class="hero-subtitle">Choose a lesson with visuals inspired by the words you will learn.</p>
        </div>
        <div class="hero-scene" aria-hidden="true">
          <img :src="greetingsArt" class="hero-art" alt="">
          <img :src="travelArt" class="hero-art" alt="">
          <img :src="foodArt" class="hero-art" alt="">
        </div>
      </section>

      <div v-if="loading" class="loading">Loading lessons...</div>

      <div v-else class="lesson-path">
        <div
          v-for="lesson in lessons"
          :key="lesson.id"
          class="lesson-node"
          @click="startLesson(lesson.id)"
        >
          <div class="lesson-circle" :style="{ background: getLessonVisual(lesson).badgeColor }">
            <span class="lesson-level">{{ lesson.level }}</span>
          </div>
          <div class="lesson-info">
            <div class="lesson-illustration" :style="{ background: getLessonVisual(lesson).background }" aria-hidden="true">
              <img :src="getLessonVisual(lesson).image" class="scene-art" alt="">
              <span class="scene-caption">{{ getLessonVisual(lesson).caption }}</span>
            </div>
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
import { lessonService, languageService } from '../services/api'
import { useUserStore } from '../stores/user'
import greetingsArt from '../assets/illustrations/greetings.svg'
import numbersArt from '../assets/illustrations/numbers.svg'
import foodArt from '../assets/illustrations/food.svg'
import colorsArt from '../assets/illustrations/colors.svg'
import familyArt from '../assets/illustrations/family.svg'
import travelArt from '../assets/illustrations/travel.svg'
import verbsArt from '../assets/illustrations/verbs.svg'
import practiceArt from '../assets/illustrations/practice.svg'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const lessons = ref([])
const language = ref(null)
const loading = ref(true)

onMounted(() => {
  userStore.loadUser()
})

onMounted(async () => {
  const languageId = route.params.languageId
  try {
    const [lessonsResponse, languageResponse] = await Promise.all([
      lessonService.getLessonsByLanguage(languageId),
      languageService.getLanguageById(languageId)
    ])
    lessons.value = lessonsResponse.data
    language.value = languageResponse.data
  } catch (error) {
    console.error('Error loading lessons:', error)
  } finally {
    loading.value = false
  }
})

function startLesson(lessonId) {
  router.push(`/lesson/${lessonId}`)
}

function getLessonVisual(lesson) {
  const topic = normalizeForMatch(`${lesson.title} ${lesson.description}`)

  if (topic.includes('salut') || topic.includes('greet') || topic.includes('grusse')) {
    return {
      image: greetingsArt,
      caption: 'Greetings',
      background: 'linear-gradient(135deg, #e3f5ff 0%, #fff3cf 100%)',
      badgeColor: '#ff8f4c'
    }
  }

  if (topic.includes('nombre') || topic.includes('number') || topic.includes('zahl') || topic.includes('numer')) {
    return {
      image: numbersArt,
      caption: 'Numbers',
      background: 'linear-gradient(135deg, #dff8eb 0%, #e6f3ff 100%)',
      badgeColor: '#2f9e44'
    }
  }

  if (topic.includes('nourriture') || topic.includes('food') || topic.includes('cibo') || topic.includes('cafe') || topic.includes('comida')) {
    return {
      image: foodArt,
      caption: 'Food',
      background: 'linear-gradient(135deg, #ffe8cc 0%, #fff7e6 100%)',
      badgeColor: '#d9480f'
    }
  }

  if (topic.includes('couleur') || topic.includes('color') || topic.includes('farbe') || topic.includes('cores')) {
    return {
      image: colorsArt,
      caption: 'Colors',
      background: 'linear-gradient(135deg, #e5dbff 0%, #ffd8e8 100%)',
      badgeColor: '#7048e8'
    }
  }

  if (topic.includes('famille') || topic.includes('family') || topic.includes('familie') || topic.includes('familia')) {
    return {
      image: familyArt,
      caption: 'Family',
      background: 'linear-gradient(135deg, #ffe3e3 0%, #f8f0fc 100%)',
      badgeColor: '#e64980'
    }
  }

  if (topic.includes('voyage') || topic.includes('travel') || topic.includes('metro')) {
    return {
      image: travelArt,
      caption: 'Travel',
      background: 'linear-gradient(135deg, #d0ebff 0%, #e3fafc 100%)',
      badgeColor: '#1971c2'
    }
  }

  if (topic.includes('verbe') || topic.includes('verb') || topic.includes('quotidien')) {
    return {
      image: verbsArt,
      caption: 'Daily Actions',
      background: 'linear-gradient(135deg, #e9fac8 0%, #d3f9d8 100%)',
      badgeColor: '#5c940d'
    }
  }

  return {
    image: practiceArt,
    caption: 'Practice',
    background: 'linear-gradient(135deg, #e7f5ff 0%, #fff0f6 100%)',
    badgeColor: '#1c7ed6'
  }
}

function normalizeForMatch(text) {
  return text
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
}
</script>

<style scoped>
.lessons-page {
  min-height: 100vh;
  background:
    radial-gradient(circle at 5% 15%, rgba(255, 183, 77, 0.2), transparent 32%),
    radial-gradient(circle at 95% 25%, rgba(66, 165, 245, 0.18), transparent 30%),
    var(--bg-gray);
}

.header {
  background: rgba(255, 255, 255, 0.92);
  border-bottom: 2px solid var(--border-gray);
  padding: 16px 0;
  backdrop-filter: blur(8px);
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

.page-hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  background: white;
  border: 2px solid var(--border-gray);
  border-radius: 20px;
  padding: 20px;
  margin-bottom: 28px;
  box-shadow: 0 12px 28px rgba(13, 38, 76, 0.07);
}

.hero-kicker {
  color: #2b8a3e;
  font-weight: 700;
  letter-spacing: 0.04em;
  text-transform: uppercase;
  font-size: 12px;
  margin-bottom: 6px;
}

.page-title {
  font-size: 34px;
  margin-bottom: 8px;
  color: var(--text-dark);
}

.hero-subtitle {
  color: var(--text-light);
  line-height: 1.5;
}

.hero-scene {
  display: flex;
  gap: 8px;
}

.hero-art {
  width: 110px;
  height: 74px;
  border-radius: 12px;
  border: 1px solid rgba(76, 108, 143, 0.24);
  object-fit: cover;
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
  align-items: stretch;
  gap: 24px;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}

.lesson-node:hover {
  transform: translateY(-3px);
}

.lesson-circle {
  width: 80px;
  height: 80px;
  border-radius: 50%;
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
  border-radius: 16px;
  border: 2px solid var(--border-gray);
  flex: 1;
  box-shadow: 0 8px 20px rgba(13, 38, 76, 0.05);
}

.lesson-illustration {
  min-height: 90px;
  border-radius: 14px;
  margin-bottom: 14px;
  padding: 12px 14px;
  display: grid;
  grid-template-columns: 1fr auto;
  align-items: center;
  gap: 10px;
}

.scene-art {
  width: 180px;
  max-width: 100%;
  height: 74px;
  object-fit: cover;
  border-radius: 10px;
  border: 1px solid rgba(76, 108, 143, 0.2);
}

.scene-caption {
  justify-self: end;
  background: rgba(255, 255, 255, 0.82);
  border-radius: 999px;
  padding: 6px 10px;
  font-size: 12px;
  font-weight: 700;
  color: #4c6c8f;
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
  background: #1c7ed6;
  color: white;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 600;
}

@media (max-width: 768px) {
  .page-hero {
    flex-direction: column;
    align-items: flex-start;
  }

  .hero-scene {
    flex-wrap: wrap;
  }

  .hero-art {
    width: 92px;
    height: 64px;
  }

  .lesson-node {
    gap: 14px;
  }

  .lesson-circle {
    width: 60px;
    height: 60px;
    font-size: 18px;
  }

  .page-title {
    font-size: 28px;
  }
}
</style>
