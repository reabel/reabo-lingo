package com.reabolingo.app.controller;

import com.reabolingo.app.model.Question;
import com.reabolingo.app.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/questions")
@CrossOrigin(origins = "http://localhost:5173")
public class QuestionController {
    
    @Autowired
    private QuestionRepository questionRepository;
    
    @GetMapping("/lesson/{lessonId}")
    public List<Question> getQuestionsByLesson(@PathVariable Long lessonId) {
        return questionRepository.findByLessonIdOrderByOrderIndexAsc(lessonId);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Question> getQuestionById(@PathVariable Long id) {
        return questionRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public Question createQuestion(@RequestBody Question question) {
        return questionRepository.save(question);
    }
}
