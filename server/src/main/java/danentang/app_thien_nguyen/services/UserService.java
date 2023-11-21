package danentang.app_thien_nguyen.services;

import java.util.Optional;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import danentang.app_thien_nguyen.models.DataModels.User;
import danentang.app_thien_nguyen.repositories.UserRepository;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService{
    private final UserRepository userRepository;

    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public Optional<User> findById(Integer userId) {
        return userRepository.findById(userId);
    }

    @Override
      public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("in load user by username " + username);
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
      }
}
