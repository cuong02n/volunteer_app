package vn.edu.hust.volunteer_app.models.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "event")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Event {
    public enum STATUS {
        NOT_VERIFY(0), VERIFIED(1);
        final int code;

        STATUS(int code) {
            this.code = code;
        }

        public int getValue() {
            return code;
        }
    }

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;
    @Column(name = "progress")
    private Integer progress;
    @Column(name = "target", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer target;
    @Column(name = "start_time")
    private Long startTime;
    @Column(name = "end_time")
    private Long endTime;
    @Column(name = "fanpage_id", nullable = false)
    private Integer fanpageId;
    @Column(name = "status", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer status;
    @Column(name = "image")
    private String image;

}
