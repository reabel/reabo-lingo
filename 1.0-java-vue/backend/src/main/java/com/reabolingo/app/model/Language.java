package com.reabolingo.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "languages")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Language {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, unique = true)
    private String name;
    
    @Column(nullable = false, unique = true, length = 5)
    private String code; // e.g., "en", "es", "fr"
    
    @Column(name = "flag_emoji")
    private String flagEmoji;
    
    private String description;
    
    @Column(name = "is_active")
    private Boolean isActive = true;
}
