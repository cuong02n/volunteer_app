package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.edu.hust.volunteer_app.models.entity.Donation;
import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.service.DonationService;
import vn.edu.hust.volunteer_app.service.EventService;
import vn.edu.hust.volunteer_app.service.FanpageService;
import vn.edu.hust.volunteer_app.service.UserService;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/donations")
public class DonationController {
    private final HttpServletRequest request;
    private final DonationService donationService;
    private final EventService eventService;
    private final FanpageService fanpageService;
    private final UserService userService;

    @GetMapping
    @Operation(summary = "Get all donations", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<Donation>> getAllDonations(
            @RequestParam(name = "eventId", required = false) Integer eventId) {
        List<Donation> donations = donationService.getDonationByCriteria(eventId);

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
    public ResponseEntity<Donation> createDonation(@RequestBody Donation donationRequest) {
        Integer userId = (Integer) request.getAttribute("user_id");
        try {
            Event event = eventService.getEventById(donationRequest.getEventId()).orElseThrow();
            Fanpage fanpage = fanpageService.getFanpageById(event.getFanpageId()).orElseThrow();
            if (donationRequest.getUserId() != null) {
                User supporter = userService.findUserById(donationRequest.getUserId()).orElseThrow();
            }
            if (!userId.equals(fanpage.getLeaderId())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
            }
            Donation newDonation = donationService.createDonation(donationRequest);
            return new ResponseEntity<>(newDonation, HttpStatus.CREATED);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete donation by ID", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Void> deleteDonation(@PathVariable Integer id) {
        donationService.deleteDonation(id);
        return ResponseEntity.noContent().build();
    }
}
