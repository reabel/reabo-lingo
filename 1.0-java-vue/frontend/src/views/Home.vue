<template>
  <div class="home">
    <header class="header">
      <div class="container">
        <h1 class="logo">🦉 ReaboLingo</h1>
        <nav>
          <router-link to="/languages" class="nav-link">Languages</router-link>
          <router-link to="/profile" class="nav-link">Profile</router-link>
          <router-link to="/admin" class="nav-link">Admin</router-link>
        </nav>
      </div>
    </header>

    <main class="hero">
      <div class="container">
        <h2 class="hero-title">Learn languages for free, forever</h2>
        <p class="hero-subtitle">The world's #1 way to learn a language</p>
        <router-link to="/languages">
          <button class="primary btn-large">Get Started</button>
        </router-link>
      </div>
    </main>

    <section class="features">
      <div class="container">
        <div class="feature-grid">
          <div class="feature-card">
            <div class="feature-icon">✨</div>
            <h3>Effective and efficient</h3>
            <p>Learn with bite-sized lessons based on science</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">🎮</div>
            <h3>Stay motivated</h3>
            <p>Earn XP, unlock achievements, and level up</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">🎯</div>
            <h3>Personalized learning</h3>
            <p>Lessons tailored to your learning style</p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
</script>

<style scoped>
.home {
  min-height: 100vh;
}

.header {
  background: white;
  border-bottom: 2px solid var(--border-gray);
  padding: 16px 0;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 24px;
}

.header .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  color: var(--primary-color);
}

nav {
  display: flex;
  gap: 24px;
}

.nav-link {
  color: var(--text-dark);
  text-decoration: none;
  font-weight: 600;
}

.nav-link:hover {
  color: var(--primary-color);
}

.hero {
  text-align: center;
  padding: 80px 24px;
  background: linear-gradient(180deg, #f7f7f7 0%, white 100%);
}

.hero-title {
  font-size: 48px;
  margin-bottom: 16px;
  color: var(--text-dark);
}

.hero-subtitle {
  font-size: 24px;
  color: var(--text-light);
  margin-bottom: 32px;
}

.btn-large {
  padding: 18px 48px;
  font-size: 18px;
}

.features {
  padding: 80px 24px;
}

.feature-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 32px;
}

.feature-card {
  text-align: center;
  padding: 32px;
}

.feature-icon {
  font-size: 48px;
  margin-bottom: 16px;
}

.feature-card h3 {
  font-size: 24px;
  margin-bottom: 12px;
  color: var(--text-dark);
}

.feature-card p {
  color: var(--text-light);
  line-height: 1.6;
}
</style>
