package vn.edu.hust.volunteer_app.service;

import java.util.List;
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

    public List<User> findAll(){
        return userRepository.findAll();
    }

    public User update(User existingUser, User userRequest) {
    // Thực hiện cập nhật thông tin User, hiện tại chỉ được cập nhật username
        existingUser.setName(userRequest.getName());
        existingUser.setAvatar_image(userRequest.getAvatar_image());
        existingUser.setCover_image(userRequest.getCover_image());
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
