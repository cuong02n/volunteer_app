package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hust.volunteer_app.annotation.ValidImage;
import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.service.CloudinaryImageService;
import vn.edu.hust.volunteer_app.service.EventService;
import vn.edu.hust.volunteer_app.service.FanpageService;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor
public class EventController {
    Logger logger = LoggerFactory.getLogger(EventController.class);

    private final EventService eventService;
    private final HttpServletRequest request;
    private final FanpageService fanpageService;
    private final CloudinaryImageService cloudinaryImageService;

    /**
     * @param fanpageId : get Event of Fanpage Id, if there is no fanpageId, return all VERIFIED events
     * @return List of VALID EVENT
     */
    @GetMapping("/get_verified_event")
    @Operation(summary = "Get verified EVENT", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<Event>> getVerifiedEvent(
            @RequestParam(name = "fanpageId", required = false) Integer fanpageId) {
        try {
            List<Event> events;

            if (fanpageId != null) {
                events = eventService.getVerifiedEventsByFanpageId(fanpageId);
            } else {
                events = eventService.getVerifiedEvent();
            }
            return ResponseEntity.ok(events);
        } catch (Exception e) {
            logger.error("{}", ExceptionUtils.getStackTrace(e));
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/get_unverified_event")
    @Operation(summary = "Get unverified EVENT", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<Event>> getUnVerifiedEvent(
            @RequestParam(name = "fanpageId", required = false) Integer fanpageId) {
        try {
            List<Event> events;

            if (fanpageId != null) {
                events = eventService.getVerifiedEventsByFanpageId(fanpageId);
            } else {
                events = eventService.getVerifiedEvent();
            }
            return ResponseEntity.ok(events);
        } catch (Exception e) {
            logger.error("{}", ExceptionUtils.getStackTrace(e));
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

    // TODO: verify
    @PostMapping("/{id}/update_image")
    @Operation(summary = "Update Image for Event", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> updateEventImage(@PathVariable Integer id, @RequestParam("image") @ValidImage MultipartFile multipartFile) {
        try {
            Map result = cloudinaryImageService.upload(multipartFile);
            if (result.get("url") != null) {
                String url = String.valueOf(result.get("url"));
                eventService.setImageByEventId(id, url);
                return ResponseEntity.ok().body(url);
            }
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

}
