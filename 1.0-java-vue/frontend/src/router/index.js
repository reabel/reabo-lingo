import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Languages from '../views/Languages.vue'
import Lessons from '../views/Lessons.vue'
import LessonPlay from '../views/LessonPlay.vue'
import Profile from '../views/Profile.vue'

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
    }
  ]
})

export default router
