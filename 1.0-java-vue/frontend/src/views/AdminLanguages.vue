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
          <h1>Manage Languages</h1>
          <button @click="showCreateForm = true" class="primary">+ Add New Language</button>
        </div>

        <div v-if="loading" class="loading">Loading languages...</div>

        <div v-else class="languages-grid">
          <div v-for="language in languages" :key="language.id" class="language-card">
            <div class="language-flag">{{ language.flagEmoji }}</div>
            <h3>{{ language.name }}</h3>
            <p class="language-code">{{ language.code }}</p>
            <p class="language-desc">{{ language.description }}</p>
            <div class="language-status">
              <span :class="['status-badge', language.isActive ? 'active' : 'inactive']">
                {{ language.isActive ? 'Active' : 'Inactive' }}
              </span>
            </div>
            <div class="language-actions">
              <button @click="editLanguage(language)" class="btn-edit">Edit</button>
              <button @click="deleteLanguage(language.id)" class="btn-delete">Delete</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Create/Edit Form Modal -->
      <div v-if="showCreateForm || editingLanguage" class="modal" @click.self="closeForm">
        <div class="modal-content">
          <h2>{{ editingLanguage ? 'Edit Language' : 'Create New Language' }}</h2>
          
          <form @submit.prevent="saveLanguage">
            <div class="form-group">
              <label>Language Name *</label>
              <input v-model="form.name" type="text" required placeholder="e.g., Spanish">
            </div>

            <div class="form-group">
              <label>Language Code *</label>
              <input v-model="form.code" type="text" required placeholder="e.g., es" maxlength="5">
              <small>ISO 639-1 language code (2-5 characters)</small>
            </div>

            <div class="form-group">
              <label>Flag Emoji *</label>
              <input v-model="form.flagEmoji" type="text" required placeholder="🇪🇸">
              <small>Country flag emoji for the language</small>
            </div>

            <div class="form-group">
              <label>Description</label>
              <textarea v-model="form.description" placeholder="Brief description of the language"></textarea>
            </div>

            <div class="form-group">
              <label>
                <input v-model="form.isActive" type="checkbox">
                Active (visible to users)
              </label>
            </div>

            <div class="form-actions">
              <button type="button" @click="closeForm" class="secondary">Cancel</button>
              <button type="submit" class="primary">{{ editingLanguage ? 'Update' : 'Create' }}</button>
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { adminService } from '../services/api'

const languages = ref([])
const loading = ref(true)
const showCreateForm = ref(false)
const editingLanguage = ref(null)

const form = ref({
  name: '',
  code: '',
  flagEmoji: '',
  description: '',
  isActive: true
})

onMounted(async () => {
  await loadLanguages()
})

async function loadLanguages() {
  try {
    loading.value = true
    const response = await adminService.getAllLanguages()
    languages.value = response.data
  } catch (error) {
    console.error('Error loading languages:', error)
    alert('Failed to load languages')
  } finally {
    loading.value = false
  }
}

function editLanguage(language) {
  editingLanguage.value = language
  form.value = {
    name: language.name,
    code: language.code,
    flagEmoji: language.flagEmoji,
    description: language.description || '',
    isActive: language.isActive
  }
}

async function saveLanguage() {
  try {
    if (editingLanguage.value) {
      await adminService.updateLanguage(editingLanguage.value.id, form.value)
      alert('Language updated successfully!')
    } else {
      await adminService.createLanguage(form.value)
      alert('Language created successfully!')
    }
    
    closeForm()
    await loadLanguages()
  } catch (error) {
    console.error('Error saving language:', error)
    alert('Failed to save language: ' + (error.response?.data || error.message))
  }
}

async function deleteLanguage(id) {
  if (!confirm('Are you sure you want to delete this language? This will also delete all associated lessons and questions!')) return
  
  try {
    await adminService.deleteLanguage(id)
    alert('Language deleted successfully!')
    await loadLanguages()
  } catch (error) {
    console.error('Error deleting language:', error)
    alert('Failed to delete language')
  }
}

function closeForm() {
  showCreateForm.value = false
  editingLanguage.value = null
  form.value = {
    name: '',
    code: '',
    flagEmoji: '',
    description: '',
    isActive: true
  }
}
</script>

<style scoped>
@import './AdminStyles.css';

.languages-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 24px;
}

.language-card {
  background: white;
  border: 2px solid var(--border-gray);
  border-radius: 16px;
  padding: 24px;
  text-align: center;
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

.language-code {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-light);
  text-transform: uppercase;
  margin-bottom: 12px;
}

.language-desc {
  color: var(--text-light);
  margin-bottom: 16px;
  line-height: 1.5;
  min-height: 48px;
}

.language-status {
  margin-bottom: 16px;
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

.language-actions {
  display: flex;
  gap: 8px;
  justify-content: center;
}

.btn-edit, .btn-delete {
  padding: 10px 20px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 600;
  flex: 1;
}

.btn-edit {
  background: var(--primary-color);
  color: white;
}

.btn-delete {
  background: var(--danger-color);
  color: white;
}

small {
  display: block;
  margin-top: 4px;
  color: var(--text-light);
  font-size: 12px;
}
</style>
