package vn.edu.hust.volunteer_backend.service;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import vn.edu.hust.volunteer_backend.model.Fanpage;
import vn.edu.hust.volunteer_backend.model.FanpageRepository;

import java.util.List;


@Service
@AllArgsConstructor
public class FanpageService {
    FanpageRepository fanpageRepository;

    public List<Fanpage> getAllFanpage() {
        return fanpageRepository.findAll();
    }

    public List<Fanpage> getFanpageByLeaderId(int leaderId) {
        return fanpageRepository.findFanpageByLeaderId(leaderId);
    }

    public Fanpage getFanpageById(int id) {
        return fanpageRepository.findById(id).orElseThrow();
    }

    public Fanpage saveFanpage(Fanpage fanpage) {
        return fanpageRepository.save(fanpage);
    }

    public void deleteFanpage(Integer id) throws Exception {
        fanpageRepository.deleteById(id);
    }

    public boolean updateFanpage() {
        // TODO
        return false;
    }
}
