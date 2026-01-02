package com.reabolingo.app.controller;

import com.reabolingo.app.model.Language;
import com.reabolingo.app.repository.LanguageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/languages")
@CrossOrigin(origins = "http://localhost:5173")
public class LanguageController {
    
    @Autowired
    private LanguageRepository languageRepository;
    
    @GetMapping
    public List<Language> getAllLanguages() {
        return languageRepository.findByIsActiveTrue();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Language> getLanguageById(@PathVariable Long id) {
        return languageRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public Language createLanguage(@RequestBody Language language) {
        return languageRepository.save(language);
    }
}
