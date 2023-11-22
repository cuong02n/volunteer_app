package vn.edu.hust.volunteer_app.service;

import java.util.Optional;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.repository.UserRepository;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService {
    private final UserRepository userRepository;


    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public void verifiedRegister(String email){
        userRepository.updateUserStatusOK(email);
    }
    public Optional<User> findUserById(Integer userId) {
        return userRepository.findById(userId);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        System.out.println("in load user by email " + email);
        return userRepository.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }
}
