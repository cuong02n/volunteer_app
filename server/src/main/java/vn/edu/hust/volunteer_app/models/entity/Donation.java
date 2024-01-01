package vn.edu.hust.volunteer_app.models.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "donation")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Donation {

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Integer id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "event_id")
    private Integer eventId;

    @Column(name = "money")
    private Integer money;

    @Column(name = "message")
    private String message;

    @Column(name = "time_stamp")
    private Long timeStamp;
}
