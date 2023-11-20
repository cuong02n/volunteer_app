package vn.edu.hust.volunteer_backend.service;


import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import vn.edu.hust.volunteer_backend.model.User;
import vn.edu.hust.volunteer_backend.model.UserRepository;

import java.util.Optional;


@Service
public class UserService implements UserDetailsService {

    UserRepository userRepository;

    UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public Optional<User> findById(Integer userId) {
        return userRepository.findById(userId);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<User> user = userRepository.findUserByEmail(username);
        return user.orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }
}
