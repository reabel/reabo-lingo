package com.reabolingo.app.repository;

import com.reabolingo.app.model.UserProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserProgressRepository extends JpaRepository<UserProgress, Long> {
    List<UserProgress> findByUserId(Long userId);
    List<UserProgress> findByUserIdAndIsCompletedTrue(Long userId);
    Optional<UserProgress> findByUserIdAndLessonId(Long userId, Long lessonId);
}
