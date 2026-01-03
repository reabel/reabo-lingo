<template>
  <div class="admin-page">
    <header class="admin-header">
      <div class="container">
        <router-link to="/admin" class="logo">🦉 ReaboLingo Admin</router-link>
        <nav class="admin-nav">
          <router-link to="/admin/languages" class="nav-link">Languages</router-link>
          <router-link to="/admin/lessons" class="nav-link">Lessons</router-link>
          <router-link to="/admin/questions" class="nav-link">Questions</router-link>
          <router-link to="/" class="nav-link">← Exit Admin</router-link>
        </nav>
      </div>
    </header>

    <main class="container">
      <div class="admin-section">
        <div class="section-header">
          <h1>Manage Questions</h1>
          <button @click="showCreateForm = true" class="primary">+ Add New Question</button>
        </div>

        <div class="filter-bar">
          <select v-model="filterLessonId" @change="applyFilter">
            <option value="">All Lessons</option>
            <option v-for="lesson in lessons" :key="lesson.id" :value="lesson.id">
              {{ lesson.language?.name }} - {{ lesson.title }}
            </option>
          </select>
        </div>

        <div v-if="loading" class="loading">Loading questions...</div>

        <div v-else class="questions-list">
          <div v-for="question in filteredQuestions" :key="question.id" class="question-card">
            <div class="question-header">
              <div class="question-meta">
                <span class="question-id">#{{ question.id }}</span>
                <span class="question-type">{{ question.questionType }}</span>
                <span class="lesson-badge">{{ question.lesson?.title || 'No Lesson' }}</span>
              </div>
              <div class="question-actions">
                <button @click="editQuestion(question)" class="btn-edit">Edit</button>
                <button @click="deleteQuestion(question.id)" class="btn-delete">Delete</button>
              </div>
            </div>
            <div class="question-content">
              <p class="question-prompt">{{ question.prompt }}</p>
              <p class="question-answer"><strong>Answer:</strong> {{ question.correctAnswer }}</p>
              <p v-if="question.options" class="question-options">
                <strong>Options:</strong> {{ question.options }}
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Create/Edit Form Modal -->
      <div v-if="showCreateForm || editingQuestion" class="modal" @click.self="closeForm">
        <div class="modal-content">
          <h2>{{ editingQuestion ? 'Edit Question' : 'Create New Question' }}</h2>
          
          <form @submit.prevent="saveQuestion">
            <div class="form-group">
              <label>Lesson *</label>
              <select v-model="form.lessonId" required>
                <option value="">Select a lesson</option>
                <option v-for="lesson in lessons" :key="lesson.id" :value="lesson.id">
                  {{ lesson.language?.name }} - {{ lesson.title }}
                </option>
              </select>
            </div>

            <div class="form-group">
              <label>Question Prompt *</label>
              <textarea v-model="form.prompt" required placeholder="What is your question?"></textarea>
            </div>

            <div class="form-group">
              <label>Question Type *</label>
              <select v-model="form.questionType" required>
                <option value="translate">Translate</option>
                <option value="multiple_choice">Multiple Choice</option>
                <option value="fill_blank">Fill in the Blank</option>
              </select>
            </div>

            <div class="form-group">
              <label>Correct Answer *</label>
              <input v-model="form.correctAnswer" type="text" required placeholder="The correct answer">
            </div>

            <div v-if="form.questionType === 'multiple_choice'" class="form-group">
              <label>Options (JSON array) *</label>
              <textarea 
                v-model="form.options" 
                placeholder='["Option 1", "Option 2", "Option 3", "Option 4"]'
              ></textarea>
              <small>Format: ["option1", "option2", "option3", "option4"]</small>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label>Order Index *</label>
                <input v-model.number="form.orderIndex" type="number" min="1" required>
              </div>

              <div class="form-group">
                <label>Image URL</label>
                <input v-model="form.imageUrl" type="text" placeholder="Optional image URL">
              </div>

              <div class="form-group">
                <label>Audio URL</label>
                <input v-model="form.audioUrl" type="text" placeholder="Optional audio URL">
              </div>
            </div>

            <div class="form-actions">
              <button type="button" @click="closeForm" class="secondary">Cancel</button>
              <button type="submit" class="primary">{{ editingQuestion ? 'Update' : 'Create' }}</button>
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { adminService } from '../services/api'

