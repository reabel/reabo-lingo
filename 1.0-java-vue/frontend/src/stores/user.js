import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useUserStore = defineStore('user', () => {
  const currentUser = ref(null)
  const isLoggedIn = ref(false)
  const totalXp = ref(0)
  const currentStreak = ref(0)
  const completedLessons = ref([])

  const displayName = computed(() => {
    return currentUser.value?.displayName || currentUser.value?.username || 'Language Learner'
  })

  function setUser(user) {
    currentUser.value = user
    isLoggedIn.value = !!user
    if (user) {
      localStorage.setItem('currentUser', JSON.stringify(user))
    } else {
      localStorage.removeItem('currentUser')
    }
  }

  function loadUser() {
    const savedUser = localStorage.getItem('currentUser')
    if (savedUser) {
      currentUser.value = JSON.parse(savedUser)
      isLoggedIn.value = true
    }
    
    // Load XP and stats from localStorage
    const savedXp = localStorage.getItem('totalXp')
    if (savedXp) totalXp.value = parseInt(savedXp)
    
    const savedStreak = localStorage.getItem('currentStreak')
    if (savedStreak) currentStreak.value = parseInt(savedStreak)
    
    const savedLessons = localStorage.getItem('completedLessons')
    if (savedLessons) completedLessons.value = JSON.parse(savedLessons)
  }

  function addXp(amount) {
    totalXp.value += amount
    localStorage.setItem('totalXp', totalXp.value.toString())
  }

  function completeLesson(lessonId) {
    if (!completedLessons.value.includes(lessonId)) {
      completedLessons.value.push(lessonId)
      localStorage.setItem('completedLessons', JSON.stringify(completedLessons.value))
    }
  }

  function updateStreak(streak) {
    currentStreak.value = streak
    localStorage.setItem('currentStreak', streak.toString())
  }

  function logout() {
    setUser(null)
    totalXp.value = 0
    currentStreak.value = 0
    completedLessons.value = []
    localStorage.removeItem('totalXp')
    localStorage.removeItem('currentStreak')
    localStorage.removeItem('completedLessons')
  }

  return {
    currentUser,
    isLoggedIn,
    totalXp,
    currentStreak,
    completedLessons,
    displayName,
    setUser,
    loadUser,
    addXp,
    completeLesson,
    updateStreak,
    logout
  }
})
