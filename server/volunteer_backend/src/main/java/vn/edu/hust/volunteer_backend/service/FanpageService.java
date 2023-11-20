package vn.edu.hust.volunteer_backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.edu.hust.volunteer_backend.model.Fanpage;
import vn.edu.hust.volunteer_backend.model.FanpageRepository;

import java.util.List;


@Service
public class FanpageService {
    private final FanpageRepository fanpageRepository;

    @Autowired
    public FanpageService(FanpageRepository fanpageRepository, UserService userService) {
        this.fanpageRepository = fanpageRepository;
    }

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
