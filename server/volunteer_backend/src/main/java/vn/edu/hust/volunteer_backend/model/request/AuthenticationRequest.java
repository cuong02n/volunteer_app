package vn.edu.hust.volunteer_backend.model.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@AllArgsConstructor
@Getter
@Setter
public class AuthenticationRequest {
    String email;
    String password;
}
