package vn.edu.hust.volunteer_app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;

import java.util.List;
import java.util.Optional;

public interface FanpageRepository extends JpaRepository<Fanpage, Integer> {
    @Query("SELECT f FROM Fanpage f WHERE f.leaderId = :userId")
    List<Fanpage> findByLeaderId(Integer userId);

    Optional<Fanpage> findFanpageById(Integer id);
    @Query("SELECT count(*) FROM  Fanpage  f where f.fanpageName = :fanpageName AND f.status = :status")
    int countAllByFanpageNameAndStatus(String fanpageName, Fanpage.STATUS status);

    @Query("UPDATE Fanpage SET status = :status where id=:fanpageId")
    @Transactional
    @Modifying
    void setFanpageStatusById(int fanpageId, Fanpage.STATUS status);
}