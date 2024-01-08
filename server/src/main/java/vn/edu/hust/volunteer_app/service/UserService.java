package vn.edu.hust.volunteer_app.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.repository.UserRepository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService {

    private final UserRepository userRepository;
    private CloudinaryImageService cloudinaryImageService;

    @Autowired
    public void setCloudinaryImageService(CloudinaryImageService cloudinaryImageService) {
        this.cloudinaryImageService = cloudinaryImageService;
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public void verifiedRegister(String email) {
        userRepository.updateStatusByEmail(User.Status.VERIFIED, email);
    }

    public Optional<User> findUserById(Integer userId) {
        return userRepository.findById(userId);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public String setCoverImage(Integer id, MultipartFile file) throws Exception {
        User user = findUserById(id).orElseThrow();
        Map<?, ?> data = cloudinaryImageService.upload(file);
        String url = String.valueOf(data.get("url"));
        user.setCoverImage(url);
        userRepository.save(user);
        return url;
    }

    public String setAvatarImage(Integer id, MultipartFile file) throws Exception {
        User user = findUserById(id).orElseThrow();
        Map<?, ?> data = cloudinaryImageService.upload(file);
        String url = String.valueOf(data.get("url"));
        user.setAvatarImage(url);
        userRepository.save(user);
        return url;
    }

    public void setNewPassword(String email, String password) {
        User user = loadUserByUsername(email);
        user.setPassword(password);
        userRepository.save(user);
    }

    public User update(User existingUser, User userRequest) {
        if (userRequest.getName() != null) {
            existingUser.setName(userRequest.getName());
        }
        if (userRequest.getDob() != null) {
            existingUser.setDob(userRequest.getDob());
        }
        if (userRequest.getPhone() != null) {
            existingUser.setPhone(userRequest.getPhone());
        }
        if (userRequest.getGender() != null) {
            existingUser.setGender(userRequest.getGender());
        }
        return userRepository.save(existingUser);
    }

    // @Override
    // public User loadUserByUsername(String email) throws UsernameNotFoundException
    // {
    // System.out.println("in loadUserByUsername");
    // return userRepository.findByEmailAndStatus(email,
    // User.Status.VERIFIED.name())
    // .orElseThrow(() -> new UsernameNotFoundException("User not found"));

    // }

    @Override
    public User loadUserByUsername(String email) throws UsernameNotFoundException {
        System.out.println("in load user by username 1 " + email);
        System.out.println(userRepository);
        User user = userRepository.findByEmail(email).orElseThrow();
        System.out.println(user);
        System.out.println("in load user by username 2 " + email);
        return userRepository.findByEmail(email).orElseThrow();
    }
}
