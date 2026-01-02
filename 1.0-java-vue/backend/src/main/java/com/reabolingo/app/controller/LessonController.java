package com.reabolingo.app.controller;

import com.reabolingo.app.model.Lesson;
import com.reabolingo.app.repository.LessonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/lessons")
@CrossOrigin(origins = "http://localhost:5173")
public class LessonController {
    
    @Autowired
    private LessonRepository lessonRepository;
    
    @GetMapping
    public List<Lesson> getAllLessons() {
        return lessonRepository.findAll();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Lesson> getLessonById(@PathVariable Long id) {
        return lessonRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/language/{languageId}")
    public List<Lesson> getLessonsByLanguage(@PathVariable Long languageId) {
        return lessonRepository.findByLanguageIdOrderByOrderIndexAsc(languageId);
    }
    
    @PostMapping
    public Lesson createLesson(@RequestBody Lesson lesson) {
        return lessonRepository.save(lesson);
    }
}
