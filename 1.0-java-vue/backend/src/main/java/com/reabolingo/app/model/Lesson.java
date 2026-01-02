package com.reabolingo.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "lessons")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Lesson {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "language_id", nullable = false)
    private Language language;
    
    @Column(nullable = false)
    private String title;
    
    private String description;
    
    @Column(nullable = false)
    private Integer level = 1;
    
    @Column(name = "order_index", nullable = false)
    private Integer orderIndex;
    
    @Column(name = "xp_reward")
    private Integer xpReward = 10;
    
    @Column(name = "is_active")
    private Boolean isActive = true;
}
