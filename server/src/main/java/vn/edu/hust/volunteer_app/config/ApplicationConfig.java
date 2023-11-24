package vn.edu.hust.volunteer_app.config;

import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.repository.UserRepository;
import vn.edu.hust.volunteer_app.service.UserService;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import vn.edu.hust.volunteer_app.repository.UserRepository;
import vn.edu.hust.volunteer_app.service.UserService;

@Configuration
@RequiredArgsConstructor
public class ApplicationConfig {
    public static final long EXPIRED_REGISTER_OTP = 2 * 60 * 1000;
    public static final String[] WHITE_LIST = {
            "/api/events",
            "/test",
            "/api/v1/auth/*",
            "/swagger-ui/**",
            "/v3/api-docs/**"
    };

    private final UserRepository userRepository;
    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(new UserService(userRepository));
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}
