package vn.edu.hust.volunteer_app.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hust.volunteer_app.annotation.ValidImage;
import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.service.CloudinaryImageService;
import vn.edu.hust.volunteer_app.service.EventService;
import vn.edu.hust.volunteer_app.service.FanpageService;
import vn.edu.hust.volunteer_app.service.UserService;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor
public class EventController {
    private final EventService eventService;
    private final HttpServletRequest request;
    private final FanpageService fanpageService;
    private final CloudinaryImageService cloudinaryImageService;
    private final UserService userService;
    private final ModelMapper modelMapper;
    Logger logger = LoggerFactory.getLogger(EventController.class);

    /**
     * @param id        : pass null (ignore in param list) for not filter
     * @param title     : pass null (ignore in param list) for not filter
     * @param content   : pass null (ignore in param list) for not filter
     * @param minTarget : pass null (ignore in param list) for not filter
     * @param maxTarget : pass null (ignore in param list) for not filter
     * @param fanpageId : pass null (ignore in param list) for not filter
     * @param startTime : pass null (ignore in param list) for not filter
     * @param endTime   : pass null (ignore in param list) for not filter
     * @param status    : must be VERIFIED or NOT_VERIFY
     * @return : List Event (Json format) valid with that filter
     */
    @GetMapping("/get_event")
    @Operation(summary = "Get Event by Criteria", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<Event>> getEvent(
            @RequestParam(name = "id", required = false) Integer id,
            @RequestParam(name = "title", required = false) String title,
            @RequestParam(name = "content", required = false) String content,
            @RequestParam(name = "min_target", required = false) Integer minTarget,
            @RequestParam(name = "max_target", required = false) Integer maxTarget,
            @RequestParam(name = "fanpage_id", required = false) Integer fanpageId,
            @RequestParam(name = "start_time", required = false) Integer startTime,
            @RequestParam(name = "end_time", required = false) Integer endTime,
            @RequestParam(name = "status", required = false) Event.STATUS status
    ) {
        try {
            List<Event> events = eventService.getEventByCriteria(id, title, content, minTarget, maxTarget, fanpageId, startTime, endTime, status);
            return ResponseEntity.ok(events);
        } catch (Exception e) {
            logger.error("{}", ExceptionUtils.getStackTrace(e));
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PostMapping("/new_event")
    @Operation(summary = "Post new event", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Event> createEvent(@RequestBody Event.Request requestRecord) {
        System.out.println("check___");
        logger.info("event request is {}",requestRecord);
        Event eventRequest = Event.fromRequest(requestRecord);
        logger.info("event after map is {}",eventRequest);
        Integer userId = (int) request.getAttribute("user_id");
        Fanpage fanpage = fanpageService.getFanpageById(eventRequest.getFanpageId()).orElseThrow();
        System.out.println(requestRecord);
        try {
            if (!fanpage.getLeaderId().equals(userId)) return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
            eventRequest.setStatus(Event.STATUS.NOT_VERIFY);
            eventRequest.setFanpageId(fanpage.getId());
            Event newEvent = eventService.saveEvent(eventRequest);

            return new ResponseEntity<>(newEvent, HttpStatus.OK);
            
        } catch (Exception e) {
            System.out.println("check");
            System.out.println(e.getMessage());;
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "Put event", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<Event> putEvent(@PathVariable Integer id, @RequestBody Event eventRequest) {
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {
            Event existingEvent = eventService.getEventById(id).orElse(null);
            if (existingEvent == null) {
                return ResponseEntity.notFound().build();
            }

            Fanpage fanpage = fanpageService.getFanpageById(existingEvent.getFanpageId()).orElseThrow();
            if (!fanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
            }
            Event updatedEvent = eventService.updateEvent(existingEvent, eventRequest);
            return ResponseEntity.ok(updatedEvent);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
        }
    }

    @PostMapping("/admin/verify/{id}")
    @Operation(summary = "admin verify event", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<?> verifyEvent(@PathVariable int id) {
        User user = userService.findUserById((int) request.getAttribute("user_id")).orElseThrow();
        if (user.getRole() != User.Role.ADMIN) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("YOU MUST BE ADMIN");
        }
        Event event = eventService.getEventById(id).orElse(null);
        if (event == null || event.getStatus() != Event.STATUS.NOT_VERIFY) {
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
            Map<?, ?> result = cloudinaryImageService.upload(multipartFile);
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
