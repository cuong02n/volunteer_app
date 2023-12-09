package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.repository.EventRepository;

@RestController
@RequestMapping("/api/v1/demo-controller")
@RequiredArgsConstructor
public class DemoController {
    private final HttpServletRequest request;
    final EventRepository eventRepository;

    @GetMapping("/test")
    public ResponseEntity<?> test(@RequestParam("status") Event.STATUS status) {
        return ResponseEntity.ok().body(eventRepository.test(status));
    }

    @GetMapping
    @Operation(summary = "Demo secret controller", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<String> sayHello() {
        System.out.println(request.getAttribute("email"));

        return ResponseEntity.ok().body("Hello user : " + request.getAttribute("email")
                + " from 1234 secured endpoint, your id is : " + request.getAttribute("user_id"));
    }

}
