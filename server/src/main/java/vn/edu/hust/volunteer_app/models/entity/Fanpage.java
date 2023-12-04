package vn.edu.hust.volunteer_app.models.entity;

import java.sql.Date;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import vn.edu.hust.volunteer_app.annotation.ValidName;

@Entity
@Table(name = "fanpage")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Fanpage {

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Integer id;

    @Column(name = "fanpage_name", unique = true)
    @ValidName
    @Size(min = 5,max = 100)
    private String fanpageName;

    @JoinColumn(name = "leader_id")
    private Integer leaderId;

    @Column(name = "status")
    @Enumerated
    private Fanpage.STATUS status;

    @Column(name = "create_time")
    private Long createTime;

    @Column(name = "subscriber")
    private Integer subscriber;

    @Column(name = "cover_image", length = 255)
    private String cover_image;

    @Column(name = "avatar_image", length = 255)
    private String avatar_image;

    public enum STATUS{
        VERIFIED,
        NOT_VERIFY
    }
}
