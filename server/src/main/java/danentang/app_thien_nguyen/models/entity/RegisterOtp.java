package danentang.app_thien_nguyen.models.entity;

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
@Table(name = "register_otp")
public class RegisterOtp {
    @Id
    @Column(name = "user_id")
    public String userId;

    @Column(name = "expired")
    public long expired;

    @Column(name = "otp")
    public String OTP;

}
