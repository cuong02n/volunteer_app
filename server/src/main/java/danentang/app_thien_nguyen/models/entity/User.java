package danentang.app_thien_nguyen.models.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.util.Collection;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "user")
public class User implements UserDetails {
  public enum Role {
    USER,
    ADMIN
  }


  @Id
  @GeneratedValue
  private Integer id;
  private String fullname;
  private String email;
  private String password;
  private String username;//Chỉ khai báo cho hợp lệ chứ không dùng đến

  @Enumerated(EnumType.STRING)
  private Role role;

  @Override
  @JsonIgnore
  public Collection<? extends GrantedAuthority> getAuthorities() {
    return List.of(new SimpleGrantedAuthority(role.name()));
  }

  @Override
  @JsonIgnore
  public String getPassword() {
    return password;
  }

  // @Override
  // public String getUsername() {
  //   return null;
  // }

  //Các trường sau đây chỉ phục vụ cho xác thực, hiện tại chưa cần quan tâm

  @Override
  @JsonIgnore
  public boolean isAccountNonExpired() {
    return true;
  }

  @Override
  @JsonIgnore
  public boolean isAccountNonLocked() {
    return true;
  }

  @Override
  @JsonIgnore
  public boolean isCredentialsNonExpired() {
    return true;
  }

  @Override
  @JsonIgnore
  public boolean isEnabled() {
    return true;
  }

  @Override
  @JsonIgnore//Ignore vì mình không dùng đến Username mà chỉ khai báo cho có
  public String getUsername() {
    return username;
  }
}
