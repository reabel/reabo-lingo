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
        <div class="lesson-scene" :style="{ background: visualTheme.background }" aria-hidden="true">
          <img :src="visualTheme.image" class="scene-art" alt="">
          <p class="scene-text">{{ lessonTitle || 'Practice lesson' }}</p>
        </div>

        <h2 class="question-prompt">{{ currentQuestion.prompt }}</h2>

        <p v-if="currentQuestion.phonetic" class="pronunciation-tip">
          Pronunciation tip: {{ currentQuestion.phonetic }}
        </p>

        <div v-if="currentQuestion.imageUrl" class="question-image">
          <img :src="currentQuestion.imageUrl" alt="Question visual">
        </div>

        <div class="answer-area">
          <input
            v-if="currentQuestion.questionType === 'translate' || currentQuestion.questionType === 'fill_blank'"
            v-model="userAnswer"
            type="text"
            :placeholder="currentQuestion.phonetic ? `Type your answer... (${currentQuestion.phonetic})` : 'Type your answer...'"
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
              <div class="option-content">
                <span class="option-text">{{ option }}</span>
                <span v-if="optionPhonetics[index]" class="option-phonetic">{{ optionPhonetics[index] }}</span>
              </div>
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
            <p v-if="isCorrect && acceptedVariant" class="accepted-variant-note">
              Accepted variant: nice answer. Accents and punctuation are flexible in this mode.
            </p>
            <p v-if="!isCorrect" class="correct-answer-display">
              <span>Correct answer: {{ currentQuestion.correctAnswer }}</span>
              <span v-if="currentQuestion.phonetic" class="phonetic-text">({{ currentQuestion.phonetic }})</span>
            </p>
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
import { questionService, lessonService } from '../services/api'
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
const questions = ref([])
const currentIndex = ref(0)
const userAnswer = ref('')
const showResult = ref(false)
const isCorrect = ref(false)
const acceptedVariant = ref(false)
const loading = ref(true)
const sessionXp = ref(0)
const lessonTitle = ref('')

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

const optionPhonetics = computed(() => {
  return []
})

const visualTheme = computed(() => {
  const source = normalizeForMatch(`${lessonTitle.value} ${currentQuestion.value?.prompt || ''}`)

  if (source.includes('salut') || source.includes('hello') || source.includes('good')) {
    return { image: greetingsArt, background: 'linear-gradient(135deg, #e3f5ff 0%, #fff8db 100%)' }
  }
  if (source.includes('nombre') || source.includes('number')) {
    return { image: numbersArt, background: 'linear-gradient(135deg, #d3f9d8 0%, #e7f5ff 100%)' }
  }
  if (source.includes('nourriture') || source.includes('food') || source.includes('cafe') || source.includes('bread') || source.includes('coffee')) {
    return { image: foodArt, background: 'linear-gradient(135deg, #ffe8cc 0%, #fff3bf 100%)' }
  }
  if (source.includes('couleur') || source.includes('color')) {
    return { image: colorsArt, background: 'linear-gradient(135deg, #f3d9fa 0%, #ffd8e8 100%)' }
  }
  if (source.includes('famille') || source.includes('family')) {
    return { image: familyArt, background: 'linear-gradient(135deg, #ffe3e3 0%, #f8f0fc 100%)' }
  }
  if (source.includes('voyage') || source.includes('train') || source.includes('airport') || source.includes('metro')) {
    return { image: travelArt, background: 'linear-gradient(135deg, #d0ebff 0%, #e3fafc 100%)' }
  }
  if (source.includes('verbe') || source.includes('verb')) {
    return { image: verbsArt, background: 'linear-gradient(135deg, #e9fac8 0%, #d3f9d8 100%)' }
  }

  return { image: practiceArt, background: 'linear-gradient(135deg, #e7f5ff 0%, #fff0f6 100%)' }
})

onMounted(async () => {
  const lessonId = route.params.lessonId
  try {
    const [questionResponse, lessonResponse] = await Promise.all([
      questionService.getQuestionsByLesson(lessonId),
      lessonService.getLessonById(lessonId)
    ])
    questions.value = questionResponse.data
    lessonTitle.value = lessonResponse.data?.title || ''
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

  const normalizedUserAnswer = normalizeAnswer(userAnswer.value)
  const normalizedCorrectAnswer = normalizeAnswer(currentQuestion.value.correctAnswer)
  const strictMatch = userAnswer.value.toLowerCase().trim() === currentQuestion.value.correctAnswer.toLowerCase().trim()
  isCorrect.value = normalizedUserAnswer === normalizedCorrectAnswer
  acceptedVariant.value = isCorrect.value && !strictMatch
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
    acceptedVariant.value = false
  } else {
    currentIndex.value = questions.value.length
    const lessonId = route.params.lessonId
    userStore.completeLesson(parseInt(lessonId))
  }
}

function goBack() {
  router.go(-1)
}

function normalizeForMatch(text) {
  return text
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
}

function normalizeAnswer(text) {
  return normalizeForMatch(text)
    .replace(/œ/g, 'oe')
    .replace(/æ/g, 'ae')
    .replace(/[’']/g, ' ')
    .replace(/[^\p{L}\p{N}\s]/gu, ' ')
    .replace(/\s+/g, ' ')
    .trim()
}
</script>

<style scoped>
.lesson-play {
  min-height: 100vh;
  background:
    radial-gradient(circle at 12% 10%, rgba(255, 183, 77, 0.16), transparent 28%),
    radial-gradient(circle at 88% 16%, rgba(66, 165, 245, 0.14), transparent 30%),
    white;
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
  gap: 20px;
}

.lesson-scene {
  border: 2px solid var(--border-gray);
  border-radius: 16px;
  padding: 14px 16px;
  display: grid;
  grid-template-columns: auto 1fr;
  align-items: center;
  gap: 10px;
}

.scene-art {
  width: 118px;
  height: 74px;
  object-fit: cover;
  border-radius: 10px;
  border: 1px solid rgba(76, 108, 143, 0.2);
}

.scene-text {
  justify-self: end;
  padding: 6px 10px;
  background: rgba(255, 255, 255, 0.8);
  border-radius: 999px;
  font-size: 13px;
  font-weight: 700;
  color: #375a7f;
}

.question-prompt {
  font-size: 32px;
  text-align: center;
  color: var(--text-dark);
}

.pronunciation-tip {
  text-align: center;
  color: #285f96;
  font-weight: 700;
  background: #e7f5ff;
  border: 1px solid #a5d8ff;
  border-radius: 12px;
  padding: 10px 14px;
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

.accepted-variant-note {
  color: #0b7285;
  background: #e3fafc;
  border: 1px solid #99e9f2;
  border-radius: 10px;
  padding: 10px 12px;
}

.correct-answer-display {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.phonetic-text {
  font-size: 16px;
  color: var(--text-light);
  font-style: italic;
}

.option-content {
  display: flex;
  flex-direction: column;
  gap: 4px;
  align-items: center;
}

.option-text {
  font-size: 18px;
}

.option-phonetic {
  font-size: 14px;
  color: var(--text-light);
  font-style: italic;
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

@media (max-width: 768px) {
  .question-prompt {
    font-size: 24px;
  }

  .lesson-scene {
    grid-template-columns: auto;
  }

  .scene-text {
    justify-self: start;
    grid-column: auto;
  }
}
</style>
