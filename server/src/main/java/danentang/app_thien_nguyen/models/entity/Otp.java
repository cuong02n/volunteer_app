package danentang.app_thien_nguyen.models.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Otp {
    @Id
    @Column(name = "email")
    public String email;

    @Column(name = "expired")
    public long expired;

    @Column(name = "OTP")
    public String OTP;
}
