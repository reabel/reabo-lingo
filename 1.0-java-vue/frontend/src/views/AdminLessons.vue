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
          <h1>Manage Lessons</h1>
          <button @click="showCreateForm = true" class="primary">+ Add New Lesson</button>
        </div>

        <div v-if="loading" class="loading">Loading lessons...</div>

        <div v-else class="lessons-table">
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Language</th>
                <th>Title</th>
                <th>Level</th>
                <th>Order</th>
                <th>XP</th>
                <th>Active</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="lesson in lessons" :key="lesson.id">
                <td>{{ lesson.id }}</td>
                <td>{{ lesson.language?.name || 'N/A' }}</td>
                <td>{{ lesson.title }}</td>
                <td>{{ lesson.level }}</td>
                <td>{{ lesson.orderIndex }}</td>
                <td>{{ lesson.xpReward }}</td>
                <td>
                  <span :class="['status-badge', lesson.isActive ? 'active' : 'inactive']">
                    {{ lesson.isActive ? 'Active' : 'Inactive' }}
                  </span>
                </td>
                <td class="actions">
                  <button @click="editLesson(lesson)" class="btn-edit">Edit</button>
                  <button @click="deleteLesson(lesson.id)" class="btn-delete">Delete</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Create/Edit Form Modal -->
      <div v-if="showCreateForm || editingLesson" class="modal" @click.self="closeForm">
        <div class="modal-content">
          <h2>{{ editingLesson ? 'Edit Lesson' : 'Create New Lesson' }}</h2>
          
          <form @submit.prevent="saveLesson">
            <div class="form-group">
              <label>Language *</label>
              <select v-model="form.languageId" required>
                <option value="">Select a language</option>
                <option v-for="lang in languages" :key="lang.id" :value="lang.id">
                  {{ lang.flagEmoji }} {{ lang.name }}
                </option>
              </select>
            </div>

            <div class="form-group">
              <label>Title *</label>
              <input v-model="form.title" type="text" required placeholder="e.g., Greetings">
            </div>

            <div class="form-group">
              <label>Description</label>
              <textarea v-model="form.description" placeholder="Brief description of the lesson"></textarea>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label>Level *</label>
                <input v-model.number="form.level" type="number" min="1" required>
              </div>

              <div class="form-group">
                <label>Order Index *</label>
                <input v-model.number="form.orderIndex" type="number" min="1" required>
              </div>

              <div class="form-group">
                <label>XP Reward *</label>
                <input v-model.number="form.xpReward" type="number" min="0" required>
              </div>
            </div>

            <div class="form-group">
              <label>
                <input v-model="form.isActive" type="checkbox">
                Active
              </label>
            </div>

            <div class="form-actions">
              <button type="button" @click="closeForm" class="secondary">Cancel</button>
              <button type="submit" class="primary">{{ editingLesson ? 'Update' : 'Create' }}</button>
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { adminService, languageService } from '../services/api'

const lessons = ref([])
const languages = ref([])
const loading = ref(true)
const showCreateForm = ref(false)
const editingLesson = ref(null)

const form = ref({
  languageId: '',
  title: '',
  description: '',
  level: 1,
  orderIndex: 1,
  xpReward: 10,
  isActive: true
})

onMounted(async () => {
  await loadLessons()
  await loadLanguages()
})

async function loadLessons() {
  try {
    loading.value = true
    const response = await adminService.getAllLessons()
    lessons.value = response.data
  } catch (error) {
    console.error('Error loading lessons:', error)
    alert('Failed to load lessons')
  } finally {
    loading.value = false
  }
}

async function loadLanguages() {
  try {
    const response = await languageService.getAllLanguages()
    languages.value = response.data
  } catch (error) {
    console.error('Error loading languages:', error)
  }
}

function editLesson(lesson) {
  editingLesson.value = lesson
  form.value = {
    languageId: lesson.language.id,
    title: lesson.title,
    description: lesson.description || '',
    level: lesson.level,
    orderIndex: lesson.orderIndex,
    xpReward: lesson.xpReward,
    isActive: lesson.isActive
  }
}

async function saveLesson() {
  try {
    const lessonData = {
      ...form.value,
      language: { id: form.value.languageId }
    }

    if (editingLesson.value) {
      await adminService.updateLesson(editingLesson.value.id, lessonData)
      alert('Lesson updated successfully!')
    } else {
      await adminService.createLesson(lessonData)
      alert('Lesson created successfully!')
    }
    
    closeForm()
    await loadLessons()
  } catch (error) {
    console.error('Error saving lesson:', error)
    alert('Failed to save lesson: ' + (error.response?.data || error.message))
  }
}

async function deleteLesson(id) {
  if (!confirm('Are you sure you want to delete this lesson?')) return
  
  try {
    await adminService.deleteLesson(id)
    alert('Lesson deleted successfully!')
    await loadLessons()
  } catch (error) {
    console.error('Error deleting lesson:', error)
    alert('Failed to delete lesson')
  }
}

function closeForm() {
  showCreateForm.value = false
  editingLesson.value = null
  form.value = {
    languageId: '',
    title: '',
    description: '',
    level: 1,
    orderIndex: 1,
    xpReward: 10,
    isActive: true
  }
}
</script>

<style scoped>
@import './AdminStyles.css';

.lessons-table {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

table {
  width: 100%;
  border-collapse: collapse;
}

thead {
  background: var(--bg-gray);
}

th {
  padding: 16px;
  text-align: left;
  font-weight: 600;
  color: var(--text-dark);
}

td {
  padding: 16px;
  border-top: 1px solid var(--border-gray);
}

.status-badge {
  display: inline-block;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 600;
}

.status-badge.active {
  background: rgba(88, 204, 2, 0.1);
  color: var(--primary-color);
}

.status-badge.inactive {
  background: rgba(200, 200, 200, 0.3);
  color: var(--text-light);
}

.actions {
  display: flex;
  gap: 8px;
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
</style>
