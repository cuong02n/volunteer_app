package vn.edu.hust.volunteer_app.repository;

import org.springframework.data.jpa.repository.Query;
import vn.edu.hust.volunteer_app.models.entity.RegisterOtp;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RegisterOtpRepository extends JpaRepository<RegisterOtp,String> {
    @Query(value = "select count(*) from register_otp r where r.email = ?1 AND r.otp = ?2 AND r.expired >= ?3",nativeQuery = true)
    int checkRegisterOTP(String email, String otp, long max_expired);

    void deleteByEmailAndOTP(String email,String OTP);
}
