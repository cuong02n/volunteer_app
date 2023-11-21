package danentang.app_thien_nguyen.models.entity;



import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


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
    private String fanpageName;

    
    @JoinColumn(name = "leader_id")
    private Integer leaderId;

    @Column(name = "status")
    private Integer status;

    @Column(name = "create_time")
    private long createTime;

    @Column(name = "subscriber")
    private Integer subscriber;

    
}
