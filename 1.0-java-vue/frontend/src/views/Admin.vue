<template>
  <div class="admin-page">
    <header class="admin-header">
      <div class="container">
        <router-link to="/" class="logo">🦉 ReaboLingo Admin</router-link>
        <nav class="admin-nav">
          <router-link to="/admin/languages" class="nav-link">Languages</router-link>
          <router-link to="/admin/lessons" class="nav-link">Lessons</router-link>
          <router-link to="/admin/questions" class="nav-link">Questions</router-link>
          <router-link to="/" class="nav-link">← Exit Admin</router-link>
        </nav>
      </div>
    </header>

    <main class="container">
      <div class="admin-content">
        <h1>Admin Dashboard</h1>
        <div class="admin-cards">
          <router-link to="/admin/languages" class="admin-card">
            <div class="card-icon">🌍</div>
            <h3>Manage Languages</h3>
            <p>Add, edit, or remove languages</p>
          </router-link>
          
          <router-link to="/admin/lessons" class="admin-card">
            <div class="card-icon">📚</div>
            <h3>Manage Lessons</h3>
            <p>Create and organize lessons</p>
          </router-link>
          
          <router-link to="/admin/questions" class="admin-card">
            <div class="card-icon">❓</div>
            <h3>Manage Questions</h3>
            <p>Add and edit lesson questions</p>
          </router-link>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
</script>

<style scoped>
.admin-page {
  min-height: 100vh;
  background: var(--bg-gray);
}

.admin-header {
  background: #2c3e50;
  color: white;
  padding: 16px 0;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.admin-header .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  color: white;
  text-decoration: none;
}

.admin-nav {
  display: flex;
  gap: 24px;
}

.nav-link {
  color: white;
  text-decoration: none;
  font-weight: 600;
  transition: opacity 0.2s;
}

.nav-link:hover {
  opacity: 0.8;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 24px;
}

.admin-content {
  text-align: center;
}

.admin-content h1 {
  font-size: 36px;
  margin-bottom: 48px;
  color: var(--text-dark);
}

.admin-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 32px;
  max-width: 900px;
  margin: 0 auto;
}

.admin-card {
  background: white;
  border: 2px solid var(--border-gray);
  border-radius: 16px;
  padding: 40px;
  text-decoration: none;
  transition: all 0.2s;
  cursor: pointer;
}

.admin-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  border-color: var(--primary-color);
}

.card-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.admin-card h3 {
  font-size: 24px;
  margin-bottom: 12px;
  color: var(--text-dark);
}

.admin-card p {
  color: var(--text-light);
  line-height: 1.5;
}
</style>
