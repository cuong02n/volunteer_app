package vn.edu.hust.volunteer_app.controller;

import java.util.List;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.service.EventService;
import vn.edu.hust.volunteer_app.service.FanpageService;
import vn.edu.hust.volunteer_app.service.UserService;

@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;
    private final HttpServletRequest request;
    private final FanpageService fanpageService;
    private final UserService userService;

    @GetMapping
    @Operation(summary = "Get events", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<Event>> getEvents(
            @RequestParam(name = "fanpageId", required = false) Integer fanpageId,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "pageSize", required = false, defaultValue = "10") Integer pageSize) {
        try {
//            Validate input parameters
//            if (page < 0 || pageSize <= 0) {
//                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
//            }

            List<Event> events;

            if (fanpageId != null) {
                // If fanpageId is provided, get events for that fanpage
                events = eventService.getEventsByFanpageId(fanpageId);
            } else {
                // If fanpageId is not provided, get all events
                events = eventService.getEventsByPage(page, pageSize);
            }
//            Check if events list is empty
//            if (events.isEmpty()) {
//                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
//            }

            return ResponseEntity.ok(events);
        } catch (Exception e) {
            // Log the exception for debugging purposes
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
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

    @PostMapping("/new_event")
    @Operation(summary = "Post new event", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Event> createEvent(@RequestBody @Valid Event eventRequest) {
        eventRequest.setStatus(0);
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {
            // Kiểm tra xem có Fanpage tồn tại với fanpage_id được cung cấp hay không
            Fanpage fanpage = fanpageService.getFanpageById(eventRequest.getFanpage_id());
            if (fanpage == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
            }

//            System.out.println("fanpage.getLeaderId() :" + fanpage.getLeaderId());
//            System.out.println("userId :" + userId);
//            Kiểm tra xem userId có trùng với leader_id của Fanpage hay không
            if (!fanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
            }

//            Lưu sự kiện nếu tất cả các điều kiện đều đúng
            Event newEvent = eventService.saveEvent(eventRequest);
            return new ResponseEntity<>(newEvent, HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "Put new event", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Event> putEvent(@PathVariable Integer id, @RequestBody Event eventRequest) {
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {
            // Kiểm tra xem sự kiện có tồn tại với id được cung cấp hay không
            Event existingEvent = eventService.getEventById(id).orElse(null);
            if (existingEvent == null) {
                return ResponseEntity.notFound().build();
            }

            // Kiểm tra xem userId có trùng với leader_id của Fanpage của sự kiện hay không
            Fanpage fanpage = fanpageService.getFanpageById(existingEvent.getFanpage_id());
            if (!fanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
            }


            // Lưu sự kiện sau khi cập nhật
            Event updatedEvent = eventService.updateEvent(existingEvent, eventRequest);
            return ResponseEntity.ok(updatedEvent);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
        }
    }

    @PostMapping("/admin/verify/{id}")
    @Operation(summary = "admin verify event")
    public ResponseEntity<Event> verifyEvent(@PathVariable int id) {
        // TODO: check admin role
        Event event = eventService.getEventById(id).orElse(null);
        if (event == null || event.getStatus() != 0) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
        eventService.setEventStatusVerified(event.getId());
        return ResponseEntity.status(HttpStatus.OK).body(null);
    }

}
