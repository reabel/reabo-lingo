package com.reabolingo.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "questions")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Question {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "lesson_id", nullable = false)
    private Lesson lesson;
    
    @Column(nullable = false, columnDefinition = "TEXT")
    private String prompt;
    
    @Column(name = "question_type", nullable = false)
    private String questionType; // e.g., "translate", "multiple_choice", "fill_blank"
    
    @Column(name = "correct_answer", nullable = false, columnDefinition = "TEXT")
    private String correctAnswer;
    
    @Column(columnDefinition = "TEXT")
    private String options; // JSON array for multiple choice
    
    @Column(name = "audio_url")
    private String audioUrl;
    
    @Column(name = "image_url")
    private String imageUrl;
    
    @Column(name = "order_index", nullable = false)
    private Integer orderIndex;
}
