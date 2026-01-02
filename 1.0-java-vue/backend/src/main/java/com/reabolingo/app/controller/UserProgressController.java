package com.reabolingo.app.controller;

import com.reabolingo.app.model.UserProgress;
import com.reabolingo.app.repository.UserProgressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/progress")
@CrossOrigin(origins = "http://localhost:5173")
public class UserProgressController {
    
    @Autowired
    private UserProgressRepository userProgressRepository;
    
    @GetMapping("/user/{userId}")
    public List<UserProgress> getUserProgress(@PathVariable Long userId) {
        return userProgressRepository.findByUserId(userId);
    }
    
    @GetMapping("/user/{userId}/completed")
    public List<UserProgress> getUserCompletedLessons(@PathVariable Long userId) {
        return userProgressRepository.findByUserIdAndIsCompletedTrue(userId);
    }
    
    @PostMapping
    public UserProgress createProgress(@RequestBody UserProgress progress) {
        return userProgressRepository.save(progress);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<UserProgress> updateProgress(@PathVariable Long id, @RequestBody UserProgress progressDetails) {
        return userProgressRepository.findById(id)
                .map(progress -> {
                    progress.setIsCompleted(progressDetails.getIsCompleted());
                    progress.setAttempts(progressDetails.getAttempts());
                    progress.setBestScore(progressDetails.getBestScore());
                    progress.setXpEarned(progressDetails.getXpEarned());
                    progress.setCompletedAt(progressDetails.getCompletedAt());
                    return ResponseEntity.ok(userProgressRepository.save(progress));
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
