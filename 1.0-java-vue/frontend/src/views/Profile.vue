<template>
  <div class="profile-page">
    <header class="header">
      <div class="container">
        <router-link to="/" class="logo">🦉 ReaboLingo</router-link>
      </div>
    </header>

    <main class="container">
      <div class="profile-card">
        <div class="avatar">👤</div>
        <h1>{{ userStore.displayName }}</h1>
        
        <div class="stats-grid">
          <div class="stat-box">
            <div class="stat-icon">🔥</div>
            <div class="stat-value">{{ userStore.currentStreak }}</div>
            <div class="stat-label">Day Streak</div>
          </div>
          
          <div class="stat-box">
            <div class="stat-icon">⭐</div>
            <div class="stat-value">{{ userStore.totalXp }}</div>
            <div class="stat-label">Total XP</div>
          </div>
          
          <div class="stat-box">
            <div class="stat-icon">✅</div>
            <div class="stat-value">{{ completedLessonsCount }}</div>
            <div class="stat-label">Lessons Completed</div>
          </div>
        </div>

        <router-link to="/languages">
          <button class="primary">Continue Learning</button>
        </router-link>
      </div>
    </main>
  </div>
</template>

<script setup>
import { onMounted, computed } from 'vue'
import { useUserStore } from '../stores/user'

const userStore = useUserStore()

onMounted(() => {
  userStore.loadUser()
})

const completedLessonsCount = computed(() => userStore.completedLessons.length)
</script>

<style scoped>
.profile-page {
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
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 24px;
}

.profile-card {
  background: white;
  border-radius: 16px;
  padding: 48px;
  text-align: center;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  background: var(--bg-gray);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 64px;
  margin: 0 auto 24px;
}

.profile-card h1 {
  font-size: 32px;
  margin-bottom: 40px;
  color: var(--text-dark);
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 24px;
  margin-bottom: 40px;
}

.stat-box {
  padding: 24px;
  background: var(--bg-gray);
  border-radius: 12px;
}

.stat-icon {
  font-size: 32px;
  margin-bottom: 8px;
}

.stat-value {
  font-size: 32px;
  font-weight: bold;
  color: var(--text-dark);
  margin-bottom: 4px;
}

.stat-label {
  font-size: 14px;
  color: var(--text-light);
}

button {
  min-width: 200px;
}
</style>
