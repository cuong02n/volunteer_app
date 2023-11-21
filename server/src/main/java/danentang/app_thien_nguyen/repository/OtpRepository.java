package danentang.app_thien_nguyen.repository;

import danentang.app_thien_nguyen.models.entity.Otp;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OtpRepository extends JpaRepository<Otp,String> {
}
