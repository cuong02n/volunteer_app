package vn.edu.hust.volunteer_app.service;

import lombok.AllArgsConstructor;
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
        userRepository.updateUserStatusOK(email);
    }

    public Optional<User> findUserById(Integer userId) {
        return userRepository.findById(userId);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public String setCoverImage(Integer id, MultipartFile file) throws Exception {
        User user = findUserById(id).orElseThrow();
        Map data = cloudinaryImageService.upload(file);
        String url = String.valueOf(data.get("url"));
        user.setCoverImage(url);
        userRepository.save(user);
        return url;
    }
    public String setAvatarImage(Integer id, MultipartFile file) throws Exception {
        User user = findUserById(id).orElseThrow();
        Map data = cloudinaryImageService.upload(file);
        String url = String.valueOf(data.get("url"));
        user.setAvatarImage(url);
        userRepository.save(user);
        return url;
    }
    public User update(User existingUser, User userRequest) {
        // Thực hiện cập nhật thông tin User, hiện tại chỉ được cập nhật username
        if (userRequest.getName() != null) {
            existingUser.setName(userRequest.getName());
        }
//        if (userRequest.getAvatarImage() != null) {
//            existingUser.setAvatarImage(userRequest.getAvatarImage());
//        }
//        if (userRequest.getCoverImage() != null) {
//            existingUser.setCoverImage(userRequest.getCoverImage());
//        }
        return userRepository.save(existingUser);
    }

    @Override
    public User loadUserByUsername(String email) throws UsernameNotFoundException {// loadUserByUsername(Dung emails là
        // Username )
        return userRepository.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }
}
