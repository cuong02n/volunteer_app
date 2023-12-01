package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hust.volunteer_app.annotation.ValidImage;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.service.CloudinaryImageService;
import vn.edu.hust.volunteer_app.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final HttpServletRequest request;
    Logger logger = LoggerFactory.getLogger(UserController.class);

    @PostMapping( "/{id}/update_cover_image")
    @Operation(summary = "update User Cover Image", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> updateUserCoverImage(@PathVariable Integer id, @RequestParam("image") @ValidImage MultipartFile file) {
        try {
            String url = userService.setCoverImage(id, file);
            return ResponseEntity.ok(url);
        } catch (Exception e) {
            logger.debug(ExceptionUtils.getStackTrace(e));
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping( "/{id}/update_avatar_image")
    @Operation(summary = "update User Avatar Image", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> updateUserAvatarImage(@PathVariable Integer id, @RequestParam("image") @ValidImage MultipartFile file) {
        try {
            String url = userService.setCoverImage(id, file);
            return ResponseEntity.ok(url);
        } catch (Exception e) {
            logger.debug(ExceptionUtils.getStackTrace(e));
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping
    @Operation(summary = "Get all users", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = userService.findAll();
        return ResponseEntity.ok(users);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get user by id", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> getUserById(@PathVariable Integer id) {
        try {
            User user = userService.findUserById(id).orElseThrow();
            return ResponseEntity.ok(user);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "Put user/{id} , exclude image, email and password, there are other apis", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> updateUser(@PathVariable Integer id, @RequestBody User userRequest) {
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {
            if (!userId.equals(id)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("unauthorized");
            } else {
                User existUser = userService.findUserById(userId).orElseThrow();
                User updatedUser = userService.update(existUser, userRequest);
                return ResponseEntity.ok(updatedUser);
            }

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }


}
