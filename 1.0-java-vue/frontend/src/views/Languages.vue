<template>
  <div class="languages-page">
    <header class="header">
      <div class="container">
        <router-link to="/" class="logo">🦉 ReaboLingo</router-link>
      </div>
    </header>

    <main class="container">
      <section class="welcome-panel">
        <div>
          <h1 class="page-title">Choose a language to learn</h1>
          <p class="welcome-copy">Pick a course and meet lesson scenes filled with useful words, people, and everyday objects.</p>
        </div>
        <div class="welcome-icons" aria-hidden="true">
          <span>🧑‍🤝‍🧑</span>
          <span>🧳</span>
          <span>🍎</span>
          <span>🎨</span>
        </div>
      </section>
      
      <div v-if="loading" class="loading">Loading languages...</div>
      
      <div v-else class="language-grid">
        <div 
          v-for="language in languages" 
          :key="language.id"
          class="language-card"
          @click="selectLanguage(language.id)"
        >
          <div class="language-flag">{{ language.flagEmoji }}</div>
          <div class="language-scene" aria-hidden="true">{{ getLanguageIllustration(language.code) }}</div>
          <h3>{{ language.name }}</h3>
          <p>{{ language.description }}</p>
          <span v-if="language.code === 'fr'" class="new-badge">Expanded French</span>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { languageService } from '../services/api'

const router = useRouter()
const languages = ref([])
const loading = ref(true)

onMounted(async () => {
  try {
    const response = await languageService.getAllLanguages()
    languages.value = response.data
  } catch (error) {
    console.error('Error loading languages:', error)
  } finally {
    loading.value = false
  }
})

function selectLanguage(languageId) {
  router.push(`/lessons/${languageId}`)
}

function getLanguageIllustration(code) {
  const byCode = {
    fr: '🥖☕🚆',
    es: '👋🌮🎸',
    de: '🧑‍💼🥨🚲',
    ja: '🍣🚄🗾',
    it: '🍝🎭☀️',
    ru: '📚❄️🏙️',
    nl: '🚲🌷🧀',
    pt: '🏖️⚽☕'
  }

  return byCode[code] || '🗣️📘✨'
}
</script>

<style scoped>
.languages-page {
  min-height: 100vh;
  background:
    radial-gradient(circle at 8% 10%, rgba(255, 183, 77, 0.2), transparent 30%),
    radial-gradient(circle at 92% 18%, rgba(66, 165, 245, 0.14), transparent 28%),
    var(--bg-gray);
}

.header {
  background: white;
  border-bottom: 2px solid var(--border-gray);
  padding: 16px 0;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  color: var(--primary-color);
  text-decoration: none;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 24px;
}

.welcome-panel {
  display: flex;
  justify-content: space-between;
  gap: 20px;
  align-items: center;
  background: white;
  border: 2px solid var(--border-gray);
  border-radius: 20px;
  padding: 22px;
  margin-bottom: 28px;
  box-shadow: 0 14px 28px rgba(13, 38, 76, 0.06);
}

.page-title {
  font-size: 36px;
  margin-bottom: 6px;
}

.welcome-copy {
  color: var(--text-light);
  line-height: 1.5;
}

.welcome-icons {
  display: flex;
  gap: 8px;
  font-size: 32px;
}

.loading {
  text-align: center;
  font-size: 18px;
  color: var(--text-light);
}

.language-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 24px;
}

.language-card {
  background: white;
  border: 2px solid var(--border-gray);
  border-radius: 16px;
  padding: 32px;
  text-align: center;
  cursor: pointer;
  transition: all 0.2s;
  position: relative;
}

.language-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  border-color: var(--primary-color);
}

.language-flag {
  font-size: 64px;
  margin-bottom: 8px;
}

.language-scene {
  font-size: 22px;
  margin-bottom: 12px;
}

.language-card h3 {
  font-size: 24px;
  margin-bottom: 8px;
  color: var(--text-dark);
}

.language-card p {
  color: var(--text-light);
  line-height: 1.5;
}

.new-badge {
  display: inline-block;
  margin-top: 12px;
  background: #e3fafc;
  border: 1px solid #99e9f2;
  color: #0c8599;
  border-radius: 999px;
  padding: 6px 10px;
  font-size: 12px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.03em;
}

@media (max-width: 768px) {
  .welcome-panel {
    flex-direction: column;
    align-items: flex-start;
  }

  .page-title {
    font-size: 30px;
  }

  .welcome-icons {
    font-size: 26px;
  }
}
</style>
