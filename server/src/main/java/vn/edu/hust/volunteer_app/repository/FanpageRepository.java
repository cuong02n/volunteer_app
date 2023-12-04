package vn.edu.hust.volunteer_app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import vn.edu.hust.volunteer_app.models.entity.Fanpage;

public interface FanpageRepository extends JpaRepository<Fanpage, Integer> {
    @Query("SELECT f FROM Fanpage f WHERE f.leaderId = :userId")
    List<Fanpage> findByLeaderId(Integer userId);

    @Query("SELECT count(*) FROM  Fanpage  f where f.fanpageName = :fanpageName AND f.status = :status")
    int countAllByFanpageNameAndStatus(String fanpageName,String status);
}