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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "fanpage_name", unique = true)
    @Size(min = 5,max = 100)
    @ValidName
    private String fanpageName;

    @JoinColumn(name = "leader_id")
    private Integer leaderId;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private Fanpage.STATUS status;

    @Column(name = "create_time")
    private Long createTime;

    @Column(name = "subscriber")
    private Integer subscriber;

    @Column(name = "cover_image")
    private String cover_image;

    @Column(name = "description")
    private String description;

    @Column(name = "avatar_image")
    private String avatar_image;

    public void setCoverImage(String url) {
        this.cover_image = url;
    }

    public enum STATUS{
        VERIFIED,
        NOT_VERIFY
    }
}
