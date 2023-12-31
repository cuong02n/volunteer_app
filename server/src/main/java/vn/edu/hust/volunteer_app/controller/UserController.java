package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Description;
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
import vn.edu.hust.volunteer_app.util.StringUtil;

import javax.print.attribute.standard.Media;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final HttpServletRequest request;
    Logger logger = LoggerFactory.getLogger(UserController.class);

    @RequestMapping( value = "/{id}/update_cover_image",method = RequestMethod.POST,consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "Update User Cover Image", security = @SecurityRequirement(name = "bearerAuth"),description = "image: Multipart File, require jpg, jpeg or png extension")
    public ResponseEntity<?> updateUserCoverImage(@PathVariable Integer id, @RequestParam("image") @ValidImage MultipartFile file) {
        try {
            String url = userService.setCoverImage(id, file);
            return ResponseEntity.ok(url);
        } catch (Exception e) {
            logger.debug(ExceptionUtils.getStackTrace(e));
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @RequestMapping( value = "/{id}/update_avatar_image",method = RequestMethod.POST,consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "Update User Avatar Image", security = @SecurityRequirement(name = "bearerAuth"),description = "image: Multipart File, require jpg, jpeg or png extension")
    public ResponseEntity<?> updateUserAvatarImage(@PathVariable Integer id, @RequestParam("image") @ValidImage MultipartFile file) {
        try {
            String url = userService.setAvatarImage(id, file);
            return ResponseEntity.ok(url);
        } catch (Exception e) {
            logger.debug(ExceptionUtils.getStackTrace(e));
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping()
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
    @Operation(summary = "Put user/{id} , exclude image, email and password, there are other apis",description = "accept: name only", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> updateUser(@PathVariable Integer id, @RequestBody User userRequest) {
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);
        try {
            if (!userId.equals(id)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("You need to login to get auth token first");
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
