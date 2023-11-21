package danentang.app_thien_nguyen.repositories;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

import danentang.app_thien_nguyen.models.DataModels.User;

public interface UserRepository extends JpaRepository<User, Integer> {
  
  Optional<User> findByEmail(String email);
  Optional<User> findByUsername(String username); 
  boolean existsByUsername(String username);
  boolean existsByEmail(String username);
}
