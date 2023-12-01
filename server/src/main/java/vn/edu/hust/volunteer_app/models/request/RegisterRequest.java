package vn.edu.hust.volunteer_app.models.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterRequest {
    @Size(min = 5, max = 100)
    private String name;
    @Email
    private String email;
    @Size(min = 6,max = 100)
    private String password;
}
