package com.reabolingo.app.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.reabolingo.app.model.Language;
import com.reabolingo.app.model.Lesson;
import com.reabolingo.app.model.Question;
import com.reabolingo.app.repository.QuestionRepository;
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

@WebMvcTest(QuestionController.class)
class QuestionControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private QuestionRepository questionRepository;

    private Lesson sampleLesson() {
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
        return lesson;
    }

    private Question sampleQuestion() {
        Question q = new Question();
        q.setId(1L);
        q.setLesson(sampleLesson());
        q.setPrompt("How do you say 'Hello' in French?");
        q.setQuestionType("multiple_choice");
        q.setCorrectAnswer("Bonjour");
        q.setOptions("[\"Bonjour\",\"Merci\",\"Au revoir\",\"Oui\"]");
        q.setOrderIndex(1);
        return q;
    }

    @Test
    void getQuestionsByLesson_returnsList() throws Exception {
        when(questionRepository.findByLessonIdOrderByOrderIndexAsc(2L)).thenReturn(List.of(sampleQuestion()));

        mockMvc.perform(get("/api/questions/lesson/2"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].questionType").value("multiple_choice"))
                .andExpect(jsonPath("$[0].correctAnswer").value("Bonjour"));
    }

    @Test
    void getQuestionById_found_returnsQuestion() throws Exception {
        when(questionRepository.findById(1L)).thenReturn(Optional.of(sampleQuestion()));

        mockMvc.perform(get("/api/questions/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.prompt").value("How do you say 'Hello' in French?"));
    }

    @Test
    void getQuestionById_notFound_returns404() throws Exception {
        when(questionRepository.findById(99L)).thenReturn(Optional.empty());

        mockMvc.perform(get("/api/questions/99"))
                .andExpect(status().isNotFound());
    }

    @Test
    void createQuestion_returnsSavedQuestion() throws Exception {
        Question toCreate = sampleQuestion();
        toCreate.setId(null);
        Question saved = sampleQuestion();
        when(questionRepository.save(any(Question.class))).thenReturn(saved);

        mockMvc.perform(post("/api/questions")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(toCreate)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.correctAnswer").value("Bonjour"));
    }
}
