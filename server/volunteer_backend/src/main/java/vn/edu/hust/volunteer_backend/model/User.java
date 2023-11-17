package vn.edu.hust.volunteer_backend.model;

import jakarta.persistence.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import vn.edu.hust.volunteer_backend.util.GsonUtil;

import java.lang.invoke.TypeDescriptor;

@Entity
@Table(name = "user")
public class User {
    private static final Logger logger = LoggerFactory.getLogger(User.class);
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "name")
    private String name;
    @Column(name = "email")
    private String email;
    @Column(name = "password")
    private String password;

    @PrePersist
    public void logNewUserAttempt() {
        logger.info("Attempting to add new user with username: " + email);
    }

    @PostPersist
    public void logNewUserAdded() {
        logger.info("Added user '" + email + "' with ID: " + id);
    }

    @PreRemove
    public void logUserRemovalAttempt() {
        logger.info("Attempting to delete user: " + email);
    }

    @PostRemove
    public void logUserRemoval() {
        logger.info("Deleted user: " + email);
    }

    @PreUpdate
    public void logUserUpdateAttempt() {
        logger.info("Attempting to update user: " + email);
    }

    @PostUpdate
    public void logUserUpdate() {
        logger.info("Updated user: " + email);
    }

    User(){
        logger.info("User Object created");
    }

    @Override
    protected void finalize() throws Throwable {
        logger.info("user has been removed");
        super.finalize();
    }

    @Override
    public String toString() {
        return GsonUtil.toJson(this);
    }
}
