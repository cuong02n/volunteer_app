package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.edu.hust.volunteer_app.models.entity.Donation;
import vn.edu.hust.volunteer_app.service.DonationService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/donations")
public class DonationController {

    private final DonationService donationService;

    public DonationController(DonationService donationService) {
        this.donationService = donationService;
    }

    @GetMapping
    @Operation(summary = "Get all donations", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<Donation>> getAllDonations() {
        List<Donation> donations = donationService.getAllDonations();
        return ResponseEntity.ok(donations);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get donation by ID", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Donation> getDonationById(@PathVariable Integer id) {
        try {
            Donation donation = donationService.getDonationById(id).orElseThrow();
            return ResponseEntity.ok(donation); 
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PostMapping
    @Operation(summary = "Create new donation", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Donation> createDonation(@RequestBody Donation donation) {
        Donation newDonation = donationService.createDonation(donation);
        return new ResponseEntity<>(newDonation, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update donation by ID", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Donation> updateDonation(@PathVariable Integer id, @RequestBody Donation donation) {
        Optional<Donation> existingDonation = donationService.getDonationById(id);
        if (existingDonation.isPresent()) {
            donation.setId(id);
            Donation updatedDonation = donationService.updateDonation(donation);
            return ResponseEntity.ok(updatedDonation);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete donation by ID", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Void> deleteDonation(@PathVariable Integer id) {
        donationService.deleteDonation(id);
        return ResponseEntity.noContent().build();
    }
}
