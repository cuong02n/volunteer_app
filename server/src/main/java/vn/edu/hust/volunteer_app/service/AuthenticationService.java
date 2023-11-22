package vn.edu.hust.volunteer_app.service;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.models.request.AuthenticationRequest;
import vn.edu.hust.volunteer_app.models.request.RegisterRequest;
import vn.edu.hust.volunteer_app.models.response.AuthenticationResponse;
import vn.edu.hust.volunteer_app.repository.UserRepository;

@Service
public class AuthenticationService {
  private final UserRepository repository;
  private final PasswordEncoder passwordEncoder;
  private final JwtService jwtService;
  private final AuthenticationManager authenticationManager;

  public AuthenticationService(UserRepository repository, PasswordEncoder passwordEncoder, JwtService jwtService,
      AuthenticationManager authenticationManager) {
    this.repository = repository;
    this.passwordEncoder = passwordEncoder;
    this.jwtService = jwtService;
    this.authenticationManager = authenticationManager;
  }

  public AuthenticationResponse register(RegisterRequest request) {
    User user = User.builder()
        .fullname(request.getFullname())
        .email(request.getEmail())
        .password(passwordEncoder.encode(request.getPassword()))
        .role(User.Role.USER)
        .build();
    repository.save(user);
    var jwtToken = jwtService.generateToken(user);
    return AuthenticationResponse.builder()
        .token(jwtToken)
        .userId(user.getId())
        .build();
  }

  public AuthenticationResponse authenticate(AuthenticationRequest request) {
    authenticationManager.authenticate(
        new UsernamePasswordAuthenticationToken(
            request.getEmail(),
            request.getPassword()));
    var user = repository.findByEmail(request.getEmail())
        .orElseThrow();
    var jwtToken = jwtService.generateToken(user);
    System.out.println("jwtToken : " + jwtToken);
    return AuthenticationResponse.builder()
        .token(jwtToken)
        .userId(user.getId())
        .build();
  }
}
