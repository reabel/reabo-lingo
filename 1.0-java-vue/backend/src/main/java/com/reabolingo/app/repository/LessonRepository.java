package com.reabolingo.app.repository;

import com.reabolingo.app.model.Lesson;
import com.reabolingo.app.model.Language;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {
    List<Lesson> findByLanguageOrderByOrderIndexAsc(Language language);
    List<Lesson> findByLanguageAndIsActiveTrueOrderByOrderIndexAsc(Language language);
    List<Lesson> findByLanguageIdOrderByOrderIndexAsc(Long languageId);
}
