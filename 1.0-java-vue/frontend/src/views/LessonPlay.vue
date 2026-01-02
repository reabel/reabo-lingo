<template>
  <div class="lesson-play">
    <header class="header">
      <div class="container">
        <button @click="goBack" class="exit-btn">✕</button>
        <div class="progress-bar">
          <div 
            class="progress-fill" 
            :style="{ width: progressPercent + '%' }"
          ></div>
        </div>
      </div>
    </header>

    <main class="container">
      <div v-if="loading" class="loading">Loading question...</div>
      
      <div v-else-if="currentQuestion" class="question-container">
        <h2 class="question-prompt">{{ currentQuestion.prompt }}</h2>
        
        <div v-if="currentQuestion.imageUrl" class="question-image">
          <img :src="currentQuestion.imageUrl" alt="Question visual">
        </div>

        <div class="answer-area">
          <input 
            v-if="currentQuestion.questionType === 'translate' || currentQuestion.questionType === 'fill_blank'"
            v-model="userAnswer"
            type="text"
            placeholder="Type your answer..."
            @keyup.enter="checkAnswer"
            class="answer-input"
          />

          <div 
            v-if="currentQuestion.questionType === 'multiple_choice'"
            class="options-grid"
          >
            <button
              v-for="(option, index) in options"
              :key="index"
              @click="selectOption(option)"
              class="option-btn"
              :class="{ selected: userAnswer === option }"
            >
              {{ option }}
            </button>
          </div>
        </div>

        <button 
          @click="checkAnswer" 
          class="primary check-btn"
          :disabled="!userAnswer"
        >
          Check
        </button>

        <div v-if="showResult" class="result-panel" :class="isCorrect ? 'correct' : 'incorrect'">
          <div class="result-content">
            <h3>{{ isCorrect ? '🎉 Correct!' : '❌ Incorrect' }}</h3>
            <p v-if="!isCorrect">Correct answer: {{ currentQuestion.correctAnswer }}</p>
            <button @click="nextQuestion" class="primary">Continue</button>
          </div>
        </div>
      </div>

      <div v-else class="completion">
        <h2>🎉 Lesson Complete!</h2>
        <p>You earned {{ sessionXp }} XP</p>
        <p class="total-xp">Total XP: {{ userStore.totalXp }}</p>
        <button @click="goBack" class="primary">Continue</button>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { questionService } from '../services/api'
import { useUserStore } from '../stores/user'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const questions = ref([])
const currentIndex = ref(0)
const userAnswer = ref('')
const showResult = ref(false)
const isCorrect = ref(false)
const loading = ref(true)
const sessionXp = ref(0)

const currentQuestion = computed(() => questions.value[currentIndex.value])
const progressPercent = computed(() => {
  if (questions.value.length === 0) return 0
  return (currentIndex.value / questions.value.length) * 100
})

const options = computed(() => {
  if (!currentQuestion.value?.options) return []
  try {
    return JSON.parse(currentQuestion.value.options)
  } catch {
    return []
  }
})

onMounted(async () => {
  const lessonId = route.params.lessonId
  try {
    const response = await questionService.getQuestionsByLesson(lessonId)
    questions.value = response.data
  } catch (error) {
    console.error('Error loading questions:', error)
  } finally {
    loading.value = false
  }
})

function selectOption(option) {
  userAnswer.value = option
}

function checkAnswer() {
  if (!userAnswer.value) return
  
  isCorrect.value = userAnswer.value.toLowerCase().trim() === 
                    currentQuestion.value.correctAnswer.toLowerCase().trim()
  showResult.value = true
  
  if (isCorrect.value) {
    const xpEarned = 10
    sessionXp.value += xpEarned
    userStore.addXp(xpEarned)
  }
}

function nextQuestion() {
  if (currentIndex.value < questions.value.length - 1) {
    currentIndex.value++
    userAnswer.value = ''
    showResult.value = false
  } else {
    // Lesson complete
    currentIndex.value = questions.value.length
    const lessonId = route.params.lessonId
    userStore.completeLesson(parseInt(lessonId))
  }
}

function goBack() {
  router.go(-1)
}
</script>

<style scoped>
.lesson-play {
  min-height: 100vh;
  background: white;
}

.header {
  padding: 16px 0;
  border-bottom: 2px solid var(--border-gray);
}

.header .container {
  display: flex;
  align-items: center;
  gap: 16px;
}

.exit-btn {
  background: white;
  border: 2px solid var(--border-gray);
  width: 40px;
  height: 40px;
  border-radius: 50%;
  font-size: 20px;
  padding: 0;
}

.progress-bar {
  flex: 1;
  height: 16px;
  background: var(--bg-gray);
  border-radius: 8px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: var(--primary-color);
  transition: width 0.3s;
}

.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 24px;
}

.loading {
  text-align: center;
  font-size: 18px;
  color: var(--text-light);
}

.question-container {
  display: flex;
  flex-direction: column;
  gap: 32px;
}

.question-prompt {
  font-size: 32px;
  text-align: center;
  color: var(--text-dark);
}

.question-image {
  text-align: center;
}

.question-image img {
  max-width: 300px;
  border-radius: 12px;
}

.answer-area {
  min-height: 200px;
}

.answer-input {
  font-size: 20px;
}

.options-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
}

.option-btn {
  background: white;
  border: 2px solid var(--border-gray);
  padding: 20px;
  font-size: 18px;
  border-radius: 12px;
}

.option-btn:hover {
  border-color: var(--primary-color);
}

.option-btn.selected {
  border-color: var(--primary-color);
  background: rgba(88, 204, 2, 0.1);
}

.check-btn {
  width: 100%;
  font-size: 18px;
  padding: 18px;
}

.check-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.result-panel {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 32px;
  background: white;
  border-top: 4px solid;
}

.result-panel.correct {
  border-color: var(--primary-color);
  background: rgba(88, 204, 2, 0.1);
}

.result-panel.incorrect {
  border-color: var(--danger-color);
  background: rgba(255, 75, 75, 0.1);
}

.result-content {
  max-width: 800px;
  margin: 0 auto;
}

.result-content h3 {
  font-size: 28px;
  margin-bottom: 12px;
}

.result-content p {
  font-size: 18px;
  margin-bottom: 20px;
  color: var(--text-light);
}

.completion {
  text-align: center;
  padding: 60px 24px;
}

.completion h2 {
  font-size: 48px;
  margin-bottom: 24px;
}

.completion p {
  font-size: 24px;
  color: var(--text-light);
  margin-bottom: 16px;
}

.total-xp {
  font-size: 20px;
  font-weight: 600;
  color: var(--primary-color);
  margin-bottom: 32px;
}
</style>
