package com.reabolingo.app.controller;

import com.reabolingo.app.model.Language;
import com.reabolingo.app.model.Lesson;
import com.reabolingo.app.model.Question;
import com.reabolingo.app.repository.LanguageRepository;
import com.reabolingo.app.repository.LessonRepository;
import com.reabolingo.app.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
@CrossOrigin(origins = "http://localhost:5173")
public class AdminController {
    
    @Autowired
    private LanguageRepository languageRepository;
    
    @Autowired
    private LessonRepository lessonRepository;
    
    @Autowired
    private QuestionRepository questionRepository;
    
    // ========== Language Management ==========
    
    @GetMapping("/languages")
    public List<Language> getAllLanguagesAdmin() {
        return languageRepository.findAll();
    }
    
    @PostMapping("/languages")
    public Language createLanguage(@RequestBody Language language) {
        return languageRepository.save(language);
    }
    
    @PutMapping("/languages/{id}")
    public ResponseEntity<Language> updateLanguage(@PathVariable Long id, @RequestBody Language languageDetails) {
        return languageRepository.findById(id)
                .map(language -> {
                    language.setName(languageDetails.getName());
                    language.setCode(languageDetails.getCode());
                    language.setFlagEmoji(languageDetails.getFlagEmoji());
                    language.setDescription(languageDetails.getDescription());
                    language.setIsActive(languageDetails.getIsActive());
                    return ResponseEntity.ok(languageRepository.save(language));
                })
                .orElse(ResponseEntity.notFound().build());
    }
    
    @DeleteMapping("/languages/{id}")
    public ResponseEntity<?> deleteLanguage(@PathVariable Long id) {
        return languageRepository.findById(id)
                .map(language -> {
                    languageRepository.delete(language);
                    return ResponseEntity.ok().build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
    
    // ========== Lesson Management ==========
    
    @GetMapping("/lessons")
    public List<Lesson> getAllLessonsAdmin() {
        return lessonRepository.findAll();
    }
    
    @PostMapping("/lessons")
    public Lesson createLessonAdmin(@RequestBody Lesson lesson) {
        return lessonRepository.save(lesson);
    }
    
    @PutMapping("/lessons/{id}")
    public ResponseEntity<Lesson> updateLesson(@PathVariable Long id, @RequestBody Lesson lessonDetails) {
        return lessonRepository.findById(id)
                .map(lesson -> {
                    lesson.setLanguage(lessonDetails.getLanguage());
                    lesson.setTitle(lessonDetails.getTitle());
                    lesson.setDescription(lessonDetails.getDescription());
                    lesson.setLevel(lessonDetails.getLevel());
                    lesson.setOrderIndex(lessonDetails.getOrderIndex());
                    lesson.setXpReward(lessonDetails.getXpReward());
                    lesson.setIsActive(lessonDetails.getIsActive());
                    return ResponseEntity.ok(lessonRepository.save(lesson));
                })
                .orElse(ResponseEntity.notFound().build());
    }
    
    @DeleteMapping("/lessons/{id}")
    public ResponseEntity<?> deleteLesson(@PathVariable Long id) {
        return lessonRepository.findById(id)
                .map(lesson -> {
                    lessonRepository.delete(lesson);
                    return ResponseEntity.ok().build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
    
    // ========== Question Management ==========
    
    @GetMapping("/questions")
    public List<Question> getAllQuestionsAdmin() {
        return questionRepository.findAll();
    }
    
    @PostMapping("/questions")
    public Question createQuestionAdmin(@RequestBody Question question) {
        return questionRepository.save(question);
    }
    
    @PutMapping("/questions/{id}")
    public ResponseEntity<Question> updateQuestion(@PathVariable Long id, @RequestBody Question questionDetails) {
        return questionRepository.findById(id)
                .map(question -> {
                    question.setLesson(questionDetails.getLesson());
                    question.setPrompt(questionDetails.getPrompt());
                    question.setQuestionType(questionDetails.getQuestionType());
                    question.setCorrectAnswer(questionDetails.getCorrectAnswer());
                    question.setOptions(questionDetails.getOptions());
                    question.setAudioUrl(questionDetails.getAudioUrl());
                    question.setImageUrl(questionDetails.getImageUrl());
                    question.setOrderIndex(questionDetails.getOrderIndex());
                    return ResponseEntity.ok(questionRepository.save(question));
                })
                .orElse(ResponseEntity.notFound().build());
    }
    
    @DeleteMapping("/questions/{id}")
    public ResponseEntity<?> deleteQuestion(@PathVariable Long id) {
        return questionRepository.findById(id)
                .map(question -> {
                    questionRepository.delete(question);
                    return ResponseEntity.ok().build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
