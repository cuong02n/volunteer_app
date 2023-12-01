package vn.edu.hust.volunteer_app.service;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import vn.edu.hust.volunteer_app.config.ApplicationConfig;
import vn.edu.hust.volunteer_app.models.entity.RegisterOtp;
import vn.edu.hust.volunteer_app.models.entity.ResetPasswordOtp;
import vn.edu.hust.volunteer_app.repository.RegisterOtpRepository;
import vn.edu.hust.volunteer_app.repository.ResetPasswordOtpRepository;
import vn.edu.hust.volunteer_app.util.StringUtil;

@Service
@AllArgsConstructor
public class OtpService {
    RegisterOtpRepository registerOtpRepository;
    ResetPasswordOtpRepository resetPasswordOtpRepository;
    EmailService emailService;

    public RegisterOtp generateAndSaveRegisterOTP(String email) {
        RegisterOtp otp = new RegisterOtp(email, System.currentTimeMillis() + ApplicationConfig.EXPIRED_REGISTER_OTP, StringUtil.randomOTP());
        registerOtpRepository.save(otp);
        return otp;
    }

    public ResetPasswordOtp generateAndSaveResetPasswordOTP(String email) {
        ResetPasswordOtp otp = new ResetPasswordOtp(email, System.currentTimeMillis() + ApplicationConfig.EXPIRED_REGISTER_OTP, StringUtil.randomOTP());
        resetPasswordOtpRepository.save(otp);
        return otp;
    }

    public String sendRegisterOTP(RegisterOtp registerOtp) {
        return emailService.send(registerOtp.getEmail(), "OTP for registration Volunteer app", registerOtp.getOTP());
    }

    public void save(RegisterOtp registerOtp) {
        registerOtpRepository.save(registerOtp);
    }

    public boolean checkRegisterOTP(String email, String OTP) {
        return 0 != registerOtpRepository.checkRegisterOTP(email, OTP, System.currentTimeMillis());
    }

    public void destroyRegisterOTP(String email, String OTP) {
        registerOtpRepository.deleteByEmailAndOTP(email, OTP);
    }

    public boolean checkResetPasswordOTP(String email, String OTP) {
        return 0 != resetPasswordOtpRepository.checkResetPasswordOTP(email, OTP, System.currentTimeMillis());
    }

    public void destroyResetPasswordOTP(String email, String OTP) {
        resetPasswordOtpRepository.deleteByEmailAndOTP(email, OTP);
    }
}
