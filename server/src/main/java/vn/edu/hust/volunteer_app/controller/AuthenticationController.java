package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.edu.hust.volunteer_app.models.entity.ResetPasswordOtp;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.models.request.*;
import vn.edu.hust.volunteer_app.models.response.*;
import vn.edu.hust.volunteer_app.service.*;

import static org.springframework.http.HttpStatus.BAD_REQUEST;
import static org.springframework.http.HttpStatus.NO_CONTENT;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
public class AuthenticationController {

    private final AuthenticationService authenticationService;
    private final UserService userService;
    private final OtpService otpService;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody @Valid RegisterRequest request) {
        if (request.getName().isEmpty() || request.getEmail().isEmpty() || request.getPassword().isEmpty()) {
            return ResponseEntity.status(BAD_REQUEST).body("All fields must be filled in.");
        }

        if (userService.existsByEmail(request.getEmail())) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Email is already registered.");
        }
        return ResponseEntity.ok(authenticationService.register(request));
    }

    @PostMapping("/verify_register")
    public ResponseEntity<?> verifyRegister(@RequestBody RegisterVerifyRequest request) {
        if (request.getOtp().isEmpty() || request.getEmail().isEmpty()) {
            return ResponseEntity.status(BAD_REQUEST).body("All fields must be filled in.");
        }
        if (otpService.checkRegisterOTP(request.getEmail(), request.getOtp())) {
            userService.verifiedRegister(request.getEmail());
            otpService.destroyRegisterOTP(request.getEmail(),request.getOtp());
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("OTP was expired or OTP not valid");
    }

    @PostMapping("/authenticate")
    @Operation(summary = "login")
    public ResponseEntity<AuthenticationResponse> authenticate(@RequestBody AuthenticationRequest request) {
        return ResponseEntity.ok(authenticationService.authenticate(request));
    }


    @GetMapping("/reset_password")
    @Operation(summary = "reset password, need email only")
    public ResponseEntity<?> resetPassword(@RequestParam(value = "email") @Email String email) {
        if(!userService.existsByEmail(email))
            return ResponseEntity.status(BAD_REQUEST).body("NOT EXIST ACCOUNT");
        ResetPasswordOtp otp = otpService.generateAndSaveResetPasswordOTP(email);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/reset_password")
    @Operation(summary = "change password need email, otp and new password")
    public ResponseEntity<Boolean> resetAndChangePasswordIfVerified(@Valid @RequestBody ResetPasswordRequest resetPasswordRequest){
        if(otpService.checkResetPasswordOTP(resetPasswordRequest.getEmail(), resetPasswordRequest.getOTP())){
            userService.setNewPassword(resetPasswordRequest.getEmail(), resetPasswordRequest.getNewPassword());
            otpService.destroyResetPasswordOTP(resetPasswordRequest.getEmail(), resetPasswordRequest.getOTP());
            return ResponseEntity.ok(true);
        }
        return ResponseEntity.status(BAD_REQUEST).body(false);
    }

}
