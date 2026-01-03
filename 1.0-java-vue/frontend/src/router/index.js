import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Languages from '../views/Languages.vue'
import Lessons from '../views/Lessons.vue'
import LessonPlay from '../views/LessonPlay.vue'
import Profile from '../views/Profile.vue'
import Admin from '../views/Admin.vue'
import AdminLanguages from '../views/AdminLanguages.vue'
import AdminLessons from '../views/AdminLessons.vue'
import AdminQuestions from '../views/AdminQuestions.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/languages',
      name: 'Languages',
      component: Languages
    },
    {
      path: '/lessons/:languageId',
      name: 'Lessons',
      component: Lessons
    },
    {
      path: '/lesson/:lessonId',
      name: 'LessonPlay',
      component: LessonPlay
    },
    {
      path: '/profile',
      name: 'Profile',
      component: Profile
    },
    {
      path: '/admin',
      name: 'Admin',
      component: Admin
    },
    {
      path: '/admin/languages',
      name: 'AdminLanguages',
      component: AdminLanguages
    },
    {
      path: '/admin/lessons',
      name: 'AdminLessons',
      component: AdminLessons
    },
    {
      path: '/admin/questions',
      name: 'AdminQuestions',
      component: AdminQuestions
    }
  ]
})

export default router
