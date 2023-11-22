package vn.edu.hust.volunteer_app.models.request;

import lombok.Data;

@Data
public class RegisterVerifyRequest {
    String email;
    String otp;
}
