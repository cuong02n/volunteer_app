package vn.edu.hust.volunteer_app.service;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.repository.FanpageRepository;
import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.repository.FanpageRepository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FanpageService {

    private final FanpageRepository fanpageRepository;
    private final UserService userService;
    private final CloudinaryImageService cloudinaryImageService;

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

    public Optional<Fanpage> getFanpageById(Integer id) {
        return fanpageRepository.findFanpageById(id);
    }

    public Fanpage saveFanpage(Fanpage fanpage) {
        return fanpageRepository.save(fanpage);
    }

    public void deleteFanpage(Integer id) throws Exception {
        fanpageRepository.deleteById(id);
    }

    public Fanpage updateFanpage(Fanpage existingFanpage, Fanpage fanpageRequest) {

        // Thực hiện cập nhật thông tin Fanpage
        if (fanpageRequest.getFanpageName() != null) {
            existingFanpage.setFanpageName(fanpageRequest.getFanpageName());
        }
        if (fanpageRequest.getSubscriber() != null) {
            existingFanpage.setSubscriber(fanpageRequest.getSubscriber());
        }
        if (fanpageRequest.getStatus() != null) {
            existingFanpage.setStatus(fanpageRequest.getStatus());
        }
        if (fanpageRequest.getAvatar_image() != null) {
            existingFanpage.setAvatar_image(fanpageRequest.getAvatar_image());
        }
        if (fanpageRequest.getCover_image() != null) {
            existingFanpage.setCover_image(fanpageRequest.getCover_image());
        }
        // Cập nhật các trường khác nếu cần

        // Lưu Fanpage đã cập nhật
        return fanpageRepository.save(existingFanpage);

    }

    public List<Fanpage> getFanpagesByUserId(Integer userId) throws Exception {
        return fanpageRepository.findByLeaderId(userId);
    }

    public boolean isExistByName(String fanpageName) {
        return 0!=fanpageRepository.countAllByFanpageNameAndStatus(fanpageName,Fanpage.STATUS.VERIFIED);
    }

    public boolean isExistByNameAndStatus(String fanpageName, Fanpage.STATUS status) {
        return 0!=fanpageRepository.countAllByFanpageNameAndStatus(fanpageName,status);
    }

    public void setFanpageStatusVerified(int fanpageId){
        fanpageRepository.setFanpageStatusById(fanpageId,Fanpage.STATUS.VERIFIED);
    }

    public String setCoverImage(Integer id, MultipartFile file) throws Exception {
        Fanpage fanpage = fanpageRepository.findFanpageById(id).orElseThrow();
        Map<?, ?> data = cloudinaryImageService.upload(file);
        String url = String.valueOf(data.get("url"));
        fanpage.setCover_image(url);
        fanpageRepository.save(fanpage);
        return url;
    }

    public String setAvatarImage(Integer id, MultipartFile file) throws Exception{
        Fanpage fanpage = fanpageRepository.findFanpageById(id).orElseThrow();
        Map<?, ?> data = cloudinaryImageService.upload(file);
        String url = String.valueOf(data.get("url"));
        fanpage.setAvatar_image(url);
        fanpageRepository.save(fanpage);
        return url;
    }
}
