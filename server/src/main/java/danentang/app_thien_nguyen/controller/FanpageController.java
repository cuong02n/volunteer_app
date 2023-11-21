package danentang.app_thien_nguyen.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import danentang.app_thien_nguyen.models.entity.Fanpage;
import danentang.app_thien_nguyen.service.FanpageService;
import danentang.app_thien_nguyen.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

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
            System.out.println("email ----" + request.getAttribute("email"));
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
    public ResponseEntity<?> createFanpage(@RequestBody Fanpage fanpageRequest) {
        System.out.println("in post request fanpage");
        try {
            String leaderIdStr = request.getAttribute("userId").toString();
            Integer leaderId = Integer.valueOf(leaderIdStr);
            // Kiểm tra xem user có tồn tại không nếu ko có thì throw
            // User leader = userService.findById(leaderId).orElseThrow();

            // chỉ lấy các trường sau ở request và tạo fanpage mới
            // {
            // "fanpageName": "string",
            // "status": 0,
            // "createTime": Date,
            // "subscriber": 1000
            // }
            Fanpage newFanpage = Fanpage.builder().fanpageName(fanpageRequest.getFanpageName())
                    .leaderId(leaderId)
                    .status(fanpageRequest.getStatus())
                    .createTime(fanpageRequest.getCreateTime())
                    .subscriber(fanpageRequest.getSubscriber())
                    .build();
            Fanpage fanpage = fanpageService.saveFanpage(newFanpage);

            return new ResponseEntity<>(fanpage, HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "Put fanpages/{id}", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Object> updateFanpage(@PathVariable Integer id, @RequestBody Fanpage fanpageRequest) {
        String userIdStr = request.getAttribute("userId").toString();
        Integer userId = Integer.valueOf(userIdStr);

        System.out.println("=============================");
        System.out.println(fanpageRequest);

        try {

            Fanpage existingFanpage = fanpageService.getFanpageById(id);

            // Kiểm tra xem user/{userId} có sở hữu fanpage này không
            if (!existingFanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("You don't have permission to update this fanpage.");
            }

            // Thực hiện cập nhật thông tin fanpage
            // chỉ lấy các trường sau ở request và sửa fanpage
            // {
            // "fanpageName": "string",
            // "status": 0,
            // "subscriber": 1000
            // }
            Fanpage updatedFanpage = fanpageService.updateFanpage(existingFanpage, fanpageRequest);

            // Trả về đối tượng FanpageResponse đã cập nhật và mã trạng thái OK
            return ResponseEntity.ok(updatedFanpage);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete fanpages/{id}", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<String> deleteFanpage(@PathVariable Integer id) {
        String userIdStr = request.getAttribute("userId").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {
            Fanpage existingFanpage = fanpageService.getFanpageById(id);

            // Kiểm tra xem user/{userId} có quyền sở hữu fanpage này không
            if (!existingFanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("You don't have permission to delete this fanpage.");
            }

            // Thực hiện xóa fanpage
            fanpageService.deleteFanpage(id);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }

        return ResponseEntity.ok("Delete Successfully");
    }
}
