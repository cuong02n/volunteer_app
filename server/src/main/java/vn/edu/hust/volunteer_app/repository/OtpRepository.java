package vn.edu.hust.volunteer_app.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.edu.hust.volunteer_app.models.entity.RegisterOtp;

public interface OtpRepository extends JpaRepository<RegisterOtp,String> {
}
