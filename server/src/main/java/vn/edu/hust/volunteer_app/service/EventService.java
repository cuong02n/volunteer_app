package vn.edu.hust.volunteer_app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.repository.EventRepository;

import java.util.List;
import java.util.Optional;

@Service
public class EventService {

    private final EventRepository eventRepository;

    @Autowired
    public EventService(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    public List<Event> getVerifiedEvent() {
        return eventRepository.getFanpageByStatus(Event.STATUS.VERIFIED.name());
    }

    public List<Event> getVerifiedEventsByFanpageId(Integer fanpageId) {
        return eventRepository.findEventByFanpageIdAndStatus(fanpageId);
    }

    public void setEventStatusVerified(int eventId) {
        eventRepository.updateStatusById(Event.STATUS.VERIFIED.name(), eventId);
    }

    public void setImageByEventId(int eventId, String imageUrl) {
        Event event = getEventById(eventId).orElseThrow();
        event.setImage(imageUrl);
        saveEvent(event);
    }

    public List<Event> getEventByCriteria(Integer id, String title, String content, Integer minTarget,
            Integer maxTarget, Integer fanpageId, Integer startTime, Integer endTime, Event.STATUS status) {
        return eventRepository.getEventByCriteria(id, title, content, minTarget, maxTarget, fanpageId, startTime,
                endTime, status);
    }

    public Optional<Event> getEventById(Integer eventId) {
        return eventRepository.findById(eventId);
    }

    // Lưu sự kiện
    public Event saveEvent(Event event) {
        return eventRepository.save(event);
    }

    // Update sự kiện
    public Event updateEvent(Event existingEvent, Event eventRequest) {

        if (eventRequest.getTitle() != null)
            existingEvent.setTitle(eventRequest.getTitle());
        if (eventRequest.getContent() != null)
            existingEvent.setContent(eventRequest.getContent());
        if (eventRequest.getTarget() != null)
            existingEvent.setTarget(eventRequest.getTarget());
        if (eventRequest.getStartTime() != null)
            existingEvent.setStartTime(eventRequest.getStartTime());
        if (eventRequest.getEndTime() != null)
            existingEvent.setEndTime(eventRequest.getEndTime());
        if (eventRequest.getProgress() != null)
            existingEvent.setProgress(eventRequest.getProgress());
        if (eventRequest.getBank() != null)
            existingEvent.setBank(eventRequest.getBank());
        if (eventRequest.getBankAccount() != null)
            existingEvent.setBankAccount(eventRequest.getBankAccount());
        return eventRepository.save(existingEvent);
    }

    public void deleteEvent(Integer eventId) {
        eventRepository.deleteById(eventId);
    }

}
