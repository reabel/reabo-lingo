package com.reabolingo.app.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.reabolingo.app.model.Language;
import com.reabolingo.app.repository.LanguageRepository;
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

@WebMvcTest(LanguageController.class)
class LanguageControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private LanguageRepository languageRepository;

    private Language sampleLanguage() {
        Language lang = new Language();
        lang.setId(1L);
        lang.setName("Spanish");
        lang.setCode("es");
        lang.setFlagEmoji("🇪🇸");
        lang.setDescription("Spanish language");
        lang.setIsActive(true);
        return lang;
    }

    @Test
    void getAllLanguages_returnsActiveLanguages() throws Exception {
        when(languageRepository.findByIsActiveTrue()).thenReturn(List.of(sampleLanguage()));

        mockMvc.perform(get("/api/languages"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].code").value("es"))
                .andExpect(jsonPath("$[0].name").value("Spanish"));
    }

    @Test
    void getLanguageById_found_returnsLanguage() throws Exception {
        when(languageRepository.findById(1L)).thenReturn(Optional.of(sampleLanguage()));

        mockMvc.perform(get("/api/languages/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.code").value("es"));
    }

    @Test
    void getLanguageById_notFound_returns404() throws Exception {
        when(languageRepository.findById(99L)).thenReturn(Optional.empty());

        mockMvc.perform(get("/api/languages/99"))
                .andExpect(status().isNotFound());
    }

    @Test
    void createLanguage_returnsCreatedLanguage() throws Exception {
        Language lang = sampleLanguage();
        lang.setId(null);
        Language saved = sampleLanguage();
        when(languageRepository.save(any(Language.class))).thenReturn(saved);

        mockMvc.perform(post("/api/languages")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(lang)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.name").value("Spanish"));
    }
}