const questions = ref([])
const lessons = ref([])
const loading = ref(true)
const showCreateForm = ref(false)
const editingQuestion = ref(null)
const filterLessonId = ref('')

const form = ref({
  lessonId: '',
  prompt: '',
  questionType: 'translate',
  correctAnswer: '',
  options: '',
  imageUrl: '',
  audioUrl: '',
  orderIndex: 1
})

const filteredQuestions = computed(() => {
  if (!filterLessonId.value) return questions.value
  return questions.value.filter(q => q.lesson?.id === parseInt(filterLessonId.value))
})

onMounted(async () => {
  await loadQuestions()
  await loadLessons()
})

async function loadQuestions() {
  try {
    loading.value = true
    const response = await adminService.getAllQuestions()
    questions.value = response.data
  } catch (error) {
    console.error('Error loading questions:', error)
    alert('Failed to load questions')
  } finally {
    loading.value = false
  }
}

async function loadLessons() {
  try {
    const response = await adminService.getAllLessons()
    lessons.value = response.data
  } catch (error) {
    console.error('Error loading lessons:', error)
  }
}

function applyFilter() {
  // Filtering is handled by computed property
}

function editQuestion(question) {
  editingQuestion.value = question
  form.value = {
    lessonId: question.lesson.id,
    prompt: question.prompt,
    questionType: question.questionType,
    correctAnswer: question.correctAnswer,
    options: question.options || '',
    imageUrl: question.imageUrl || '',
    audioUrl: question.audioUrl || '',
    orderIndex: question.orderIndex
  }
}

async function saveQuestion() {
  try {
    const questionData = {
      ...form.value,
      lesson: { id: form.value.lessonId },
      options: form.value.options || null
    }

    if (editingQuestion.value) {
      await adminService.updateQuestion(editingQuestion.value.id, questionData)
      alert('Question updated successfully!')
    } else {
      await adminService.createQuestion(questionData)
      alert('Question created successfully!')
    }
    
    closeForm()
    await loadQuestions()
  } catch (error) {
    console.error('Error saving question:', error)
    alert('Failed to save question: ' + (error.response?.data || error.message))
  }
}

async function deleteQuestion(id) {
  if (!confirm('Are you sure you want to delete this question?')) return
  
  try {
    await adminService.deleteQuestion(id)
    alert('Question deleted successfully!')
    await loadQuestions()
  } catch (error) {
    console.error('Error deleting question:', error)
    alert('Failed to delete question')
  }
}

function closeForm() {
  showCreateForm.value = false
  editingQuestion.value = null
  form.value = {
    lessonId: '',
    prompt: '',
    questionType: 'translate',
    correctAnswer: '',
    options: '',
    imageUrl: '',
    audioUrl: '',
    orderIndex: 1
  }
}
</script>

<style scoped>
@import './AdminStyles.css';

.filter-bar {
  margin-bottom: 24px;
}

.filter-bar select {
  padding: 12px;
  border: 2px solid var(--border-gray);
  border-radius: 8px;
  font-size: 16px;
  min-width: 300px;
}

.questions-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.question-card {
  background: white;
  border: 2px solid var(--border-gray);
  border-radius: 12px;
  padding: 20px;
  transition: all 0.2s;
}

.question-card:hover {
  border-color: var(--primary-color);
}

.question-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.question-meta {
  display: flex;
  gap: 12px;
  align-items: center;
}

.question-id {
  font-weight: 600;
  color: var(--text-light);
}

.question-type {
  background: var(--primary-color);
  color: white;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 600;
}

.lesson-badge {
  background: var(--bg-gray);
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 600;
}

.question-actions {
  display: flex;
  gap: 8px;
}

.question-content {
  padding-top: 16px;
  border-top: 1px solid var(--border-gray);
}

.question-prompt {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 12px;
  color: var(--text-dark);
}

.question-answer,
.question-options {
  margin-bottom: 8px;
  color: var(--text-light);
}

.btn-edit, .btn-delete {
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 600;
}

.btn-edit {
  background: var(--primary-color);
  color: white;
}

.btn-delete {
  background: var(--danger-color);
  color: white;
}

.form-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

small {
  display: block;
  margin-top: 4px;
  color: var(--text-light);
  font-size: 12px;
}
</style>
