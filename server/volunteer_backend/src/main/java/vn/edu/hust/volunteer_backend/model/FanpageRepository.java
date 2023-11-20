package vn.edu.hust.volunteer_backend.model;

import org.springframework.boot.diagnostics.FailureAnalysis;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FanpageRepository extends JpaRepository<Fanpage,Integer> {
    public Fanpage findFanpageByLeaderId(int leaderId);

}
