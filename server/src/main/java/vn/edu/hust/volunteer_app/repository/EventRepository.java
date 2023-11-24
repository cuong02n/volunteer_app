package vn.edu.hust.volunteer_app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import org.springframework.transaction.annotation.Transactional;
import vn.edu.hust.volunteer_app.models.entity.Event;

public interface EventRepository extends JpaRepository<Event, Integer> {

    @Query("SELECT e FROM Event e WHERE e.fanpage_id = :fanpageId")
    List<Event> findByFanpageId(Integer fanpageId);

    @Transactional
    @Modifying
    @Query(value = "UPDATE event set status = ?1 where id = ?2", nativeQuery = true)
    void updateStatusById(int status,int id);
}
