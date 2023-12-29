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
@Entity
@Table(name = "reset_password_otp")
public class ResetPasswordOtp {
    @Id
    @Column(name = "email",unique = true)
    public String email;

    @Column(name = "expired")
    public long expired;

    @Column(name = "otp")
    public String OTP;

    protected ResetPasswordOtp(){}

}
