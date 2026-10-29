<template>
  <div id="app">
    <router-view />
    <button
      class="theme-toggle"
      type="button"
      :aria-label="isDarkMode ? 'Switch to light mode' : 'Switch to dark mode'"
      @click="toggleTheme"
    >
      {{ isDarkMode ? '☀️ Light mode' : '🌙 Dark mode' }}
    </button>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const themeStorageKey = 'reabolingo-theme'
const isDarkMode = ref(localStorage.getItem(themeStorageKey) !== 'light')

document.documentElement.dataset.theme = isDarkMode.value ? 'dark' : 'light'

function toggleTheme() {
  isDarkMode.value = !isDarkMode.value
  const theme = isDarkMode.value ? 'dark' : 'light'
  document.documentElement.dataset.theme = theme
  localStorage.setItem(themeStorageKey, theme)
}
</script>

<style scoped>
#app {
  min-height: 100vh;
}

.theme-toggle {
  position: fixed;
  right: 20px;
  bottom: 20px;
  z-index: 999;
  padding: 10px 16px;
  background: var(--surface-color);
  color: var(--text-dark);
  border: 2px solid var(--border-gray);
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.2);
}

.theme-toggle:hover {
  background: var(--bg-gray);
}
</style>
