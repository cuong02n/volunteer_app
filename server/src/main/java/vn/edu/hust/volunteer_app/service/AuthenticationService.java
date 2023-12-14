package vn.edu.hust.volunteer_app.service;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import javax.swing.text.DefaultStyledDocument;

@Service
@RequiredArgsConstructor

public class AuthenticationService {
        private final UserRepository userRepository;
        private final PasswordEncoder passwordEncoder;
        private final JwtService jwtService;
        private final AuthenticationManager authenticationManager;
        private final OtpService otpService;
        Logger logger = LoggerFactory.getLogger(AuthenticationService.class);

        public String register(RegisterRequest request) {
                User user = User.builder()
                                .name(request.getName())
                                .email(request.getEmail())
                                .password(passwordEncoder.encode(request.getPassword()))
                                .role(User.Role.USER)
                                .status(User.Status.NOT_VERIFY)
                                .build();
                userRepository.save(user);

                RegisterOtp otp = otpService.generateAndSaveRegisterOTP(user.getEmail());
                return otpService.sendRegisterOTP(otp);
        }

        public AuthenticationResponse authenticate(AuthenticationRequest request) {
                logger.debug("authenticate");
                authenticationManager.authenticate(
                                new UsernamePasswordAuthenticationToken(
                                                request.getEmail(),
                                                request.getPassword()));

                logger.debug("after authenticate success");
                var user = userRepository.findByEmailAndStatus(request.getEmail(), User.Status.VERIFIED)
                                .orElseThrow();

                var jwtToken = jwtService.generateToken(user);
                return AuthenticationResponse.builder()
                                .token(jwtToken)
                                .userId(user.getId())
                                .build();
        }

}
