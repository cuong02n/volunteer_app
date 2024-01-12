package vn.edu.hust.volunteer_app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hust.volunteer_app.models.entity.Event;

import java.util.List;

public interface EventRepository extends JpaRepository<Event, Integer> {

    @Query("SELECT e FROM Event e WHERE e.fanpageId = :fanpageId")
    List<Event> findEventByFanpageIdAndStatus(Integer fanpageId);

    @Transactional
    @Modifying
    @Query(value = "UPDATE event set status = ?1 where id = ?2", nativeQuery = true)
    void updateStatusById(String status, int id);

    @Query(value = "select e from Event e where e.status = ?1", nativeQuery = true)
    List<Event> getFanpageByStatus(String status);

    @Query("""
            select e
            from Event e
            where (:id is null or :id = e.id)
            and (:title is null or e.title = :title)
            and (:content is null or e.content = :content)
            and (:min_target is null or e.target >= :min_target)
            and (:max_target is null or e.target <= :max_target)
            and (:fanpage_id is null or e.fanpageId = :fanpage_id)
            and (:start_time is null or e.startTime = :start_time)
            and (:end_time is null or e.endTime = :end_time)
            and (:status is null or e.status = :status)
            """)
    List<Event> getEventByCriteria(@Param("id") Integer id,
                                   @Param("title") String title,
                                   @Param("content") String content,
                                   @Param("min_target") Integer minTarget,
                                   @Param("max_target") Integer maxTarget,
                                   @Param("fanpage_id") Integer fanpageId,
                                   @Param("start_time") Integer startTime,
                                   @Param("end_time") Integer endTime,
                                   @Param("status") Event.STATUS status
    );

    @Query("select e from Event e where e.status = :status")
    List<Event> test(@Param("status") Event.STATUS status);

    @Transactional
    void deleteAllByFanpageId(int id);
}
