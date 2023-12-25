package vn.edu.hust.volunteer_app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import vn.edu.hust.volunteer_app.models.entity.Donation;
import vn.edu.hust.volunteer_app.models.entity.Event;

public interface DonationRepository extends JpaRepository<Donation, Integer> {
    @Query("SELECT d FROM Donation d WHERE d.eventId = :eventId")
    List<Donation> findByEventId(Integer eventId);

    @Query("""
            select d
            from Donation d
            where (:eventId is null or d.eventId = :eventId)
            """)
    List<Donation> getDonationByCriteria(@Param("eventId") Integer eventId);

}
