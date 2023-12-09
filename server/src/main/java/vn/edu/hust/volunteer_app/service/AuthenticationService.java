package vn.edu.hust.volunteer_app.service;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import vn.edu.hust.volunteer_app.models.entity.RegisterOtp;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.models.request.AuthenticationRequest;
import vn.edu.hust.volunteer_app.models.request.RegisterRequest;
import vn.edu.hust.volunteer_app.models.response.AuthenticationResponse;
import vn.edu.hust.volunteer_app.repository.UserRepository;

@Service
@AllArgsConstructor

public class AuthenticationService {
    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final OtpService otpService;
    public String register(RegisterRequest request) {
        User user = User.builder()
                .name(request.getName())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(User.Role.USER)
                .status(User.Status.NOT_VERIFY)
                .build();
        repository.save(user);

        RegisterOtp otp = otpService.generateAndSaveRegisterOTP(user.getEmail());
        return otpService.sendRegisterOTP(otp);
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        System.out.println("Check check 1");
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()));

        System.out.println("Check check 2");
        var user = repository.findByEmailAndStatus(request.getEmail(),User.Status.VERIFIED)
                .orElseThrow();
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .userId(user.getId())
                .build();
    }

}
