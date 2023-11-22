package vn.edu.hust.volunteer_app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
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

    // Lấy danh sách tất cả sự kiện
    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    // Lấy danh sách sự kiện theo trang và kích thước trang
    public List<Event> getEventsByPage(Integer index, Integer pageSize) {
        Page<Event> page = eventRepository.findAll(PageRequest.of(index, pageSize));
        return page.getContent();
    }

    // Lấy danh sách sự kiện theo fanpageId
    public List<Event> getEventsByFanpageId(Integer fanpageId) {
        return eventRepository.findByFanpageId(fanpageId);
    }

    // Lấy một sự kiện theo ID
    public Optional<Event> getEventById(Integer eventId) {
        return eventRepository.findById(eventId);
    }

    // Lưu sự kiện
    public Event saveEvent(Event event) {
        return eventRepository.save(event);
    }

    //Update sự kiện 
    public Event updateEvent(Event existingEvent, Event eventRequest) {

        // Thực hiện cập nhật thông tin Fanpage
        existingEvent.setTitle(eventRequest.getTitle());
        existingEvent.setContent(eventRequest.getContent());
        existingEvent.setTarget(eventRequest.getTarget());
        // Cập nhật các trường khác nếu cần

        // Lưu Fanpage đã cập nhật
        return eventRepository.save(existingEvent);

    }


    // Xóa sự kiện theo ID
    public void deleteEvent(Integer eventId) {
        eventRepository.deleteById(eventId);
    }

    // Các phương thức khác có thể thêm theo nhu cầu của bạn

}
