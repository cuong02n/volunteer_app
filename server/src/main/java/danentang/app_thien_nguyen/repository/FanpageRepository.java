package danentang.app_thien_nguyen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import danentang.app_thien_nguyen.models.entity.Fanpage;

public interface FanpageRepository extends JpaRepository<Fanpage, Integer> {
    @Query("SELECT f FROM Fanpage f WHERE f.leaderId = :userId")
    List<Fanpage> findByLeaderId(Integer userId);
}