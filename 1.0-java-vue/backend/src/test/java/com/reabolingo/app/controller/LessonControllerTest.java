package com.reabolingo.app.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.reabolingo.app.model.Language;
import com.reabolingo.app.model.Lesson;
import com.reabolingo.app.repository.LessonRepository;
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

@WebMvcTest(LessonController.class)
class LessonControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private LessonRepository lessonRepository;

    private Language sampleLanguage() {
        Language lang = new Language();
        lang.setId(1L);
        lang.setName("French");
        lang.setCode("fr");
        lang.setIsActive(true);
        return lang;
    }

    private Lesson sampleLesson() {
        Lesson lesson = new Lesson();
        lesson.setId(1L);
        lesson.setLanguage(sampleLanguage());
        lesson.setTitle("Greetings");
        lesson.setDescription("Basic greetings");
        lesson.setLevel(1);
        lesson.setOrderIndex(1);
        lesson.setXpReward(10);
        lesson.setIsActive(true);
        return lesson;
    }

    @Test
    void getAllLessons_returnsList() throws Exception {
        when(lessonRepository.findAll()).thenReturn(List.of(sampleLesson()));

        mockMvc.perform(get("/api/lessons"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].title").value("Greetings"))
                .andExpect(jsonPath("$[0].level").value(1));
    }

    @Test
    void getLessonById_found_returnsLesson() throws Exception {
        when(lessonRepository.findById(1L)).thenReturn(Optional.of(sampleLesson()));

        mockMvc.perform(get("/api/lessons/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.title").value("Greetings"));
    }

    @Test
    void getLessonById_notFound_returns404() throws Exception {
        when(lessonRepository.findById(99L)).thenReturn(Optional.empty());

        mockMvc.perform(get("/api/lessons/99"))
                .andExpect(status().isNotFound());
    }

    @Test
    void getLessonsByLanguage_returnsList() throws Exception {
        when(lessonRepository.findByLanguageIdOrderByOrderIndexAsc(1L)).thenReturn(List.of(sampleLesson()));

        mockMvc.perform(get("/api/lessons/language/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].orderIndex").value(1));
    }

    @Test
    void createLesson_returnsSavedLesson() throws Exception {
        Lesson toCreate = sampleLesson();
        toCreate.setId(null);
        Lesson saved = sampleLesson();
        when(lessonRepository.save(any(Lesson.class))).thenReturn(saved);

        mockMvc.perform(post("/api/lessons")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(toCreate)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.xpReward").value(10));
    }
}
