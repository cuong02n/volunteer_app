package vn.edu.hust.volunteer_app.service;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.repository.FanpageRepository;
import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.repository.FanpageRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FanpageService {

    private final FanpageRepository fanpageRepository;
    private final UserService userService;

    public List<Fanpage> getAllFanpages() {
        return fanpageRepository.findAll();
    }

    public List<Fanpage> getFanpagesByCriteria(Integer leaderId) {
        Fanpage fanpageExample = new Fanpage();

        if (leaderId != null) {
            fanpageExample.setLeaderId(leaderId);
        }

        System.out.println("in getFanpagesByCriteria");

        ExampleMatcher matcher = ExampleMatcher.matching();
        Example<Fanpage> example = Example.of(fanpageExample, matcher);

        return fanpageRepository.findAll(example);
    }

    public Fanpage getFanpageById(Integer id) {
        return fanpageRepository.findById(id).orElseThrow();
    }

    public Fanpage saveFanpage(Fanpage fanpage) {
        return fanpageRepository.save(fanpage);
    }

    public void deleteFanpage(Integer id) throws Exception {
        fanpageRepository.deleteById(id);
    }

    public Fanpage updateFanpage(Fanpage existingFanpage, Fanpage fanpageRequest) {

        // Thực hiện cập nhật thông tin Fanpage
        existingFanpage.setFanpageName(fanpageRequest.getFanpageName());
        existingFanpage.setSubscriber(fanpageRequest.getSubscriber());
        existingFanpage.setStatus(fanpageRequest.getStatus());
        existingFanpage.setAvatar_image(fanpageRequest.getAvatar_image());
        existingFanpage.setCover_image(fanpageRequest.getCover_image());
        // Cập nhật các trường khác nếu cần

        // Lưu Fanpage đã cập nhật
        return fanpageRepository.save(existingFanpage);

    }

    public List<Fanpage> getFanpagesByUserId(Integer userId) throws Exception {
        return fanpageRepository.findByLeaderId(userId);
    }

}
