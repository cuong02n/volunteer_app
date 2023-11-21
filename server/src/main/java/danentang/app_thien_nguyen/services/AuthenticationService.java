package danentang.app_thien_nguyen.services;

import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import danentang.app_thien_nguyen.models.DataModels.Role;
import danentang.app_thien_nguyen.models.DataModels.User;
import danentang.app_thien_nguyen.models.ReqModels.AuthenticationRequest;
import danentang.app_thien_nguyen.models.ReqModels.RegisterRequest;
import danentang.app_thien_nguyen.models.ResModels.AuthenticationResponse;
import danentang.app_thien_nguyen.repositories.UserRepository;

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
        .username(request.getUsername())
        .email(request.getEmail())
        .password(passwordEncoder.encode(request.getPassword()))
        .role(Role.USER)
        .build();
    repository.save(user);
    var jwtToken = jwtService.generateToken(user);
    return AuthenticationResponse.builder()
        .token(jwtToken)
        .build();
  }

  public AuthenticationResponse authenticate(AuthenticationRequest request) {
    authenticationManager.authenticate(
        new UsernamePasswordAuthenticationToken(
            request.getUsername(),
            request.getPassword()));
    var user = repository.findByUsername(request.getUsername())
        .orElseThrow();
    var jwtToken = jwtService.generateToken(user);
    System.out.println("jwtToken : " + jwtToken);
    return AuthenticationResponse.builder()
        .token(jwtToken)
        .build();
  }
}
