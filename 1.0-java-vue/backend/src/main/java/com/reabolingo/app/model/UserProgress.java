package com.reabolingo.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_progress")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserProgress {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "lesson_id", nullable = false)
    private Lesson lesson;
    
    @Column(name = "is_completed")
    private Boolean isCompleted = false;
    
    @Column(name = "attempts")
    private Integer attempts = 0;
    
    @Column(name = "best_score")
    private Integer bestScore = 0;
    
    @Column(name = "xp_earned")
    private Integer xpEarned = 0;
    
    @Column(name = "started_at")
    private LocalDateTime startedAt = LocalDateTime.now();
    
    @Column(name = "completed_at")
    private LocalDateTime completedAt;
}
