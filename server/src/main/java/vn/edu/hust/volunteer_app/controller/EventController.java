package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.service.EventService;
import vn.edu.hust.volunteer_app.service.FanpageService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;
    private final HttpServletRequest request;
    private final FanpageService fanpageService;

    @GetMapping
    @Operation(summary = "Get events", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<Event>> getAllEvents(
            @RequestParam(name = "fanpageId", required = false) Integer fanpageId,
            @RequestParam(name = "page", required = false) Integer page,
            @RequestParam(name = "pageSize", required = false) Integer pageSize) {
        try {
            List<Event> events;
            events = eventService.getAllEvents();
            return ResponseEntity.ok(events);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get events/{id}", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Event> getEventById(@PathVariable Integer id) {
        try {
            Event event = eventService.getEventById(id).orElse(null);
            if (event != null) {
                return ResponseEntity.ok(event);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PostMapping
    @Operation(summary = "Post new event", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Event> createEvent(@RequestBody Event eventRequest) {
        String userIdStr = request.getAttribute("userId").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {
            // Kiểm tra xem có Fanpage tồn tại với fanpage_id được cung cấp hay không
            Fanpage fanpage = fanpageService.getFanpageById(eventRequest.getFanpage_id());
            if (fanpage == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
            }

            System.out.println("fanpage.getLeaderId() :" + fanpage.getLeaderId());
            System.out.println("userId :" + userId);
            // Kiểm tra xem userId có trùng với leader_id của Fanpage hay không
            if (!fanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
            }

            // Lưu sự kiện nếu tất cả các điều kiện đều đúng
            Event newEvent = eventService.saveEvent(eventRequest);
            return new ResponseEntity<>(newEvent, HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
        }
    }
}
