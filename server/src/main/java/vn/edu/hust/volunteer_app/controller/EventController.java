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
     *
     * @param id : pass null (ignore in param list) for not filter
     * @param title : pass null (ignore in param list) for not filter
     * @param content : pass null (ignore in param list) for not filter
     * @param minTarget : pass null (ignore in param list) for not filter
     * @param maxTarget : pass null (ignore in param list) for not filter
     * @param fanpageId : pass null (ignore in param list) for not filter
     * @param startTime : pass null (ignore in param list) for not filter
     * @param endTime : pass null (ignore in param list) for not filter
     * @param status : must be 0 or 1,
     *               0 : not verified (use for admin)
     *               1 : verified (use for user)
     *
     * @return : List Event (Json format) valid with that filter
     */
    @GetMapping("/get_event")
    @Operation(summary = "Get Event by Criteria", security = @SecurityRequirement(name = "bearerAuth"))
    public ResponseEntity<List<Event>> getEvent(
            @RequestParam(name = "id",required = false) Integer id,
            @RequestParam(name = "title" ,required = false) String title,
            @RequestParam(name = "content" ,required = false) String content,
            @RequestParam(name = "min_target",required = false) Integer minTarget,
            @RequestParam(name = "max_target",required = false) Integer maxTarget,
            @RequestParam(name = "fanpage_id", required = false) Integer fanpageId,
            @RequestParam(name = "start_time",required = false) Integer startTime,
            @RequestParam(name = "end_time",required = false) Integer endTime,
            @RequestParam(name = "status") Integer status
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
    public ResponseEntity<Event> createEvent(@RequestBody @Valid Event eventRequest) {
        eventRequest.setStatus(0);
        String userIdStr = request.getAttribute("user_id").toString();
        Integer userId = Integer.valueOf(userIdStr);

        try {
            Fanpage fanpage = fanpageService.getFanpageById(eventRequest.getFanpageId());
            if (fanpage == null) return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);

            if (!fanpage.getLeaderId().equals(userId)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);


            // set status to un verify
            eventRequest.setStatus(Event.STATUS.NOT_VERIFY.getValue());

            Event newEvent = eventService.saveEvent(eventRequest);

            return new ResponseEntity<>(newEvent, HttpStatus.OK);
        } catch (Exception e) {
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

            Fanpage fanpage = fanpageService.getFanpageById(existingEvent.getFanpageId());
            if (!fanpage.getLeaderId().equals(userId)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
            }
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
            Map<?,?> result = cloudinaryImageService.upload(multipartFile);
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
