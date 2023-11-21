package vn.edu.hust.volunteer_app.repository;

import vn.edu.hust.volunteer_app.models.entity.RegisterOtp;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OtpRepository extends JpaRepository<RegisterOtp,String> {
}
