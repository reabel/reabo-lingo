package com.reabolingo.app.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.reabolingo.app.model.Language;
import com.reabolingo.app.model.Lesson;
import com.reabolingo.app.model.User;
import com.reabolingo.app.model.UserProgress;
import com.reabolingo.app.repository.UserProgressRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserProgressController.class)
class UserProgressControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private UserProgressRepository userProgressRepository;

    private UserProgress sampleProgress() {
        User user = new User();
        user.setId(1L);
        user.setUsername("testuser");
        user.setEmail("test@example.com");
        user.setPassword("secret");

        Language lang = new Language();
        lang.setId(1L);
        lang.setCode("fr");
        lang.setName("French");
        lang.setIsActive(true);

        Lesson lesson = new Lesson();
        lesson.setId(2L);
        lesson.setLanguage(lang);
        lesson.setTitle("Greetings");
        lesson.setLevel(1);
        lesson.setOrderIndex(1);
        lesson.setXpReward(10);
        lesson.setIsActive(true);

        UserProgress progress = new UserProgress();
        progress.setId(1L);
        progress.setUser(user);
        progress.setLesson(lesson);
        progress.setIsCompleted(false);
        progress.setAttempts(1);
        progress.setBestScore(80);
        progress.setXpEarned(0);
        return progress;
    }

    @Test
    void getUserProgress_returnsList() throws Exception {
        when(userProgressRepository.findByUserId(1L)).thenReturn(List.of(sampleProgress()));

        mockMvc.perform(get("/api/progress/user/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].attempts").value(1))
                .andExpect(jsonPath("$[0].bestScore").value(80));
    }

    @Test
    void getUserCompletedLessons_returnsCompletedOnly() throws Exception {
        UserProgress completed = sampleProgress();
        completed.setIsCompleted(true);
        completed.setXpEarned(10);
        when(userProgressRepository.findByUserIdAndIsCompletedTrue(1L)).thenReturn(List.of(completed));

        mockMvc.perform(get("/api/progress/user/1/completed"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].isCompleted").value(true))
                .andExpect(jsonPath("$[0].xpEarned").value(10));
    }

    @Test
    void createProgress_returnsSavedProgress() throws Exception {
        UserProgress toCreate = sampleProgress();
        toCreate.setId(null);
        when(userProgressRepository.save(any(UserProgress.class))).thenReturn(sampleProgress());

        mockMvc.perform(post("/api/progress")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(toCreate)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.bestScore").value(80));
    }

    @Test
    void updateProgress_found_returnsUpdated() throws Exception {
        UserProgress existing = sampleProgress();
        UserProgress updated = sampleProgress();
        updated.setIsCompleted(true);
        updated.setAttempts(3);
        updated.setBestScore(95);
        updated.setXpEarned(10);

        when(userProgressRepository.findById(1L)).thenReturn(Optional.of(existing));
        when(userProgressRepository.save(any(UserProgress.class))).thenReturn(updated);

        mockMvc.perform(put("/api/progress/1")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(updated)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.isCompleted").value(true))
                .andExpect(jsonPath("$.bestScore").value(95));
    }

    @Test
    void updateProgress_notFound_returns404() throws Exception {
        when(userProgressRepository.findById(99L)).thenReturn(Optional.empty());

        mockMvc.perform(put("/api/progress/99")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(sampleProgress())))
                .andExpect(status().isNotFound());
    }
}
