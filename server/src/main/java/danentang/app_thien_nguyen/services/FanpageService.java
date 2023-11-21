package danentang.app_thien_nguyen.services;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import danentang.app_thien_nguyen.models.DataModels.Fanpage;
import danentang.app_thien_nguyen.models.DataModels.User;
import danentang.app_thien_nguyen.repositories.FanpageRepository;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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
        // Cập nhật các trường khác nếu cần

        // Lưu Fanpage đã cập nhật
        return fanpageRepository.save(existingFanpage);

    }

    public List<Fanpage> getFanpagesByUserId(Integer userId) throws Exception {
        return fanpageRepository.findByLeaderId(userId);
    }

}
