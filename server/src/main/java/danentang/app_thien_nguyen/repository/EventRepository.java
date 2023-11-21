package danentang.app_thien_nguyen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import danentang.app_thien_nguyen.models.entity.Event;

public interface EventRepository extends JpaRepository<Event, Integer> {

    @Query("SELECT e FROM Event e WHERE e.fanpage_id = :fanpageId")
    List<Event> findByFanpageId(Integer fanpageId);
}
