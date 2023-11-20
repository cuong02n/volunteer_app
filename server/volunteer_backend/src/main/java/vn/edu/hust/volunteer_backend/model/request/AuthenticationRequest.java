package vn.edu.hust.volunteer_backend.model.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AuthenticationRequest {
    String email;
    String password;
}
