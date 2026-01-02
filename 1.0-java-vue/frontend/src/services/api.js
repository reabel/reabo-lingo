import axios from 'axios'

const api = axios.create({
  baseURL: 'http://localhost:8080/api',
  headers: {
    'Content-Type': 'application/json'
  }
})

export const languageService = {
  getAllLanguages: () => api.get('/languages'),
  getLanguageById: (id) => api.get(`/languages/${id}`)
}

export const lessonService = {
  getAllLessons: () => api.get('/lessons'),
  getLessonById: (id) => api.get(`/lessons/${id}`),
  getLessonsByLanguage: (languageId) => api.get(`/lessons/language/${languageId}`)
}

export const questionService = {
  getQuestionsByLesson: (lessonId) => api.get(`/questions/lesson/${lessonId}`)
}

export const userService = {
  getAllUsers: () => api.get('/users'),
  getUserById: (id) => api.get(`/users/${id}`),
  createUser: (user) => api.post('/users', user),
  updateUser: (id, user) => api.put(`/users/${id}`, user)
}

export const progressService = {
  getUserProgress: (userId) => api.get(`/progress/user/${userId}`),
  getUserCompletedLessons: (userId) => api.get(`/progress/user/${userId}/completed`),
  createProgress: (progress) => api.post('/progress', progress),
  updateProgress: (id, progress) => api.put(`/progress/${id}`, progress)
}

export default api
