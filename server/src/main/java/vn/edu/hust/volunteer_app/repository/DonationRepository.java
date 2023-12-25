package vn.edu.hust.volunteer_app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import vn.edu.hust.volunteer_app.models.entity.Donation;

public interface DonationRepository extends JpaRepository<Donation, Integer> {
    @Query("SELECT d FROM Donation d WHERE d.eventId = :eventId")
    List<Donation> findByEventId(Integer eventId);

}
