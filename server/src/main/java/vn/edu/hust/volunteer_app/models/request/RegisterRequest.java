package vn.edu.hust.volunteer_app.models.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import vn.edu.hust.volunteer_app.annotation.ValidName;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterRequest {
    @Size(min = 5, max = 100)
    @ValidName
    private String name;
    @Email
    private String email;
    @Size(min = 6,max = 100)
    private String password;
}
