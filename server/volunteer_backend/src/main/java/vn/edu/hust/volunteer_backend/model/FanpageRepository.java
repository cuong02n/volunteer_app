package vn.edu.hust.volunteer_backend.model;

import org.springframework.boot.diagnostics.FailureAnalysis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface FanpageRepository extends JpaRepository<Fanpage, Integer> {
    List<Fanpage> findFanpageByLeaderId(int leaderId);
    Fanpage findFanpageById(int Id);
    @Query(value = "select fanpage.* from fanpage order by subscriber desc limit ?1", nativeQuery = true)
    List<Fanpage> findTopSubscriberFanpage(int top);

}
