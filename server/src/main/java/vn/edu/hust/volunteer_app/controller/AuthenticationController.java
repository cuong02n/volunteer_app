package vn.edu.hust.volunteer_app.controller;

import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.edu.hust.volunteer_app.models.request.AuthenticationRequest;
import vn.edu.hust.volunteer_app.models.request.RegisterRequest;
import vn.edu.hust.volunteer_app.models.request.RegisterVerifyRequest;
import vn.edu.hust.volunteer_app.models.response.AuthenticationResponse;
import vn.edu.hust.volunteer_app.service.AuthenticationService;
import vn.edu.hust.volunteer_app.service.OtpService;
import vn.edu.hust.volunteer_app.service.UserService;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
public class AuthenticationController {

    private final AuthenticationService service;
    private final UserService userService;
    private final OtpService otpService;
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        if (request.getName().isEmpty() || request.getEmail().isEmpty() || request.getPassword().isEmpty()) {
            return ResponseEntity.status(BAD_REQUEST).body("All fields must be filled in.");
        }

        if (userService.existsByEmail(request.getEmail())) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Email is already registered.");
        }
        service.register(request);
        return ResponseEntity.ok().build();
    }
    @PostMapping("/verify_register")
    public ResponseEntity<?> verifyRegister(@RequestBody RegisterVerifyRequest request){
        if(request.getOtp().isEmpty() || request.getEmail().isEmpty()){
            return ResponseEntity.status(BAD_REQUEST).body("All fields must be filled in.");
        }
        if(otpService.checkRegisterOTP(request.getEmail(),request.getOtp())){
            userService.verifiedRegister(request.getEmail());
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("OTP was expired or OTP not valid");

    }

    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate(@RequestBody AuthenticationRequest request) {
        return ResponseEntity.ok(service.authenticate(request));
    }

}
