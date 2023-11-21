package vn.edu.hust.volunteer_app.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

import vn.edu.hust.volunteer_app.models.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {
  
  Optional<User> findByEmail(String email);
  Optional<User> findByUsername(String username); 
  boolean existsByUsername(String username);
  boolean existsByEmail(String username);
}
