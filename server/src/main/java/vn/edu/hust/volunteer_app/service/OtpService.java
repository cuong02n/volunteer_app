package vn.edu.hust.volunteer_app.service;

import vn.edu.hust.volunteer_app.config.ApplicationConfig;
import vn.edu.hust.volunteer_app.models.entity.RegisterOtp;
import org.springframework.stereotype.Service;
import vn.edu.hust.volunteer_app.util.StringUtil;

@Service
public class OtpService {
    public RegisterOtp generateRegisterOTP(String email){
        return new RegisterOtp(email,System.currentTimeMillis()+ ApplicationConfig.EXPIRED_REGISTER_OTP, StringUtil.randomOTP());
    }

    public boolean sendRegisterOTP(RegisterOtp registerOtp){
        return false;
    }
}
