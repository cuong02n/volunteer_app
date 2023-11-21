package danentang.app_thien_nguyen.service;

import java.util.List;
import java.util.Optional;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import danentang.app_thien_nguyen.models.entity.User;
import danentang.app_thien_nguyen.repository.UserRepository;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService {
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

    public List<User> findAll(){
        return userRepository.findAll();
    }

    public User update(User existingUser, User userRequest) {
    // Thực hiện cập nhật thông tin User, hiện tại chỉ được cập nhật username
        existingUser.setFullname(userRequest.getFullname());
        // Cập nhật các trường khác nếu cần
        System.out.println("existingUser : ");
        System.out.println(existingUser);
        System.out.println("---------------");
        // Lưu User đã cập nhật
        return userRepository.save(existingUser);
    } 

    @Override
    public User loadUserByUsername(String email) throws UsernameNotFoundException {//loadUserByUsername(Dung emails là Username )
        System.out.println("in load user by username " + email);
        return userRepository.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }
}
