package vn.edu.hust.volunteer_app.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.models.entity.User.Status;


public interface UserRepository extends JpaRepository<User, Integer> {
  @Query("SELECT u FROM User u WHERE u.email = :email AND u.status = :status")
  Optional<User> findByEmailAndStatus(String email,Status status);
  Optional<User> findByEmail(String email);
  boolean existsByEmail(String username);
  @Modifying
  @Transactional
  @Query(value = "update User u set u.status = :status where u.email = :email")
  void updateStatusByEmail(User.Status status, String email);
}
