<template>
  <div class="languages-page">
    <header class="header">
      <div class="container">
        <router-link to="/" class="logo">🦉 ReaboLingo</router-link>
      </div>
    </header>

    <main class="container">
      <h1 class="page-title">Choose a language to learn</h1>
      
      <div v-if="loading" class="loading">Loading languages...</div>
      
      <div v-else class="language-grid">
        <div 
          v-for="language in languages" 
          :key="language.id"
          class="language-card"
          @click="selectLanguage(language.id)"
        >
          <div class="language-flag">{{ language.flagEmoji }}</div>
          <h3>{{ language.name }}</h3>
          <p>{{ language.description }}</p>
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
</script>

<style scoped>
.languages-page {
  min-height: 100vh;
  background: var(--bg-gray);
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
}

.language-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  border-color: var(--primary-color);
}

.language-flag {
  font-size: 64px;
  margin-bottom: 16px;
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
</style>
