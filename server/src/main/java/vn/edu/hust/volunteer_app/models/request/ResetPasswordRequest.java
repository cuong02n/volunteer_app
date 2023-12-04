package vn.edu.hust.volunteer_app.models.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ResetPasswordRequest {
    @Email
    String email;
    @Size(min = 6, max = 6)
    String OTP;
    @Size(min = 6, max = 100)
    String newPassword;
}
