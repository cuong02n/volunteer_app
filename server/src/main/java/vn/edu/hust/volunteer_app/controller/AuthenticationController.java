package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.edu.hust.volunteer_app.models.entity.ResetPasswordOtp;
import vn.edu.hust.volunteer_app.models.request.AuthenticationRequest;
import vn.edu.hust.volunteer_app.models.request.RegisterRequest;
import vn.edu.hust.volunteer_app.models.request.RegisterVerifyRequest;
import vn.edu.hust.volunteer_app.models.request.ResetPasswordRequest;
import vn.edu.hust.volunteer_app.models.response.AuthenticationResponse;
import vn.edu.hust.volunteer_app.service.AuthenticationService;
import vn.edu.hust.volunteer_app.service.OtpService;
import vn.edu.hust.volunteer_app.service.UserService;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
public class AuthenticationController {

    private final AuthenticationService authenticationService;
    private final UserService userService;
    private final OtpService otpService;

    @PostMapping("/register")
    @Operation(summary = "simple register, contains name, email, password")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        if (request.getName().isEmpty() || request.getEmail().isEmpty() || request.getPassword().isEmpty()) {
            return ResponseEntity.status(BAD_REQUEST).body("All fields must be filled in.");
        }

        if (userService.existsByEmail(request.getEmail())) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Email is already registered.");
        }
        return ResponseEntity.ok(authenticationService.register(request));
    }

    @PostMapping("/verify_register")
    @Operation(summary = "after receive OTP, perform this action to verify your account")
    public ResponseEntity<?> verifyRegister(@RequestBody RegisterVerifyRequest request) {
        if (request.getOtp().isEmpty() || request.getEmail().isEmpty()) {
            return ResponseEntity.status(BAD_REQUEST).body("All fields must be filled in.");
        }
        if (otpService.checkRegisterOTP(request.getEmail(), request.getOtp())) {
            userService.verifiedRegister(request.getEmail());
            otpService.destroyRegisterOTP(request.getEmail(), request.getOtp());
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("OTP was expired or OTP not valid");
    }

    @PostMapping("/authenticate")
    @Operation(summary = "after perform this, you get your id and token, for feature use")
    public ResponseEntity<AuthenticationResponse> authenticate(@RequestBody AuthenticationRequest request) {
        return ResponseEntity.ok(authenticationService.authenticate(request));
    }


    @PostMapping("/reset_password")
    @Operation(summary = "reset password, need email only, you will get your OTP")
    public ResponseEntity<?> resetPassword(@RequestParam(value = "email") @Email String email) {
        if (!userService.existsByEmail(email)) return ResponseEntity.status(BAD_REQUEST).body("NOT EXIST ACCOUNT");
        ResetPasswordOtp otp = otpService.generateAndSaveResetPasswordOTP(email);
        return ResponseEntity.ok().body(otpService.sendResetPasswordOTP(otp));
    }

    @PutMapping("/reset_password")
    @Operation(summary = "after receive OTP, this action change password need email, otp and new password")
    public ResponseEntity<Boolean> resetAndChangePasswordIfVerified(@Valid @RequestBody ResetPasswordRequest resetPasswordRequest) {
        if (otpService.checkResetPasswordOTP(resetPasswordRequest.getEmail(), resetPasswordRequest.getOTP())) {
            userService.setNewPassword(resetPasswordRequest.getEmail(), resetPasswordRequest.getNewPassword());
            otpService.destroyResetPasswordOTP(resetPasswordRequest.getEmail(), resetPasswordRequest.getOTP());
            return ResponseEntity.ok(true);
        }
        return ResponseEntity.status(BAD_REQUEST).body(false);
    }

}
