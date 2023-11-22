package vn.edu.hust.volunteer_app.controller;

import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.models.request.AuthenticationRequest;
import vn.edu.hust.volunteer_app.models.request.RegisterRequest;
import vn.edu.hust.volunteer_app.models.response.AuthenticationResponse;
import vn.edu.hust.volunteer_app.service.AuthenticationService;
import vn.edu.hust.volunteer_app.service.UserService;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
public class AuthenticationController {

    private final AuthenticationService service;
    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        // Kiểm tra trường thông tin rỗng
        if (request.getFullname().isEmpty() || request.getEmail().isEmpty() || request.getPassword().isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("All fields must be filled in.");
        }

        if (userService.existsByEmail(request.getEmail())) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Email is already registered.");
        }

        return ResponseEntity.ok(service.register(request));
    }

    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate(@RequestBody AuthenticationRequest request) {
        return ResponseEntity.ok(service.authenticate(request));
    }

}
