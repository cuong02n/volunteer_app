package vn.edu.hust.volunteer_app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;

import java.util.List;

public interface FanpageRepository extends JpaRepository<Fanpage, Integer> {
    @Query("SELECT f FROM Fanpage f WHERE f.leaderId = :userId")
    List<Fanpage> findByLeaderId(Integer userId);

    @Query("SELECT count(*) FROM  Fanpage  f where f.fanpageName = :fanpageName AND f.status = :status")
    int countAllByFanpageNameAndStatus(String fanpageName, String status);

    @Query("UPDATE Fanpage SET status = :status where id=:fanpageId")
    void setFanpageStatusById(int fanpageId, String status);
}