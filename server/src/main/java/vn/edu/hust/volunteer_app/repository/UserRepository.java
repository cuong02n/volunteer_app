package vn.edu.hust.volunteer_app.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hust.volunteer_app.models.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {
  
  Optional<User> findByEmail(String email);
  boolean existsByEmail(String username);
  @Modifying
  @Transactional
  @Query(value = "UPDATE `user` SET `status` = 1 WHERE `email` = ?1",nativeQuery = true)
  void updateUserStatusOK(String email);

}
