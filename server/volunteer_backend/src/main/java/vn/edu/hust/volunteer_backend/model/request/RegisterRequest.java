package vn.edu.hust.volunteer_backend.model.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterRequest {
    String username;
    String email;
    String password;
}
