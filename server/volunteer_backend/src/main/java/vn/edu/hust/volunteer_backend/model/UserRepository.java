package vn.edu.hust.volunteer_backend.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findUserById(int id);
    Optional<User> findUserByEmail(String email);
    boolean existsByEmail(String email);

}