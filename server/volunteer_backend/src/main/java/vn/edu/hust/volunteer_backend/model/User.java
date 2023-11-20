package vn.edu.hust.volunteer_backend.model;

import jakarta.jws.soap.SOAPBinding;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.http.RequestEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import vn.edu.hust.volunteer_backend.util.GsonUtil;

import java.lang.invoke.TypeDescriptor;
import java.util.Collection;

@Entity
@Table(name = "user")
@Builder
@Getter
@Setter
public class User implements UserDetails {
    public enum Role{
        USER,
        ADMIN
    }

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

    @Enumerated(EnumType.STRING)
    private Role role;

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

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return false;
    }
}
