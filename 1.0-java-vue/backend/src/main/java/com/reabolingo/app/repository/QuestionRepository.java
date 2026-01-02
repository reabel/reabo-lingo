package com.reabolingo.app.repository;

import com.reabolingo.app.model.Question;
import com.reabolingo.app.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {
    List<Question> findByLessonOrderByOrderIndexAsc(Lesson lesson);
    List<Question> findByLessonIdOrderByOrderIndexAsc(Long lessonId);
}
