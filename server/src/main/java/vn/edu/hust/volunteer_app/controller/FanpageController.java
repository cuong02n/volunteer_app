package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hust.volunteer_app.annotation.ValidImage;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.service.FanpageService;
import vn.edu.hust.volunteer_app.service.UserService;

import java.util.List;

@RestController
@RequestMapping("/api/fanpages")
@RequiredArgsConstructor
@ResponseBody
public class FanpageController {

    private final FanpageService fanpageService;
    private final UserService userService;
    private final HttpServletRequest request;

    @GetMapping
    @Operation(summary = "Get fanpages", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> getAllFanpages(@RequestParam(name = "userId", required = false) Integer userId) {
        try {
            List<Fanpage> fanpages = fanpageService.getFanpagesByCriteria(userId);
            return ResponseEntity.ok(fanpages);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get fanpages/{id}", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> getFanpageById(@PathVariable Integer id) {
        try {
            Fanpage fanpage = fanpageService.getFanpageById(id).orElseThrow();
            return ResponseEntity.ok(fanpage);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping()
    @Operation(summary = "Create new fanpage", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> createFanpage(@RequestBody Fanpage fanpageRequest) {
        try {
            String leaderIdStr = request.getAttribute("user_id").toString();
            Integer leaderId = Integer.valueOf(leaderIdStr);

            if (fanpageService.isExistByNameAndStatus(fanpageRequest.getFanpageName(), Fanpage.STATUS.VERIFIED)) {
                return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("Name must be unique");
            }

            Fanpage newFanpage = Fanpage.builder()
                    .fanpageName(fanpageRequest.getFanpageName())
                    .leaderId(leaderId)
                    .status(Fanpage.STATUS.NOT_VERIFY)
                    .createTime(System.currentTimeMillis())
                    .description(fanpageRequest.getDescription())
                    .build();

            Fanpage fanpage = fanpageService.saveFanpage(newFanpage);

            return new ResponseEntity<>(fanpage, HttpStatus.OK);
        } catch (Exception e) {
//            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "Put fanpages/{id}", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Object> updateFanpage(@PathVariable Integer id, @RequestBody @Valid Fanpage fanpageRequest) {
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {

            Fanpage existingFanpage = fanpageService.getFanpageById(id).orElseThrow();

            if (!existingFanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("You don't have permission to update this fanpage.");
            }

            Fanpage updatedFanpage = fanpageService.updateFanpage(existingFanpage, fanpageRequest);

            return ResponseEntity.ok(updatedFanpage);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete fanpages/{id}", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> deleteFanpage(@PathVariable Integer id) {
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {
            Fanpage existingFanpage = fanpageService.getFanpageById(id).orElseThrow();

            if (!existingFanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("You don't have permission to delete this fanpage.");
            }

            fanpageService.deleteFanpage(id);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }

        return ResponseEntity.ok("Delete Successfully");
    }

    @PostMapping("/admin/verify/{id}")
    @Operation(summary = "admin verify fanpage", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> verifyFanpage(@PathVariable int id) {
        try {
            User user = userService.findUserById((int) request.getAttribute("user_id")).orElseThrow();
            if (user.getRole() != User.Role.ADMIN) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("YOU MUST BE ADMIN");
            }
            Fanpage fanpage = fanpageService.getFanpageById(id).orElseThrow();
            if (fanpage.getStatus() != Fanpage.STATUS.NOT_VERIFY) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
            }
            fanpageService.setFanpageStatusVerified(fanpage.getId());
            return ResponseEntity.status(HttpStatus.OK).body(null);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @RequestMapping( value = "/{id}/update_cover_image",method = RequestMethod.POST,consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "Update Fanpage Cover Image", security = @SecurityRequirement(name = "bearerAuth"),description = "image: Multipart File, require jpg, jpeg or png extension")
    public ResponseEntity<?> updateFanpageCoverImage(@PathVariable Integer id, @RequestParam("image") @ValidImage MultipartFile file) {
        try {
            String url = fanpageService.setCoverImage(id, file);
            return ResponseEntity.ok(url);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @RequestMapping( value = "/{id}/update_avatar_image",method = RequestMethod.POST,consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "Update Fanpage Avatar Image", security = @SecurityRequirement(name = "bearerAuth"),description = "image: Multipart File, require jpg, jpeg or png extension")
    public ResponseEntity<?> updateFanpageAvatarImage(@PathVariable Integer id, @RequestParam("image") @ValidImage MultipartFile file) {
        try {
            String url = fanpageService.setAvatarImage(id, file);
            return ResponseEntity.ok(url);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

}
