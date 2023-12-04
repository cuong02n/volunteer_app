package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.service.*;

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
    public ResponseEntity<?> getAllFanpages(
            @RequestParam(name = "userId", required = false) Integer userId) {
        try {
            List<Fanpage> fanpages = fanpageService.getFanpagesByCriteria(userId);
            System.out.println(fanpages);
            return ResponseEntity.ok(fanpages);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get fanpages/{id}", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> getFanpageById(@PathVariable Integer id) {
        try {
            Fanpage fanpage = fanpageService.getFanpageById(id);
            return ResponseEntity.ok(fanpage);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping
    @Operation(summary = "Post new fanpage", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> createFanpage(@RequestBody @Valid Fanpage fanpageRequest) {
        System.out.println("in post request fanpage");
        try {
            String leaderIdStr = request.getAttribute("user_id").toString();
            Integer leaderId = Integer.valueOf(leaderIdStr);

            Fanpage newFanpage = Fanpage.builder().fanpageName(fanpageRequest.getFanpageName())
                    .leaderId(leaderId)
                    .status(Fanpage.STATUS.NOT_VERIFY)
                    .createTime(System.currentTimeMillis())
                    .build();
            if(fanpageService.isExistByNameAndStatus(fanpageRequest.getFanpageName(),Fanpage.STATUS.VERIFIED.name())){
                return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("Name must be unique");
            }
            Fanpage fanpage = fanpageService.saveFanpage(newFanpage);

            return new ResponseEntity<>(fanpage, HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "Put fanpages/{id}", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Object> updateFanpage(@PathVariable Integer id, @RequestBody @Valid Fanpage fanpageRequest) {
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {

            Fanpage existingFanpage = fanpageService.getFanpageById(id);

            // Kiểm tra xem user/{userId} có sở hữu fanpage này không
            if (!existingFanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("You don't have permission to update this fanpage.");
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
            Fanpage existingFanpage = fanpageService.getFanpageById(id);

            if (!existingFanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("You don't have permission to delete this fanpage.");
            }

            fanpageService.deleteFanpage(id);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }

        return ResponseEntity.ok("Delete Successfully");
    }
}
