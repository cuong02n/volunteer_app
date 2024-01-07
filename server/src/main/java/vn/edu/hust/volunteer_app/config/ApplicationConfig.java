package vn.edu.hust.volunteer_app.config;

import com.cloudinary.Cloudinary;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Value;
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

import java.awt.event.MouseEvent;
import java.util.HashMap;
import java.util.Map;

@Configuration
@RequiredArgsConstructor
public class ApplicationConfig {
    public static final long EXPIRED_REGISTER_OTP = 2 * 60 * 1000;
    public static final long EXPIRED_RESET_PASSWORD_OTP = 2 * 60 * 1000;
    public static final String[] WHITE_LIST = {
            // "/api/users/**",
            // "/api/events/**",
            // "/api/v1/demo-controller/**",
            // "/test",
            "/api/v1/auth/*",
            "/swagger-ui/**",
            "/v3/api-docs/**",
            "/api/banks/**",
            "/admin/**",
            "/dashboard/**",
            "/*",
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
    public ModelMapper getModelMapper() {
        return new ModelMapper();
    }

    @Bean
    public Cloudinary getCloudinary(
            @Value("${cloudinary.cloud_name}") String cloudName,
            @Value("${cloudinary.api_key}") String apiKey,
            @Value("${cloudinary.api_secret}") String apiSecret) {
        Map config = new HashMap<>();
        config.put("cloud_name", cloudName);
        config.put("api_key", apiKey);
        config.put("api_secret", apiSecret);
        config.put("secure", true);
        return new Cloudinary(config);
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
