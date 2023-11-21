package vn.edu.hust.volunteer_app.models.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "register_otp")
public class RegisterOtp {
    @Id
    @Column(name = "email")
    public String email;

    @Column(name = "expired")
    public long expired;

    @Column(name = "otp")
    public String OTP;

}
