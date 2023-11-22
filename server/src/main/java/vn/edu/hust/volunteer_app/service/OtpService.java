package vn.edu.hust.volunteer_app.service;

import lombok.AllArgsConstructor;
import vn.edu.hust.volunteer_app.config.ApplicationConfig;
import vn.edu.hust.volunteer_app.models.entity.RegisterOtp;
import org.springframework.stereotype.Service;
import vn.edu.hust.volunteer_app.repository.OtpRepository;
import vn.edu.hust.volunteer_app.util.StringUtil;

@Service
@AllArgsConstructor
public class OtpService {
    OtpRepository otpRepository;
    EmailService emailService;

    public RegisterOtp generateRegisterOTP(String email) {
        return new RegisterOtp(email, System.currentTimeMillis() + ApplicationConfig.EXPIRED_REGISTER_OTP, StringUtil.randomOTP());
    }

    public void sendRegisterOTP(RegisterOtp registerOtp) {
        emailService.send(registerOtp.getEmail(), "OTP for registration Volunteer app", registerOtp.getOTP());
    }

    public void save(RegisterOtp registerOtp) {
        otpRepository.save(registerOtp);
    }

    public boolean checkRegisterOTP(String email, String OTP) {
        return 0 != otpRepository.checkRegisterOTP(email, OTP, System.currentTimeMillis());

    }
}
