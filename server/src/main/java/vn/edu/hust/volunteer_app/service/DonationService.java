package vn.edu.hust.volunteer_app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.models.entity.Donation;
import vn.edu.hust.volunteer_app.repository.DonationRepository;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DonationService {

    private final DonationRepository donationRepository;

    public List<Donation> getAllDonations() {
        return donationRepository.findAll();
    }

    public List<Donation> getDonationsByEventId(Integer eventId) {
        return donationRepository.findByEventId(eventId);
    }

    public Optional<Donation> getDonationById(Integer id) {
        return donationRepository.findById(id);
    }

    public Donation createDonation(Donation donation) {
        return donationRepository.save(donation);
    }

    public Donation updateDonation(Donation donation) {
        // Add validation or business logic if needed
        return donationRepository.save(donation);
    }

    public void deleteDonation(Integer id) {
        donationRepository.deleteById(id);
    }
}
